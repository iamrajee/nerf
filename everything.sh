#!/bin/bash

echo "============================== START ============================="
echo "$(date|awk '{print $4}')" "parameter_reading" >> log.txt
video_url="${1:-https://drive.google.com/file/d/1Ppf5Y0_0_K_yM5LVeYnI1ZHKxzD-2VKQ/view?usp=sharing}"
iter="${2:-30000}"
fps="${3:-3}"
save_fps="${4:-3}"
video_name="${5:-test}" #doubt, dynamic?
project_name="${6:-$video_name}"

echo "============================== Update ============================="
echo "$(date|awk '{print $4}')" "update_and_install_conda_python" > log.txt
sudo apt update -y
sudo apt install python3-pip -y
sudo apt install python-is-python3 -y
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh
bash ~/miniconda.sh -b -p $HOME/miniconda

echo "============================== Clone ============================="
echo "$(date|awk '{print $4}')" "clone_gsplat" >> log.txt
git clone https://github.com/graphdeco-inria/gaussian-splatting --recursive

echo "============================== plyfile ============================="
echo "$(date|awk '{print $4}')" "install_plyfile" >> log.txt 
pip install -q plyfile

echo "============================== CD ============================="
echo "$(date|awk '{print $4}')" "cd_gsplatting" >> log.txt 
cd gaussian-splatting

echo "$(date|awk '{print $4}')" "configure_conda" >> ../log.txt 
export PATH="/root/miniconda/bin:$PATH"
conda init bash
eval "$(cat ~/.bashrc | tail -n +10)" #source ~/.bashrc
conda env create --file environment.yml -y
conda activate gaussian_splatting

echo "============================== WHL ============================="
echo "$(date|awk '{print $4}')" "install_dgr_knn_whl" >> ../log.txt 
pip install https://huggingface.co/camenduru/gaussian-splatting/resolve/main/diff_gaussian_rasterization-0.0.0-cp310-cp310-linux_x86_64.whl
pip install https://huggingface.co/camenduru/gaussian-splatting/resolve/main/simple_knn-0.0.0-cp310-cp310-linux_x86_64.whl

echo "============================== DATA Prep ============================="
echo "$(date|awk '{print $4}')" "data_prep" >> ../log.txt
sudo apt install colmap  -y
mkdir -p data/$project_name/input
sudo apt install ffmpeg -y
conda update ffmpeg -y
sudo apt install yt-dlp -y
sudo apt update -y
sudo apt upgrade -y
cd data/$project_name/input
yt-dlp $video_url
cd ../../../
ffmpeg -i data/$project_name/input/* -qscale:v 1 -qmin 1 -vf fps=$fps data/$project_name/input/%04d.jpg -y
python3 convert.py -s data/$project_name/ --no_gpu 

echo "============================== TRAIN ============================="
echo "$(date|awk '{print $4}')" "training" >> ../log.txt
export OAR_JOB_ID=$project_name #may not work
#OAR_JOB_ID=project_name #may not work
#python3 -c "import os; os.environ['OAR_JOB_ID'] =str('$project_name'); print('OAR_JOB_ID worked: ' + os.environ['OAR_JOB_ID'])"
source ~/.bashrc
conda activate gaussian_splatting
python3 train.py -s data/$project_name/ --iterations $iter
output_folder=$project_name #if not then: output_folder="*"

echo "============================== RENDER ============================="
echo "$(date|awk '{print $4}')" "render" >> ../log.txt
python3 render.py -m output/$output_folder

echo "============================== Genrate Video ============================="
echo "$(date|awk '{print $4}')" "generate rendered video" >> ../log.txt
ffmpeg -framerate $save_fps -i output/$output_folder/train/ours_$iter/renders/%05d.png -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -c:v libx264 -r 3 -pix_fmt yuv420p output/$output_folder/renders.mp4 -y
ffmpeg -framerate $save_fps -i output/$output_folder/train/ours_$iter/gt/%05d.png -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -c:v libx264 -r 3 -pix_fmt yuv420p output/$output_folder/gt.mp4 -y

echo "$(date|awk '{print $4}')" "process complete you may download the result by runing scp in local host" >> ../log.txt
echo "============================== END ============================="
echo 'public_ip=[YOUR-VM-PUBLIC-IP]'
echo 'local_download_folder="."'
echo 'scp -r root@$public_ip:/root/nerf/gaussian-splatting/output $local_download_folder #for downloading everything'
echo 'scp -r root@$public_ip:/root/nerf/gaussian-splatting/output/point_cloud/iteration_$iter/point_cloud.ply $local_download_folder'
echo 'scp -r root@$public_ip:/root/nerf/gaussian-splatting/output/renders.mp4 $local_download_folder'
echo 'scp -r root@$public_ip:/root/nerf/gaussian-splatting/output/gt.mp4 $local_download_folder'
#echo 'scp -r root@$public_ip:'"$(pwd)"'/output/gt.mp4 $local_download_folder'
echo -e "\n\n------------------------------------------------------------------------------------------------\n\n\a"
cat ../log.txt

sudo apt update -y
sudo apt install python3-pip -y
sudo apt install python-is-python3 -y
./0_install_conda.sh
./1_clone_gsplat.sh
./2_install_plyfile.sh
./3_cd_gs.sh 
. ../4_install_dgr_knn_whl.sh #probably doesn't work?
. ../5_download_data_folder.sh

export PATH="/root/miniconda/bin:$PATH"
conda init bash
source ~/.bashrc
conda env create --file environment.yml
conda activate gaussian_splatting

. ../6_run_training.sh
. ../7_rendeer.sh

sudo apt install ffmpeg -y
. ../8_generate_video.sh


# export PATH="/root/miniconda/bin:$PATH" #everytime after reboot

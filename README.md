git clone https://github.com/iamrajee/nerf/  
cd nerf  
chmod +x *.sh  
./run_all.sh  

# Download results
export public-ip=[YOUR-VM-PUBLIC-IP]  
scp -r root@$public-ip:/root/nerf/gaussian-splatting/output ~/local_download_folder  
scp -r root@$public-ip:/root/nerf/gaussian-splatting/*.mp4 ~/local_download_folder  

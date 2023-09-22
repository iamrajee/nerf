# Setup VM
git clone https://github.com/iamrajee/nerf/  
cd nerf  
chmod +x *.sh  
./run_all.sh  

# Download results
export public-ip=[YOUR-VM-PUBLIC-IP]  
scp -r root@$public-ip:/root/nerf/gaussian-splatting/output ~/local_download_folder 

# Debug
 ## Error 1: ffmpeg : error loading the shared library libopenh264.so.5  
=> conda update ffmpeg  

## Error 2: qt.qpa.xcb: could not connect to display
run colmap with no gpu flag
 

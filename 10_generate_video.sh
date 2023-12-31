sudo apt install ffmpeg -y
conda update ffmpeg
ffmpeg -framerate 3 -i train/ours_30000/renders/%05d.png -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -c:v libx264 -r 3 -pix_fmt yuv420p /root/nerf/gaussian-splatting/output/renders.mp4
# ffmpeg -framerate 3 -i train/ours_30000/gt/%05d.png -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -c:v libx264 -r 3 -pix_fmt yuv420p /root/nerf/gaussian-splatting/output/gt.mp4 -y

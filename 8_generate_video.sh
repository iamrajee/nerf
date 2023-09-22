!ffmpeg -framerate 3 -i output/*/train/ours_30000/renders/%05d.png -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -c:v libx264 -r 3 -pix_fmt yuv420p renders.mp4
!ffmpeg -framerate 3 -i output/*/train/ours_30000/gt/%05d.png -vf "pad=ceil(iw/2)*2:ceil(ih/2)*2" -c:v libx264 -r 3 -pix_fmt yuv420p gt.mp4 -y

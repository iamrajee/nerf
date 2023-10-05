export OAR_JOB_ID="my_OAR_JOB_ID"

# Convert video to images
#ffmpeg -i {path to video} -qscale:v 1 -qmin 1 -vf fps={frame extraction rate} %04d.jpg

path_to_video="data/foxmp4/input"
!ffmpeg -i $path_to_video/input_video.mp4 -qscale:v 1 -qmin 1 -vf fps=3 $path_to_video/%04d.jpg

/usr/bin/expect -c 'spawn scp -r root@'"$public_ip"':/root/nerf/gaussian-splatting/output/test/point_cloud/ '"$local_download_folder"'; expect "Password:"; send "UZPANN@mjnzx597\n"; interact'

/usr/bin/expect -c 'spawn scp -r root@$public_ip:/root/nerf/gaussian-splatting/output/point_cloud/ $local_download_folder; expect "Password:"; send "UZPANN@mjnzx597\n"; interact'

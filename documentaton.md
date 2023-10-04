export OAR_JOB_ID="my_OAR_JOB_ID"

# Convert video to images
FFMPEG -i {path to video} -qscale:v 1 -qmin 1 -vf fps={frame extraction rate} %04d.jpg

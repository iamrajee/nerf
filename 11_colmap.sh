#!python convert.py -s data/ --no_gpu #should have input dir inside
python colmap2nerf_no_gpu.py --video_in input.mp4 --video_fps 2 --run_colmap --aabb_scale 16

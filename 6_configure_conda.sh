export PATH="/root/miniconda/bin:$PATH"
conda init bash
source ~/.bashrc
cd gaussian-splatting #just precautionary, will not break the code even if we are already there in the folder
conda env create --file environment.yml
conda activate gaussian_splatting

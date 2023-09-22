export PATH="/root/miniconda/bin:$PATH"
conda init bash
source ~/.bashrc
conda env create --file environment.yml
conda activate gaussian_splatting

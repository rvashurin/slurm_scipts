#!/bin/bash

#SBATCH --job-name=sq_en_ru_embeddings     # Job name

#SBATCH --partition=gpu                      # queue name

#SBATCH --mail-type=all                      # mail events (none, begin, end, fail, all)

#SBATCH --mail-user=r.vashurin@skoltech.ru   # where to send mail

#SBATCH --ntasks=1                           # run two task

#SBATCH --cpus-per-task=12                    # number of cpu cores per task

#SBATCH --mem=50000                          # job memory request in megabytes

#SBATCH --gpus=1                             # number of gpus

#SBATCH --time=02-00:00:00                   # time limit hrs:min:sec or dd-hrs:min:sec

#SBATCH --output=/gpfs/gpfs0/r.vashurin/ue_abssum_logs/sq_en_ru_embeddings.log


#module load part

#module load compilers/intel_2018.3.222 gpu/cuda-11.3

module load python/anaconda3

#command part

source activate ue_abssum

cd ~/codebases/ue_abssum_dev_t5

HYDRA_CONFIG_NAME=ood_sq_en_ru_embeddings DEVICE_FOR_DATA_RESTORING="cuda:0" python run_ue_t5.py

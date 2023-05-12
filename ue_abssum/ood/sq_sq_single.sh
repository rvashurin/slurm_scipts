#!/bin/bash

#SBATCH --job-name=sq_sq_single     # Job name

#SBATCH --partition=gpu                      # queue name

#SBATCH --mail-type=all                      # mail events (none, begin, end, fail, all)

#SBATCH --mail-user=r.vashurin@skoltech.ru   # where to send mail

#SBATCH --ntasks=1                           # run two task

#SBATCH --cpus-per-task=12                    # number of cpu cores per task

#SBATCH --mem=70000                          # job memory request in megabytes

#SBATCH --gpus=1                             # number of gpus

#SBATCH --time=01-00:00:00                   # time limit hrs:min:sec or dd-hrs:min:sec

#SBATCH --output=/gpfs/gpfs0/r.vashurin/ue_abssum_logs/sq_sq_single.log


#module load part

#module load compilers/intel_2018.3.222 gpu/cuda-11.3

module load python/anaconda3

#command part

source activate ue_abssum

cd ~/codebases/ue_abssum_ood

HYDRA_CONFIG_PATH=configs/t5/ood MAX_TRAIN_DATA_SIZE=1000 HYDRA_CONFIG_NAME=ood_sq_sq_single DEVICE_FOR_DATA_RESTORING="cuda:0" python run_ue_t5.py

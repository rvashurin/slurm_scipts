#!/bin/bash

#SBATCH --job-name=train_wdsq_large_705526          # Job name

#SBATCH --partition=gpu                      # queue name

#SBATCH --mail-type=all                      # mail events (none, begin, end, fail, all)

#SBATCH --mail-user=r.vashurin@skoltech.ru   # where to send mail

#SBATCH --ntasks=1                           # run two task

#SBATCH --cpus-per-task=12                    # number of cpu cores per task

#SBATCH --mem=70000                          # job memory request in megabytes

#SBATCH --gpus=1                             # number of gpus

#SBATCH --time=01-00:00:00                   # time limit hrs:min:sec or dd-hrs:min:sec

#SBATCH --output=/gpfs/gpfs0/r.vashurin/ue_abssum_logs/train_wdsq_large_705526.log


#module load part

#module load compilers/intel_2018.3.222 gpu/cuda-11.3

module load python/anaconda3

#command part

source activate ue_abssum

cd ~/codebases/ue_abssum

HYDRA_CONFIG_PATH=configs/t5/sp/with_prefix_tree HYDRA_CONFIG_NAME=train_t5_large_wdsq_705526 python train_t5.py

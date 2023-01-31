#!/bin/bash

#SBATCH --job-name=mod_dnn_eval              # Job name

#SBATCH --partition=gpu_devel                # Queue name

#SBATCH --mail-type=ALL                      # Mail events (NONE, BEGIN, END, FAIL, ALL)

#SBATCH --mail-user=r.vashurin@skoltech.ru   # Where to send mail

#SBATCH --nodes=1                            # Run all processes on a single node

#SBATCH --ntasks=1                           # Run two task

#SBATCH --cpus-per-task=4                    # Number of CPU cores per task

#SBATCH --mem=10000                          # Job memory request in Megabytes

#SBATCH --gpus=1                             # Number of GPUs

#SBATCH --time=00-04:00:00                   # Time limit hrs:min:sec or dd-hrs:min:sec

#SBATCH --output=/gpfs/gpfs0/r.vashurin/mod_dnn_eval.log     # Standard output and error log



#MODULE LOAD PART

module load compilers/intel_2018.3.222 gpu/cuda-11.3 python/anaconda3

#COMMAND PART

source activate /trinity/home/r.vashurin/.conda/mimo

/trinity/home/r.vashurin/codebases/modulated_dnn/eval_dropout.sh

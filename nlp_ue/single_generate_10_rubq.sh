#!/bin/bash

#SBATCH --job-name=mgenre_single_10_rubq     # Job name

#SBATCH --partition=gpu                      # queue name

#SBATCH --mail-type=all                      # mail events (none, begin, end, fail, all)

#SBATCH --mail-user=r.vashurin@skoltech.ru   # where to send mail

#SBATCH --nodes=1                            # run all processes on a single node

#SBATCH --ntasks=1                           # run two task

#SBATCH --cpus-per-task=4                    # number of cpu cores per task

#SBATCH --mem=60000                          # job memory request in megabytes

#SBATCH --gpus=1                             # number of gpus

#SBATCH --time=00-10:00:00                   # time limit hrs:min:sec or dd-hrs:min:sec

#SBATCH --output=/gpfs/gpfs0/r.vashurin/mgenre_logs/single_10_rubq.log


#module load part

module load compilers/intel_2018.3.222 gpu/cuda-11.3 python/anaconda3

#command part

source activate mgenre

cd ~/codebases/nlp_ue/mGENRE/mGENRE_eop

python mgenre_single_generate.py spacy rubq 10

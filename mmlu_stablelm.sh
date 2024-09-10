#!/bin/bash

#SBATCH --job-name=mmlu_stablelm

#SBATCH --qos=gpu-12

#SBATCH --partition=long                      # queue name

#SBATCH --mail-type=all                      # mail events (none, begin, end, fail, all)

#SBATCH --mail-user=Roman.Vashurin@mbzuai.ac.ae   # where to send mail

#SBATCH --nodes=1

#SBATCH --mem-per-cpu=100000                         # job memory request in megabytes

#SBATCH --gres=gpu:4                             # number of gpus

#SBATCH --time=02-00:00:00                   # time limit hrs:min:sec or dd-hrs:min:sec

#SBATCH --output=/home/maxim.panov/mmlu_stablelm.log


module load anaconda3

#command part

source activate lm_polygraph

cd /home/maxim.panov/workspace/polygraph_tacl

HYDRA_CONFIG=`pwd`/examples/configs/polygraph_eval_mmlu.yaml polygraph_eval model.path=stabilityai/stablelm-2-12b batch_size=1

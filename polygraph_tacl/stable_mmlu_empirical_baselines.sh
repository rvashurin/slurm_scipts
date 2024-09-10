#!/bin/bash

#SBATCH --job-name=stable_mmlu_empirical_baselines

#SBATCH --qos=gpu-12

#SBATCH --partition=long                      # queue name

#SBATCH --mail-type=all                      # mail events (none, begin, end, fail, all)

#SBATCH --mail-user=Roman.Vashurin@mbzuai.ac.ae   # where to send mail

#SBATCH --nodes=1

#SBATCH --mem-per-cpu=100000                         # job memory request in megabytes

#SBATCH --gres=gpu:4                             # number of gpus

#SBATCH --time=00-48:00:00                   # time limit hrs:min:sec or dd-hrs:min:sec

#SBATCH --output=/l/users/maxim.panov/log/tacl_instruct/stable_mmlu_empirical_baselines.log


module load anaconda3

#command part

source activate lm_polygraph_empirical

cd /home/maxim.panov/workspace_vashurin/lm-polygraph-empirical

HF_HOME=/l/users/maxim.panov/cache HYDRA_CONFIG=`pwd`/examples/configs/instruct/polygraph_eval_mmlu_empirical_baselines.yaml polygraph_eval model=stablelm-2-12b-chat batch_size=2 cache_path=/l/users/maxim.panov/cache

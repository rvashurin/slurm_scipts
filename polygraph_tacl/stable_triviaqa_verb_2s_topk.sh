#!/bin/bash

#SBATCH --job-name=stable_triviaqa_verb_2s_topk

#SBATCH --qos=gpu-12

#SBATCH --partition=long                      # queue name

#SBATCH --mail-type=all                      # mail events (none, begin, end, fail, all)

#SBATCH --mail-user=Roman.Vashurin@mbzuai.ac.ae   # where to send mail

#SBATCH --nodes=1

#SBATCH --mem-per-cpu=100000                         # job memory request in megabytes

#SBATCH --gres=gpu:4                             # number of gpus

#SBATCH --time=01-11:00:00                   # time limit hrs:min:sec or dd-hrs:min:sec

#SBATCH --output=/l/users/maxim.panov/log/tacl_instruct/stable_triviaqa_verb_2s_topk.log


module load anaconda3

#command part

source activate lm_polygraph

cd /home/maxim.panov/workspace_vashurin/lm-polygraph

HF_HOME=/l/users/maxim.panov/cache HYDRA_CONFIG=`pwd`/examples/configs/instruct/polygraph_eval_triviaqa_verb_2s_topk.yaml polygraph_eval model=stablelm-2-12b-chat batch_size=2 cache_path=/l/users/maxim.panov/cache subsample_eval_dataset=2000

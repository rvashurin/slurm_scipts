#!/bin/bash

#SBATCH --job-name=mistral_triviaqa_sement

#SBATCH --qos=cscc-gpu-qos

#SBATCH --partition=long                      # queue name

#SBATCH --mail-type=all                      # mail events (none, begin, end, fail, all)

#SBATCH --mail-user=Roman.Vashurin@mbzuai.ac.ae   # where to send mail

#SBATCH --nodes=1

#SBATCH --mem-per-cpu=100000                         # job memory request in megabytes

#SBATCH --gres=gpu:4                             # number of gpus

#SBATCH --time=00-24:00:00                   # time limit hrs:min:sec or dd-hrs:min:sec

#SBATCH --output=/l/users/maxim.panov/log/tacl_instruct/mistral_triviaqa_sement


module load anaconda3

#command part

source activate lm_polygraph

cd /home/maxim.panov/workspace_vashurin/polygraph_sement

pip install -e .

HF_HOME=/l/users/maxim.panov/cache HYDRA_CONFIG=`pwd`/examples/configs/polygraph_eval_triviaqa_sement.yaml polygraph_eval batch_size=1 cache_path=/l/users/maxim.panov/cache subsample_eval_dataset=2000 model.path='mistral-community/Mistral-7B-v0.2' model.load_model_args.device_map='balanced_low_0' deberta_batch_size=1

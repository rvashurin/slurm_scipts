#!/bin/bash

#SBATCH --job-name=llama_triviaqa_sample_maxprob

#SBATCH --qos=cscc-gpu-qos

#SBATCH --partition=long                      # queue name

#SBATCH --mail-type=all                      # mail events (none, begin, end, fail, all)

#SBATCH --mail-user=Roman.Vashurin@mbzuai.ac.ae   # where to send mail

#SBATCH --nodes=1

#SBATCH --mem-per-cpu=100000                         # job memory request in megabytes

#SBATCH --gres=gpu:4                             # number of gpus

#SBATCH --time=00-24:00:00                   # time limit hrs:min:sec or dd-hrs:min:sec

#SBATCH --output=/l/users/maxim.panov/log/tacl_instruct/llama_triviaqa_sample_maxprob


module load anaconda3

#command part

source activate lm_polygraph

cd /home/maxim.panov/workspace_vashurin/my-polygraph

pip install -e .

HF_HOME=/l/users/maxim.panov/cache HYDRA_CONFIG=`pwd`/examples/configs/polygraph_eval_triviaqa.yaml polygraph_eval batch_size=1 cache_path=/l/users/maxim.panov/cache subsample_eval_dataset=2000 model='llama' model.load_model_args.device_map='balanced_low_0' deberta_batch_size=1

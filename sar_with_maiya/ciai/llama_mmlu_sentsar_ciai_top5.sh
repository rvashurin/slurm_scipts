#!/bin/bash

#SBATCH --job-name=llama_mmlu_sentsar

#SBATCH --qos=cscc-gpu-qos

#SBATCH --partition=long                      # queue name

#SBATCH --mail-type=all                      # mail events (none, begin, end, fail, all)

#SBATCH --mail-user=Roman.Vashurin@mbzuai.ac.ae   # where to send mail

#SBATCH --nodes=1

#SBATCH --mem-per-cpu=100000                         # job memory request in megabytes

#SBATCH --gres=gpu:4                             # number of gpus

#SBATCH --time=03-00:00:00                   # time limit hrs:min:sec or dd-hrs:min:sec

#SBATCH --output=/l/users/maxim.panov/storage_vashurin/log/llama_mmlu_sentsar.log

module load anaconda3

#command part

source activate polygraph_maiya

cd /home/maxim.panov/workspace_vashurin/polygraph_maiya

git checkout sent_sar_variants

PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python HF_HOME=/l/users/maxim.panov/cache HYDRA_CONFIG=`pwd`/examples/configs/polygraph_eval_mmlu_sentsar.yaml polygraph_eval batch_size=1 cache_path=/l/users/maxim.panov/storage_vashurin/polygraph_out deberta_batch_size=1 model=llama +generation_params.top_k=5 entropy_top_k=5

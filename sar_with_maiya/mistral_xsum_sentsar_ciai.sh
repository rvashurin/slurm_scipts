#!/bin/bash

#SBATCH --job-name=mistral_xsum_sentsar

#SBATCH --qos=cscc-gpu-qos

#SBATCH --partition=long                      # queue name

#SBATCH --mail-type=all                      # mail events (none, begin, end, fail, all)

#SBATCH --mail-user=Roman.Vashurin@mbzuai.ac.ae   # where to send mail

#SBATCH --nodes=1

#SBATCH --mem-per-cpu=100000                         # job memory request in megabytes

#SBATCH --gres=gpu:4                             # number of gpus

#SBATCH --time=02-00:00:00                   # time limit hrs:min:sec or dd-hrs:min:sec

#SBATCH --output=/l/users/maxim.panov/storage_vashurin/log/mistral_xsum_sentsar.log

module load anaconda3

#command part

source activate polygraph_maiya

cd /home/maxim.panov/workspace_vashurin/polygraph_maiya

git checkout sent_sar_variants

pip install -e .

PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python HF_HOME=/l/users/maxim.panov/cache HYDRA_CONFIG=`pwd`/examples/configs/polygraph_eval_xsum_sentsar.yaml polygraph_eval batch_size=1 cache_path=/l/users/maxim.panov/storage_vashurin/polygraph_out subsample_eval_dataset=2000 deberta_batch_size=1 model.path=mistral-community/Mistral-7B-v0.2

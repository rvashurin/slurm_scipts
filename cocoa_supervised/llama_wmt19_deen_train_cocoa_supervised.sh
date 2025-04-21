#!/bin/bash

#SBATCH --job-name=llama_wmt19_deen_train_cocoa_supervised

#SBATCH --qos=cscc-gpu-qos

#SBATCH --partition=long                      # queue name

#SBATCH --mail-type=all                      # mail events (none, begin, end, fail, all)

#SBATCH --mail-user=Roman.Vashurin@mbzuai.ac.ae   # where to send mail

#SBATCH --nodes=1

#Sbatch --cpus-per-task=10                          # number of cores

#SBATCH --mem-per-cpu=20000                         # job memory request in megabytes

#SBATCH --gres=gpu:4                             # number of gpus

#SBATCH --time=03-00:00:00                   # time limit hrs:min:sec or dd-hrs:min:sec

#SBATCH --output=/l/users/maxim.panov/storage_vashurin/log/llama_wmt19_deen_train_cocoa_supervised.log

module load anaconda3

#command part

source activate cocoa_supervised

cd /home/maxim.panov/workspace_vashurin/polygraph_maiya

git checkout cocoa_supervised

PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python HF_HOME=/l/users/maxim.panov/cache HYDRA_CONFIG=`pwd`/examples/configs/polygraph_eval_wmt19_deen_cocoa_supervised.yaml polygraph_eval batch_size=1 eval_split=train cache_path=/l/users/maxim.panov/storage_vashurin/polygraph_out subsample_eval_dataset=6000 deberta_batch_size=1 model=llama

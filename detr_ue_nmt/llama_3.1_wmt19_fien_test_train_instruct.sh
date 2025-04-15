#!/bin/bash

#SBATCH --job-name=llama_3.1_instruct_wmt19_fien_test_train

#SBATCH --qos=cscc-gpu-qos

#SBATCH --partition=long                      # queue name

#SBATCH --mail-type=all                      # mail events (none, begin, end, fail, all)

#SBATCH --mail-user=Roman.Vashurin@mbzuai.ac.ae   # where to send mail

#SBATCH --nodes=1

#SBATCH --cpus-per-task=10

#SBATCH --mem-per-cpu=20000                         # job memory request in megabytes

#SBATCH --gres=gpu:4                             # number of gpus

#SBATCH --time=00-72:00:00                   # time limit hrs:min:sec or dd-hrs:min:sec

#SBATCH --output=/l/users/maxim.panov/log/detr_ue_nmt/llama_3.1_instruct_wmt19_fien_test_train


module load anaconda3

#command part

source activate lm_polygraph

cd /home/maxim.panov/workspace_vashurin/lm-polygraph

git checkout detr_ue_nmt

pip install -e .

TOKENIZERS_PARALLELISM=true OPENBLAS_MAIN_FREE=1 HF_HOME=/l/users/maxim.panov/cache HYDRA_CONFIG=`pwd`/examples/configs/polygraph_eval_wmt19_fien_instruct.yaml polygraph_eval batch_size=1 cache_path=/l/users/maxim.panov/cache model=llama model.path=meta-llama/Meta-Llama-3.1-8B-Instruct subsample_eval_dataset=2000 deberta_batch_size=1 +deberta_device=cuda:0 model.load_model_args.device_map=auto > /l/users/maxim.panov/log/detr_ue_nmt/llama_3.1_instruct_wmt19_fien_test_multigpu.log 2>&1 &

TOKENIZERS_PARALLELISM=true OPENBLAS_MAIN_FREE=1 HF_HOME=/l/users/maxim.panov/cache HYDRA_CONFIG=`pwd`/examples/configs/polygraph_eval_wmt19_fien_instruct.yaml polygraph_eval batch_size=1 cache_path=/l/users/maxim.panov/cache/train model=llama model.path=meta-llama/Meta-Llama-3.1-8B-Instruct subsample_eval_dataset=2000 deberta_batch_size=1 eval_split=train +deberta_device=cuda:0 model.load_model_args.device_map=auto > /l/users/maxim.panov/log/detr_ue_nmt/llama_3.1_instruct_wmt19_fien_train_multigpu.log 2>&1 &

wait

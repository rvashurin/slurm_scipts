#!/bin/bash

#SBATCH --job-name=qwen_2.5_1.5b_wmt19_defien_test_train_multigpu

#SBATCH --qos=cscc-gpu-qos

#SBATCH --partition=long                      # queue name

#SBATCH --mail-type=all                      # mail events (none, begin, end, fail, all)

#SBATCH --mail-user=Roman.Vashurin@mbzuai.ac.ae   # where to send mail

#SBATCH --nodes=1

#SBATCH --mem-per-cpu=20000                         # job memory request in megabytes

#SBATCH --cpus-per-task=10

#SBATCH --gres=gpu:4                             # number of gpus

#SBATCH --time=03-00:00:00                   # time limit hrs:min:sec or dd-hrs:min:sec

#SBATCH --output=/l/users/maxim.panov/log/detr_ue_nmt/qwen_2.5_1.5b_wmt19_defien_test_train_multigpu


module load anaconda3

#command part

source activate lm_polygraph

cd /home/maxim.panov/workspace_vashurin/lm-polygraph

git checkout detr_ue_nmt

pip install -e .


TOKENIZERS_PARALLELISM=true OPENBLAS_MAIN_FREE=1 HF_HOME=/l/users/maxim.panov/cache HYDRA_CONFIG=`pwd`/examples/configs/polygraph_eval_wmt19_deen.yaml polygraph_eval batch_size=1 cache_path=/l/users/maxim.panov/cache model=llama_1b model.path=Qwen/Qwen2.5-1.5B subsample_eval_dataset=2000 deberta_batch_size=1 +deberta_device=cuda:0 model.load_model_args.device_map=cuda:0 > /l/users/maxim.panov/log/detr_ue_nmt/qwen_2.5_1.5b_wmt19_defien_test_train_multigpu_deen.log 2>&1 &

TOKENIZERS_PARALLELISM=true OPENBLAS_MAIN_FREE=1 HF_HOME=/l/users/maxim.panov/cache HYDRA_CONFIG=`pwd`/examples/configs/polygraph_eval_wmt19_deen.yaml polygraph_eval batch_size=1 cache_path=/l/users/maxim.panov/cache model=llama_1b model.path=Qwen/Qwen2.5-1.5B subsample_eval_dataset=2000 deberta_batch_size=1 +deberta_device=cuda:1 model.load_model_args.device_map=cuda:1 eval_split=train > /l/users/maxim.panov/log/detr_ue_nmt/qwen_2.5_1.5b_wmt19_defien_test_train_multigpu_deen_train.log 2>&1 &

TOKENIZERS_PARALLELISM=true OPENBLAS_MAIN_FREE=1 HF_HOME=/l/users/maxim.panov/cache HYDRA_CONFIG=`pwd`/examples/configs/polygraph_eval_wmt19_fien.yaml polygraph_eval batch_size=1 cache_path=/l/users/maxim.panov/cache model=llama_1b model.path=Qwen/Qwen2.5-1.5B subsample_eval_dataset=2000 deberta_batch_size=1 +deberta_device=cuda:2 model.load_model_args.device_map=cuda:2 > /l/users/maxim.panov/log/detr_ue_nmt/qwen_2.5_1.5b_wmt19_defien_test_train_multigpu_fien.log 2>&1 &

TOKENIZERS_PARALLELISM=true OPENBLAS_MAIN_FREE=1 HF_HOME=/l/users/maxim.panov/cache HYDRA_CONFIG=`pwd`/examples/configs/polygraph_eval_wmt19_fien.yaml polygraph_eval batch_size=1 cache_path=/l/users/maxim.panov/cache model=llama_1b model.path=Qwen/Qwen2.5-1.5B subsample_eval_dataset=2000 deberta_batch_size=1 +deberta_device=cuda:3 model.load_model_args.device_map=cuda:3 eval_split=train > /l/users/maxim.panov/log/detr_ue_nmt/qwen_2.5_1.5b_wmt19_defien_test_train_multigpu_fien_train.log 2>&1 &

wait

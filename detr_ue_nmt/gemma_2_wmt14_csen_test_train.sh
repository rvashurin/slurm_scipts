#!/bin/bash

#SBATCH --job-name=gemma_2_wmt14_csen_test_train

#SBATCH --qos=cscc-gpu-qos

#SBATCH --partition=long                      # queue name

#SBATCH --mail-type=all                      # mail events (none, begin, end, fail, all)

#SBATCH --mail-user=Roman.Vashurin@mbzuai.ac.ae   # where to send mail

#SBATCH --nodes=1

#SBATCH --mem-per-cpu=100000                         # job memory request in megabytes

#SBATCH --gres=gpu:4                             # number of gpus

#SBATCH --time=00-24:00:00                   # time limit hrs:min:sec or dd-hrs:min:sec

#SBATCH --output=/l/users/maxim.panov/log/detr_ue_nmt/gemma_2_wmt14_csen_test_train


module load anaconda3

#command part

source activate lm_polygraph

cd /home/maxim.panov/workspace_vashurin/lm-polygraph

git checkout detr_ue_nmt

pip install -e .

TOKENIZERS_PARALLELISM=true OPENBLAS_MAIN_FREE=1 HF_HOME=/l/users/maxim.panov/cache HYDRA_CONFIG=`pwd`/examples/configs/polygraph_eval_wmt14_csen.yaml polygraph_eval batch_size=1 cache_path=/l/users/maxim.panov/cache model=gemma subsample_eval_dataset=2000 deberta_batch_size=1 +deberta_device=cuda:0 model.load_model_args.device_map=auto > /l/users/maxim.panov/log/detr_ue_nmt/gemma_2_wmt14_csruen_test_train_multigpu_csen.log 2>&1 &

TOKENIZERS_PARALLELISM=true OPENBLAS_MAIN_FREE=1 HF_HOME=/l/users/maxim.panov/cache HYDRA_CONFIG=`pwd`/examples/configs/polygraph_eval_wmt14_csen.yaml polygraph_eval batch_size=1 cache_path=/l/users/maxim.panov/cache/train model=gemma subsample_eval_dataset=2000 deberta_batch_size=1 eval_split=train +deberta_device=cuda:2 model.load_model_args.device_map=auto > /l/users/maxim.panov/log/detr_ue_nmt/gemma_2_wmt14_csruen_test_train_multigpu_csen.log 2>&1 &

#!/bin/bash
#SBATCH --job-name=gemma_2_wmt14_deen
#SBATCH --nodes=1                               # Run all processes on a single node
#SBATCH --ntasks=1                              # Run on a single CPU
#SBATCH --mem=40G                               # Total RAM to be used
#SBATCH --cpus-per-task=8                       # Number of CPU cores
#SBATCH --gres=gpu:1                            # Number of GPUs (per node)
#SBATCH -p nlp-dept                             # Use the gpu partition
#SBATCH -q nlp-pool                             # Use the gpu partition
#SBATCH --time=48:00:00                         # Specify the time needed for your experiment
#SBATCH --parsable
#SBATCH --output=/fsx/homes/Roman.Vashurin@mbzuai.ac.ae/logs/gemma_2_wmt14_deen

module load anaconda3

#command part

source activate polygraph

cd /fsx/homes/Roman.Vashurin@mbzuai.ac.ae/workspace/lm-polygraph

git checkout detr_ue_nmt

pip install -e .

HF_HOME=/fsx/hyperpod-output-artifacts/'AROA6GBMFKRI2VWQAUGYI:Roman.Vashurin@mbzuai.ac.ae' HYDRA_CONFIG=`pwd`/examples/configs/polygraph_eval_wmt19_deen.yaml polygraph_eval batch_size=1 model=gemma subsample_eval_dataset=2000 deberta_batch_size=1 cache_path=/fsx/hyperpod-output-artifacts/'AROA6GBMFKRI2VWQAUGYI:Roman.Vashurin@mbzuai.ac.ae'/polygraph_out

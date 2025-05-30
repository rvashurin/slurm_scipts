#!/bin/bash
#SBATCH --job-name=mistral_triviaqa_verb_2s_cot
#SBATCH --nodes=1                               # Run all processes on a single node
#SBATCH --ntasks=1                              # Run on a single CPU
#SBATCH --mem=40G                               # Total RAM to be used
#SBATCH --cpus-per-task=8                       # Number of CPU cores
#SBATCH --gres=gpu:1                            # Number of GPUs (per node)
#SBATCH -p nlp-dept                             # Use the gpu partition
#SBATCH -q nlp-pool                             # Use the gpu partition
#SBATCH --time=48:00:00                         # Specify the time needed for your experiment
#SBATCH --parsable
#SBATCH --nodelist=gpu80-3,gpu80-2
#SBATCH --output=/fsx/homes/Roman.Vashurin@mbzuai.ac.ae/logs/mistral_triviaqa_verb_2s_cot.log

conda activate polygraph

cd ~/workspace/lm-polygraph

HYDRA_CONFIG=`pwd`/examples/configs/instruct/polygraph_eval_triviaqa_verb_2s_cot.yaml polygraph_eval batch_size=2 subsample_eval_dataset=2000

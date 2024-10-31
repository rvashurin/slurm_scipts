#!/bin/bash
#SBATCH --job-name=mistral_trivia_sentsar
#SBATCH --nodes=1                               # Run all processes on a single node
#SBATCH --ntasks=1                              # Run on a single CPU
#SBATCH --mem=40G                               # Total RAM to be used
#SBATCH --cpus-per-task=8                       # Number of CPU cores
#SBATCH --gres=gpu:1                            # Number of GPUs (per node)
#SBATCH -p nlp-dept                             # Use the gpu partition
#SBATCH -q nlp-pool                             # Use the gpu partition
#SBATCH --time=48:00:00                         # Specify the time needed for your experiment
#SBATCH --parsable
#SBATCH --output=/fsx/homes/Roman.Vashurin@mbzuai.ac.ae/logs/mistral_trivia_sentsar

module load anaconda3

#command part

#mkdir -p /fsx/homes/Roman.Vashurin@mbzuai.ac.ae/miniconda3
#wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /fsx/homes/Roman.Vashurin@mbzuai.ac.ae/miniconda3/miniconda.sh
#bash /fsx/homes/Roman.Vashurin@mbzuai.ac.ae/miniconda3/miniconda.sh -b -u -p /fsx/homes/Roman.Vashurin@mbzuai.ac.ae/miniconda3
#rm /fsx/homes/Roman.Vashurin@mbzuai.ac.ae/miniconda3/miniconda.sh

source /fsx/homes/Roman.Vashurin@mbzuai.ac.ae/miniconda3/etc/profile.d/conda.sh
/fsx/homes/Roman.Vashurin@mbzuai.ac.ae/miniconda3/bin/conda activate polygraph

cd /fsx/homes/Roman.Vashurin@mbzuai.ac.ae/workspace/lm-polygraph

#pip install -e .

PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python HF_HOME=/fsx/hyperpod-output-artifacts/'AROA6GBMFKRI2VWQAUGYI:Roman.Vashurin@mbzuai.ac.ae' HYDRA_CONFIG=`pwd`/examples/configs/polygraph_eval_triviaqa_sentsar.yaml polygraph_eval batch_size=1 model.path=mistral-community/Mistral-7B-v0.2 subsample_eval_dataset=2000 deberta_batch_size=1 cache_path=/fsx/hyperpod-output-artifacts/'AROA6GBMFKRI2VWQAUGYI:Roman.Vashurin@mbzuai.ac.ae'/polygraph_out

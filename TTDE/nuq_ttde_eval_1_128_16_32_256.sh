#!/bin/bash

#SBATCH --job-name=nuq_ttde_eval_1_128_16_32_256 # Job name

#SBATCH --partition=cpu                      # queue name

#SBATCH --mail-type=all                      # mail events (none, begin, end, fail, all)

#SBATCH --mail-user=r.vashurin@skoltech.ru   # where to send mail

#SBATCH --nodes=1                            # run all processes on a single node

#SBATCH --ntasks=1                           # run two task

#SBATCH --cpus-per-task=1                    # Number of CPU cores per task

#SBATCH --mem=10000                             # job memory request in megabytes

#SBATCH --time=00-01:00:00                   # time limit hrs:min:sec or dd-hrs:min:sec

#SBATCH --output=/gpfs/gpfs0/r.vashurin/ttde/train_logs/nuq_ttde_train_1_128_16_32_256.log

#module load part

module load compilers/intel_2018.3.222 python/anaconda3

#command part

source activate ttde_ood

cd ~/codebases/TTDE_OOD

/trinity/home/r.vashurin/.conda/envs/ttde_ood/bin/python -m ttde_ood.nuq_ttde.eval_gridsearch --q 1 --m 128 --rank 16 --n-comps 32 --em-steps 10 --noise 0.01 --batch-sz 256 --train-noise 0.01 --lr 0.001 --train-steps 10000 --work-dir /gpfs/gpfs0/r.vashurin/ttde/workdir --train_path /gpfs/gpfs0/r.vashurin/ttde/embeddings/resnet18/cifar10/logits_train_id.npy --ood_test_path /gpfs/gpfs0/r.vashurin/ttde/embeddings/resnet18/cifar10/logits_test_ood.npy --id_test_path /gpfs/gpfs0/r.vashurin/ttde/embeddings/resnet18/cifar10/logits_test_id.npy

#!/bin/bash

#SBATCH --job-name=ttde_eval_2_256_16_128_128                  # Job name

#SBATCH --partition=gpu                      # queue name

#SBATCH --mail-type=all                      # mail events (none, begin, end, fail, all)

#SBATCH --mail-user=r.vashurin@skoltech.ru   # where to send mail

#SBATCH --nodes=1                            # run all processes on a single node

#SBATCH --ntasks=1                           # run two task

#SBATCH --cpus-per-task=4                    # number of cpu cores per task

#SBATCH --mem=10000                          # job memory request in megabytes

#SBATCH --gpus=1                             # number of gpus

#SBATCH --time=00-02:00:00                   # time limit hrs:min:sec or dd-hrs:min:sec

#SBATCH --output=/gpfs/gpfs0/r.vashurin/ttde/eval_logs/eval_2_256_16_128_128.log


#module load part

module load compilers/intel_2018.3.222 gpu/cuda-11.3 python/anaconda3

#command part

source activate ttde

cd ~/codebases/TTDE_OOD

/trinity/home/r.vashurin/.conda/envs/ttde/bin/python -m ttde_ood.ttde.eval --q 2 --m 256 --rank 16 --n-comps 128 --em-steps 10 --noise 0.01 --batch-sz 128 --train-noise 0.01 --lr 0.001 --train-steps 10000 --work-dir /gpfs/gpfs0/r.vashurin/ttde/workdir --train_path /gpfs/gpfs0/r.vashurin/ttde/embeddings/resnet18/cifar10/logits_train_id.npy --ood_test_path /gpfs/gpfs0/r.vashurin/ttde/embeddings/resnet18/cifar10/logits_test_ood.npy --id_test_path /gpfs/gpfs0/r.vashurin/ttde/embeddings/resnet18/cifar10/logits_test_id.npy

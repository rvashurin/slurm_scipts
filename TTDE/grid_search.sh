#!/bin/bash

qs=(1 2)
ms=(64 128 256 512)
ranks=(16 32 64)
n_compss=(32 64 128)
batch_sizes=(32 64 128 256)

for q in "${qs[@]}"
do
  for m in "${ms[@]}"
  do
    for rank in "${ranks[@]}"
    do
      for n_comps in "${n_compss[@]}"
      do
        for batch_size in "${batch_sizes[@]}"
        do
          FILE="/trinity/home/r.vashurin/slurm_scripts/TTDE/ttde_train_${q}_${m}_${rank}_${n_comps}_${batch_size}.sh"

          cat > $FILE <<- EOM
#!/bin/bash

#SBATCH --job-name=ttde_train_${q}_${m}_${rank}_${n_comps}_${batch_size}                  # Job name

#SBATCH --partition=gpu                      # Queue name

#SBATCH --mail-type=ALL                      # Mail events (NONE, BEGIN, END, FAIL, ALL)

#SBATCH --mail-user=r.vashurin@skoltech.ru   # Where to send mail

#SBATCH --nodes=1                            # Run all processes on a single node

#SBATCH --ntasks=1                           # Run two task

#SBATCH --cpus-per-task=4                    # Number of CPU cores per task

#SBATCH --mem=10000                          # Job memory request in Megabytes

#SBATCH --gpus=1                             # Number of GPUs

#SBATCH --time=00-02:00:00                   # Time limit hrs:min:sec or dd-hrs:min:sec

#SBATCH --output=/gpfs/gpfs0/r.vashurin/ttde/train_logs/ttde_train_${q}_${m}_${rank}_${n_comps}_${batch_size}.log

#MODULE LOAD PART

module load compilers/intel_2018.3.222 gpu/cuda-11.3 python/anaconda3

#COMMAND PART
source activate ttde

cd ~/codebases/TTDE

/trinity/home/r.vashurin/.conda/envs/ttde/bin/python -m ttde.train --q $q --m $m --rank $rank --n-comps $n_comps --em-steps 10 --noise 0.01 --batch-sz $batch_size --train-noise 0.01 --lr 0.001 --train-steps 10000 --work-dir /gpfs/gpfs0/r.vashurin/ttde/workdir --train_path /gpfs/gpfs0/r.vashurin/ttde/embeddings/resnet18/cifar10/logits_train_id.npy --test_path /gpfs/gpfs0/r.vashurin/ttde/embeddings/resnet18/cifar10/logits_test_ood.npy
EOM
          sbatch $FILE
        done
      done
    done
  done
done

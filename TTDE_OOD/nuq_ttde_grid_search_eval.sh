#!/bin/bash

#qs=(1 2)
#ms=(64 128 512)
#ranks=(16 32 64)
#n_compss=(32 64 128)
#batch_sizes=(32 64 128 256)

# debug
qs=(1)
ms=(128)
ranks=(16)
n_compss=(32)
batch_sizes=(256)

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
          FILE="/trinity/home/r.vashurin/slurm_scripts/TTDE/nuq_ttde_eval_${q}_${m}_${rank}_${n_comps}_${batch_size}.sh"

          cat > $FILE <<- EOM
#!/bin/bash

#SBATCH --job-name=nuq_ttde_eval_${q}_${m}_${rank}_${n_comps}_${batch_size} # Job name

#SBATCH --partition=cpu                      # queue name

#SBATCH --mail-type=all                      # mail events (none, begin, end, fail, all)

#SBATCH --mail-user=r.vashurin@skoltech.ru   # where to send mail

#SBATCH --nodes=1                            # run all processes on a single node

#SBATCH --ntasks=1                           # run two task

#SBATCH --cpus-per-task=1                    # Number of CPU cores per task

#SBATCH --mem=10000                             # job memory request in megabytes

#SBATCH --time=00-01:00:00                   # time limit hrs:min:sec or dd-hrs:min:sec

#SBATCH --output=/gpfs/gpfs0/r.vashurin/ttde/train_logs/nuq_ttde_train_${q}_${m}_${rank}_${n_comps}_${batch_size}.log

#module load part

module load compilers/intel_2018.3.222 python/anaconda3

#command part

source activate ttde_ood

cd ~/codebases/TTDE_OOD

/trinity/home/r.vashurin/.conda/envs/ttde_ood/bin/python -m ttde_ood.nuq_ttde.eval_gridsearch --q $q --m $m --rank $rank --n-comps $n_comps --em-steps 10 --noise 0.01 --batch-sz $batch_size --train-noise 0.01 --lr 0.001 --train-steps 10000 --work-dir /gpfs/gpfs0/r.vashurin/ttde/workdir --train_path /gpfs/gpfs0/r.vashurin/ttde/embeddings/resnet18/cifar10/logits_train_id.npy --ood_test_path /gpfs/gpfs0/r.vashurin/ttde/embeddings/resnet18/cifar10/logits_test_ood.npy --id_test_path /gpfs/gpfs0/r.vashurin/ttde/embeddings/resnet18/cifar10/logits_test_id.npy
EOM

          sbatch $FILE
        done
      done
    done
  done
done

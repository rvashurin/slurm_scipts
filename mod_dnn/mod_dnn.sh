#!/bin/bash

SHIFT=(0.2 0.4 0.6 0.8)
ENS_SIZE=(1 2 3 5 7 10 15)
WIDTH=(1.0)

for shift_ in "${SHIFT[@]}"
do
  for ens_size in "${ENS_SIZE[@]}"
  do
    for width in "${WIDTH[@]}"
    do
      echo "$shift_ $ens_size $width"
      sbatch /trinity/home/r.vashurin/slurm_scripts/mod_dnn/mod_dnn_1.sh $ens_size $width $shift_
    done
  done
done


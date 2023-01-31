for file in ue_abssum/*
do
  sbatch "$file"
done

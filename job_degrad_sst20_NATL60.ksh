#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -J degrad
#SBATCH -e degrad.e%j
#SBATCH -o degrad.o%j
#SBATCH --time=02:30:00
#SBATCH --exclusive
#SBATCH --constraint=HSW24

NB_NPROC=12

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''


for m in $(seq 1 12); do
	echo './script_compute_degrad_NATL60.ksh NATL60 CJM165 1d sosstsst '$m' 3' >> tmp_compute_degrad3_sst_NATL60-CJM165_m${m}.ksh
	chmod +x tmp_compute_degrad3_sst_NATL60-CJM165_m${m}.ksh
	liste="$liste tmp_compute_degrad3_sst_NATL60-CJM165_m${m}.ksh"
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


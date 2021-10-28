#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=11
#SBATCH -J degrad
#SBATCH -e degrad.e%j
#SBATCH -o degrad.o%j
#SBATCH --time=02:30:00
#SBATCH --exclusive
#SBATCH --constraint=HSW24

NB_NPROC=11

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for m in $(seq 2 12); do
	cp script_compute_degrad3_eNATL60-BLBT02-SSH_MONTH.ksh script_compute_degrad3_eNATL60-BLBT02-SSH_${m}.ksh
	sed -i "s/MONTH/$m/g" script_compute_degrad3_eNATL60-BLBT02-SSH_${m}.ksh
	chmod +x script_compute_degrad3_eNATL60-BLBT02-SSH_${m}.ksh
	liste="$liste script_compute_degrad3_eNATL60-BLBT02-SSH_${m}.ksh"
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


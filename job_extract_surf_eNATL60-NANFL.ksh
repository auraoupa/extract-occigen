#!/bin/bash

#SBATCH --nodes=3
#SBATCH --ntasks=60
#SBATCH -J extract
#SBATCH -e extract.e%j
#SBATCH -o extract.o%j
#SBATCH --time=02:30:00
#SBATCH --exclusive
#SBATCH --constraint=HSW24

NB_NPROC=60 #(= 6 variables * 12 month)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for var in sossheig sozocrtx somecrty sosstsst sosaline; do
	for month in $(seq 1 12); do
		cp script_extract_surf_eNATL60-BLB002_NANFL_VAR_MONTH.ksh extract_surf_eNATL60-BLB002_NANFL_${var}_${month}.ksh
		sed -i "s/MONTH/$month/g" extract_surf_eNATL60-BLB002_NANFL_${var}_${month}.ksh
		chmod +x extract_surf_eNATL60-BLB002_NANFL_${var}_${month}.ksh
		liste="$liste extract_surf_eNATL60-BLB002_NANFL_${var}_${month}.ksh"
	done
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


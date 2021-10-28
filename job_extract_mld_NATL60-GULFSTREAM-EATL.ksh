#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH -J extract2D
#SBATCH -e extract2D.e%j
#SBATCH -o extract2D.o%j
#SBATCH --time=02:30:00
#SBATCH --exclusive
#SBATCH --constraint=HSW24

NB_NPROC=24 #(= 2 regions * 1 variable * 12 month)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for reg in GULSTREAM EATL; do
	for var in somxl010; do
		for month in $(seq 1 12); do
			echo './script_extract_surf_NATL60_1month.ksh '$reg' CJM165 1h '$var' '$month >> tmp_extract_mld_NATL60-CJM165_${reg}_m${month}.ksh
			chmod +x tmp_extract_mld_NATL60-CJM165_${reg}_m${month}.ksh
			liste="$liste ./tmp_extract_mld_NATL60-CJM165_${reg}_m${month}.ksh"
		done
	done
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


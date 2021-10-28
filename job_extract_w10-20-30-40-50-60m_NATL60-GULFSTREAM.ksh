#!/bin/bash

#SBATCH --nodes=3
#SBATCH --ntasks=72
#SBATCH -J extract2D
#SBATCH -e extract2D.e%j
#SBATCH -o extract2D.o%j
#SBATCH --time=02:30:00
#SBATCH --exclusive
#SBATCH --constraint=HSW24

NB_NPROC=72 #(= 1 region * 1 variable * 12 month * 6 levels)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for depth in 10 20 30 40 50 60; do
		for month in $(seq 1 12); do
			echo './script_extract_surf_NATL60_1month-from-my-scratch.ksh GULFSTREAM CJM165 1d vovecrtz '$month' '$depth'm' >> tmp_extract_w${depth}m_NATL60-CJM165_GULFSTREAM_m${month}.ksh
			chmod +x tmp_extract_w${depth}m_NATL60-CJM165_GULFSTREAM_m${month}.ksh
			liste="$liste ./tmp_extract_w${depth}m_NATL60-CJM165_GULFSTREAM_m${month}.ksh"
		done
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


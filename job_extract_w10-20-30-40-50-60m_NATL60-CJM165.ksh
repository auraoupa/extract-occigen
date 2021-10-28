#!/bin/bash

#SBATCH --nodes=3
#SBATCH --ntasks=72
#SBATCH -J extractw
#SBATCH -e extractw.e%j
#SBATCH -o extractw.o%j
#SBATCH --time=11:30:00
#SBATCH --exclusive
#SBATCH --constraint=HSW24

NB_NPROC=72 #(= 1 regions * 1 variables * 12 months * 6 depths)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for depth in 10 20 30 40 50 60; do 
		for month in $(seq 1 12); do
				cp script_extract_DEP_NATL60-CJM165_NATL60_W_MONTH.ksh tmp_script_extract_${depth}_NATL60-CJM165_NATL60_W_${month}.ksh
				sed -i "s/MONTH/$month/g" tmp_script_extract_${depth}_NATL60-CJM165_NATL60_W_${month}.ksh
				sed -i "s/DEP/$depth/g" tmp_script_extract_${depth}_NATL60-CJM165_NATL60_W_${month}.ksh
				chmod +x tmp_script_extract_${depth}_NATL60-CJM165_NATL60_W_${month}.ksh
				liste="$liste ./tmp_script_extract_${depth}_NATL60-CJM165_NATL60_W_${month}.ksh"
		done
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


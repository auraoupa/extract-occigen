#!/bin/bash

#SBATCH --nodes=3
#SBATCH --ntasks=60
#SBATCH -J extract
#SBATCH -e extract.e%j
#SBATCH -o extract.o%j
#SBATCH --time=07:30:00
#SBATCH --exclusive
#SBATCH --constraint=HSW24

NB_NPROC=60 #(= 5 variables * 12 month)
#NB_NPROC=48 #(= 4 variables * 12 month)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for var in sossheig vozocrtx vomecrty sosstsst sosaline; do
#for var in vozocrtx vomecrty sosstsst sosaline; do
	for month in $(seq 1 12); do
		cp script_extract_surf_eNATL60-CJM165_LMX_VAR_MONTH.ksh tmp_script_extract_surf_eNATL60-CJM165_LMX_${var}_${month}.ksh
		sed -i "s/MONTH/$month/g" tmp_script_extract_surf_eNATL60-CJM165_LMX_${var}_${month}.ksh
		sed -i "s/VAR/$var/g" tmp_script_extract_surf_eNATL60-CJM165_LMX_${var}_${month}.ksh
		chmod +x tmp_script_extract_surf_eNATL60-CJM165_LMX_${var}_${month}.ksh
		liste="$liste ./tmp_script_extract_surf_eNATL60-CJM165_LMX_${var}_${month}.ksh"
	done
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


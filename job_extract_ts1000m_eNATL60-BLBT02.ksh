#!/bin/bash

#SBATCH --nodes=2
#SBATCH --ntasks=24
#SBATCH -J extract1000m
#SBATCH -e extract1000m.e%j
#SBATCH -o extract1000m.o%j
#SBATCH --time=01:30:00
#SBATCH --exclusive
#SBATCH --constraint=BDW28

NB_NPROC=24 #(= 12 months * 2 variables)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''


for month in $(seq 1 12); do
	for reg in eNATL60; do
		for var in votemper vosaline ; do
			cp script_extract_1000m_eNATL60-BLBT02_VAR_MONTH.ksh tmp_extract_1000m_eNATL60-BLBT02_${var}_${month}.ksh
			sed -i "s/MONTH/$month/g" tmp_extract_1000m_eNATL60-BLBT02_${var}_${month}.ksh
			sed -i "s/VAR/$var/g" tmp_extract_1000m_eNATL60-BLBT02_${var}_${month}.ksh
			chmod +x tmp_extract_1000m_eNATL60-BLBT02_${var}_${month}.ksh
			liste="$liste ./tmp_extract_1000m_eNATL60-BLBT02_${var}_${month}.ksh"
		done
	done
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


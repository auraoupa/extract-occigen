#!/bin/bash

#SBATCH --nodes=2
#SBATCH --ntasks=48
#SBATCH -J extract2D
#SBATCH -e extract2D.e%j
#SBATCH -o extract2D.o%j
#SBATCH --time=02:30:00
#SBATCH --exclusive
#SBATCH --constraint=HSW24

NB_NPROC=48 #(= 1 regions * 4 variables * 12 month)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for reg in MEDWEST; do
	for var in gridT-2D gridU-2D gridV-2D flxT; do
		for month in $(seq 1 12); do
			cp script_extract_surf_eNATL60-BLBT02_REG_VAR_MONTH.ksh tmp_extract_surf_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			sed -i "s/MONTH/$month/g" tmp_extract_surf_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			sed -i "s/VAR/$var/g" tmp_extract_surf_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			sed -i "s/REG/$reg/g" tmp_extract_surf_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			chmod +x tmp_extract_surf_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			liste="$liste ./tmp_extract_surf_eNATL60-BLBT02_${reg}_${var}_${month}.ksh"
		done
	done
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


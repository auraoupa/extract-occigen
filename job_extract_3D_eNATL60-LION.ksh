#!/bin/bash

#SBATCH --nodes=10
#SBATCH --ntasks=60
#SBATCH -J extract3D
#SBATCH -e extract3D.e%j
#SBATCH -o extract3D.o%j
#SBATCH --time=11:30:00
#SBATCH --exclusive
#SBATCH --constraint=BDW28

NB_NPROC=60 #(= 1 regions * 5 variables * 12 months)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''


for reg in LION; do
	for var in vovecrtz vozocrtx vomecrty votemper vosaline; do
		for month in $(seq 1 12); do
				cp script_extract_3D_eNATL60-BLBT02_REG_VAR_MONTH_LEV1-175.ksh tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
				sed -i "s/MONTH/$month/g" tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
				sed -i "s/VAR/$var/g" tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
				sed -i "s/REG/$reg/g" tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
				chmod +x tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
				liste="$liste ./tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}.ksh"
		done
	done
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


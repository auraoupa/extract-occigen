#!/bin/bash

#SBATCH --nodes=3
#SBATCH --ntasks=5
#SBATCH -J extract3D
#SBATCH -e extract3D.e%j
#SBATCH -o extract3D.o%j
#SBATCH --time=11:30:00
#SBATCH --exclusive
#SBATCH --constraint=BDW28

NB_NPROC=5 #(= 1 regions * 1 variables * 5 months)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''


for reg in SICIL; do
	for var in vovecrtz; do
		for month in  9 10 1 2 3; do
				cp script_extract_3D_eNATL60-BLB002_REG_VAR_MONTH.ksh tmp_extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				sed -i "s/MONTH/$month/g" tmp_extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				sed -i "s/VAR/$var/g" tmp_extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				sed -i "s/REG/$reg/g" tmp_extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				chmod +x tmp_extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				liste="$liste ./tmp_extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh"
		done
	done
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


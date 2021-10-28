#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH -J extract3D
#SBATCH -e extract3D.e%j
#SBATCH -o extract3D.o%j
#SBATCH --time=11:30:00
#SBATCH --exclusive
#SBATCH --constraint=HSW24

NB_NPROC=2 #(= 1 regions * 2 variables * 1 week)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''


for reg in MEDWEST; do
	for var in votemper vosaline; do
		for month in 9; do
			cp script_extract_3D_eNATL60-BLB002_REG_VAR_MONTH_DAYS.ksh extract_3D_eNATL60-BLB002_${reg}_${var}_${month}_1-8.ksh
			sed -i "s/MONTH/$month/g" extract_3D_eNATL60-BLB002_${reg}_${var}_${month}_1-8.ksh
			sed -i "s/DAY1/1/g" extract_3D_eNATL60-BLB002_${reg}_${var}_${month}_1-8.ksh
			sed -i "s/DAY2/8/g" extract_3D_eNATL60-BLB002_${reg}_${var}_${month}_1-8.ksh
			sed -i "s/VAR/$var/g" extract_3D_eNATL60-BLB002_${reg}_${var}_${month}_1-8.ksh
			sed -i "s/REG/$reg/g" extract_3D_eNATL60-BLB002_${reg}_${var}_${month}_1-8.ksh
			chmod +x extract_3D_eNATL60-BLB002_${reg}_${var}_${month}_1-8.ksh
			liste="$liste ./extract_3D_eNATL60-BLB002_${reg}_${var}_${month}_1-8.ksh"
		done
	done
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


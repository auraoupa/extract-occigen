#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=24
#SBATCH -J extract2D
#SBATCH -e extract2D.e%j
#SBATCH -o extract2D.o%j
#SBATCH --time=02:30:00
#SBATCH --exclusive
#SBATCH --constraint=HSW24

NB_NPROC=24 #(= 1 region * 2 variables * 12 month)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

	for var in sozocrtx somecrty ; do
		for month in $(seq 1 12); do
			cp script_extract_surf_eNATL60-BLB002_LABRADOR_VAR_MONTH_h12.ksh tmp_script_extract_surf_eNATL60-BLB002_LABRADOR_${var}_${month}_h12.ksh
			sed -i "s/MONTH/$month/g" tmp_script_extract_surf_eNATL60-BLB002_LABRADOR_${var}_${month}_h12.ksh
			sed -i "s/VAR/$var/g" tmp_script_extract_surf_eNATL60-BLB002_LABRADOR_${var}_${month}_h12.ksh
			chmod +x tmp_script_extract_surf_eNATL60-BLB002_LABRADOR_${var}_${month}_h12.ksh
			liste="$liste ./tmp_script_extract_surf_eNATL60-BLB002_LABRADOR_${var}_${month}_h12.ksh"
		done
	done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


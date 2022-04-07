#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=3
#SBATCH -J extract
#SBATCH -e extract.e%j
#SBATCH -o extract.o%j
#SBATCH --time=00:30:00
#SBATCH --exclusive
#SBATCH --constraint=BDW28

NB_NPROC=3 #(= 1 variables * 3 month)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for var in sometauy; do
	for month in 1 2 3; do
		cp script_extract_surf_eNATL60-BLB002_REG_VAR_MONTH.ksh tmp_extract_surf_eNATL60-BLB002_SICIL_${var}_${month}.ksh
		sed -i "s/MONTH/$month/g" tmp_extract_surf_eNATL60-BLB002_SICIL_${var}_${month}.ksh
		sed -i "s/REG/SICIL/g" tmp_extract_surf_eNATL60-BLB002_SICIL_${var}_${month}.ksh
		sed -i "s/VAR/${var}/g" tmp_extract_surf_eNATL60-BLB002_SICIL_${var}_${month}.ksh
		chmod +x tmp_extract_surf_eNATL60-BLB002_SICIL_${var}_${month}.ksh
		liste="$liste ./tmp_extract_surf_eNATL60-BLB002_SICIL_${var}_${month}.ksh"
	done
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


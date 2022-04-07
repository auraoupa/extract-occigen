#!/bin/bash

#SBATCH --nodes=3
#SBATCH --ntasks=26
#SBATCH -J extract
#SBATCH -e extract.e%j
#SBATCH -o extract.o%j
#SBATCH --time=00:30:00
#SBATCH --exclusive
#SBATCH --constraint=BDW28

NB_NPROC=26 #(= 2 variables * 13 month)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for reg in pDYF; do
	for var in u10 v10; do
		for month in $(seq 1 12) 19; do
			cp script_extract_wind_eNATL60-BLB002_REG_VAR_MONTH.ksh tmp_extract_wind_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			sed -i "s/MONTH/$month/g" tmp_extract_wind_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			sed -i "s/REG/${reg}/g" tmp_extract_wind_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			sed -i "s/VAR/${var}/g" tmp_extract_wind_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			chmod +x tmp_extract_wind_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			liste="$liste ./tmp_extract_wind_eNATL60-BLBT02_${reg}_${var}_${month}.ksh"
		done
	done
done
runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


#!/bin/bash

#SBATCH --nodes=5
#SBATCH --ntasks=120
#SBATCH -J meandaily
#SBATCH -e meandaily.e%j
#SBATCH -o meandaily.o%j
#SBATCH --time=02:30:00
#SBATCH --exclusive
#SBATCH --constraint=HSW24

NB_NPROC=120 #(= 2 regions * 6 variables * 12 month)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for reg in NANFL-degrad MEDWEST-degrad; do
	for var in sossheig sozocrtx somecrty sosstsst sosaline; do
		for month in $(seq 1 12); do
			cp script_mean_daily_eNATL60-BLB002_REG_VAR_MONTH.ksh mean_daily_eNATL60-BLB002_${reg}_${var}_${month}.ksh
			sed -i "s/MONTH/$month/g" mean_daily_eNATL60-BLB002_${reg}_${var}_${month}.ksh
			sed -i "s/VAR/$var/g" mean_daily_eNATL60-BLB002_${reg}_${var}_${month}.ksh
			sed -i "s/REG/$reg/g" mean_daily_eNATL60-BLB002_${reg}_${var}_${month}.ksh
			chmod +x mean_daily_eNATL60-BLB002_${reg}_${var}_${month}.ksh
			liste="$liste mean_daily_eNATL60-BLB002_${reg}_${var}_${month}.ksh"
		done
	done
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


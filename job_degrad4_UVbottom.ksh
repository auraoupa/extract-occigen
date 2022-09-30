#!/bin/bash

#SBATCH --nodes=3
#SBATCH --ntasks=48
#SBATCH -J extract2D
#SBATCH -e extract2D.e%j
#SBATCH -o extract2D.o%j
#SBATCH --time=02:30:00
#SBATCH --exclusive
#SBATCH --constraint=BDW28

NB_NPROC=48 #(= 2 simus * 2 variables * 12 month)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for CASE in BLBT02 BLB002; do
	for var in Ubottom Vbottom; do
		for month in $(seq 1 12); do
			cp make_degrad_UVbottom4_eNATL60.ksh tmp_make_degrad_UVbottom4_eNATL60_${CASE}_${var}_${month}.ksh
			sed -i "s/MONTH/$month/g" tmp_make_degrad_UVbottom4_eNATL60_${CASE}_${var}_${month}.ksh
			sed -i "s/VAR/$var/g" tmp_make_degrad_UVbottom4_eNATL60_${CASE}_${var}_${month}.ksh
			sed -i "s/CASE/$CASE/g" tmp_make_degrad_UVbottom4_eNATL60_${CASE}_${var}_${month}.ksh
			chmod +x tmp_make_degrad_UVbottom4_eNATL60_${CASE}_${var}_${month}.ksh
			liste="$liste ./tmp_make_degrad_UVbottom4_eNATL60_${CASE}_${var}_${month}.ksh"
		done
	done
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


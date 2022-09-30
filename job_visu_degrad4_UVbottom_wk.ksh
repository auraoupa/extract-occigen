#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH -J extract2D
#SBATCH -e extract2D.e%j
#SBATCH -o extract2D.o%j
#SBATCH --time=06:00:00
#SBATCH --exclusive
#SBATCH --constraint=VISU

NB_NPROC=1 #(= 2 simus * 2 variables * 12 month)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for CASE in BLBT02; do
	for var in Ubottom Vbottom; do
		for month in 1; do
			cp make_degrad_UVbottom4_eNATL60_wk.ksh tmp_make_degrad_UVbottom4_eNATL60_${CASE}_${var}_${month}.ksh
			sed -i "s/MONTH/$month/g" tmp_make_degrad_UVbottom4_eNATL60_${CASE}_${var}_${month}.ksh
			sed -i "s/VAR/$var/g" tmp_make_degrad_UVbottom4_eNATL60_${CASE}_${var}_${month}.ksh
			sed -i "s/CASE/$CASE/g" tmp_make_degrad_UVbottom4_eNATL60_${CASE}_${var}_${month}.ksh
			chmod +x tmp_make_degrad_UVbottom4_eNATL60_${CASE}_${var}_${month}.ksh
			liste="$liste ./tmp_make_degrad_UVbottom4_eNATL60_${CASE}_${var}_${month}.ksh"
		done
	done
done

for script in $liste; do
  ./$script
done


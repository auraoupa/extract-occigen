#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH -J extract2D
#SBATCH -e extract2D.e%j
#SBATCH -o extract2D.o%j
#SBATCH --time=06:00:00
#SBATCH --exclusive
#SBATCH --constraint=VISU

liste=''
for reg in eNATL60; do
		for month in 1 10; do
			echo './script_compute_bottom_currents_eNATL60.ksh '$reg' BLBT02 1h '$month >> tmp_compute_uv-bottom_eNATL60-BLBT02_m${month}.ksh
			chmod +x tmp_compute_uv-bottom_eNATL60-BLBT02_m${month}.ksh
			liste="$liste ./tmp_compute_uv-bottom_eNATL60-BLBT02_m${month}.ksh"
		done
done

for script in $liste; do
  ./$script
done

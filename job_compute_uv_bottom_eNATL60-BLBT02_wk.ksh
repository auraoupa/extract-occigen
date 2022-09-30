#!/bin/bash

#SBATCH --nodes=6
#SBATCH --ntasks=12
#SBATCH -J extract2D
#SBATCH -e extract2D.e%j
#SBATCH -o extract2D.o%j
#SBATCH --time=11:00:00
#SBATCH --exclusive
#SBATCH --constraint=BDW28

NB_NPROC=12 #(= 1 regions * 1 variable * 12 month)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for reg in eNATL60; do
		for month in $(seq 1 12); do
			echo './script_compute_bottom_currents_eNATL60_wk.ksh '$reg' BLBT02 1h '$month >> tmp_compute_uv-bottom_eNATL60-BLBT02_m${month}.ksh
			chmod +x tmp_compute_uv-bottom_eNATL60-BLBT02_m${month}.ksh
			liste="$liste ./tmp_compute_uv-bottom_eNATL60-BLBT02_m${month}.ksh"
		done
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


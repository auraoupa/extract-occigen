#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -J extract2D
#SBATCH -e extract2D.e%j
#SBATCH -o extract2D.o%j
#SBATCH --time=02:30:00
#SBATCH --exclusive
#SBATCH --constraint=BDW28

NB_NPROC=12 #(= 1 regions * 1 variable * 12 month)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for reg in DYF; do
		for month in $(seq 1 12); do
			echo './compute_uvgeo_eNATL60_1month.ksh '$reg' BLB002 1h '$month >> tmp_compute_uvgeo_eNATL60-BLB002_m${month}.ksh
			chmod +x tmp_compute_uvgeo_eNATL60-BLB002_m${month}.ksh
			liste="$liste ./tmp_compute_uvgeo_eNATL60-BLB002_m${month}.ksh"
		done
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


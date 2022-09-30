#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=12
#SBATCH -J vertmean
#SBATCH -e vertmean.e%j
#SBATCH -o vertmean.o%j
#SBATCH --time=06:00:00
#SBATCH --exclusive
#SBATCH --constraint=VISU

NB_NPROC=12 
runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }

liste=''

for CASE in BLB002; do
		for month in $(seq 1 12) 19; do
			echo './make_compute_vertmean_BLB002_UV0-10m_byday_1month.ksh '$month >> tmp_compute_UVvertmean0-10m_eNATL60-BLB002_m${month}.ksh
			chmod +x tmp_compute_UVvertmean0-10m_eNATL60-BLB002_m${month}.ksh
			liste="$liste ./tmp_compute_UVvertmean0-10m_eNATL60-BLB002_m${month}.ksh"
		done
done

runcode  $NB_NPROC /work/aalbert/git/DMONTOOLS/MPI_TOOLS/mpi_shell $liste


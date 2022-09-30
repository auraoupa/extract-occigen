#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH -J vertmean
#SBATCH -e vertmean.e%j
#SBATCH -o vertmean.o%j
#SBATCH --time=06:00:00
#SBATCH --exclusive
#SBATCH --constraint=VISU

for CASE in BLB002; do
		for month in $(seq 1 12) 19; do
			echo './compute_vertmean_eNATL60_1month.ksh eNATL60 '$CASE' 1h '$month' 0 10' >> tmp_compute_UVvertmean0-10m_eNATL60-BLB002_m${month}.ksh
			chmod +x tmp_compute_UVvertmean0-10m_eNATL60-BLB002_m${month}.ksh
			./tmp_compute_UVvertmean0-10m_eNATL60-BLB002_m${month}.ksh
		done
done



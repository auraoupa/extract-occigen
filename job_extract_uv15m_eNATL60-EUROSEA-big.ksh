#!/bin/bash

#SBATCH --nodes=2
#SBATCH --ntasks=48
#SBATCH -J extract15m
#SBATCH -e extract15m.e%j
#SBATCH -o extract15m.o%j
#SBATCH --time=11:30:00
#SBATCH --exclusive
#SBATCH --constraint=HSW24

NB_NPROC=48 #(= 2 regions * 2 variables * 12 months)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''


for reg in MEDWEST NANFL; do
	for var in vozocrtx vomecrty ; do
		for month in $(seq 1 12); do
				cp script_extract_15m_eNATL60-BLB002_REG_VAR_MONTH.ksh extract_15m_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				sed -i "s/MONTH/$month/g" extract_15m_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				sed -i "s/VAR/$var/g" extract_15m_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				sed -i "s/REG/$reg/g" extract_15m_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				chmod +x extract_15m_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				liste="$liste ./extract_15m_eNATL60-BLB002_${reg}_${var}_${month}.ksh"
		done
	done
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


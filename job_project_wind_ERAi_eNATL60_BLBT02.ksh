#!/bin/bash

#SBATCH --nodes=2
#SBATCH --ntasks=16
#SBATCH -J project_ERAi
#SBATCH -e project_ERAi.e%j
#SBATCH -o project_ERAi.o%j
#SBATCH --time=06:00:00
#SBATCH --exclusive
#SBATCH --constraint=BDW28

NB_NPROC=16 #(= 1 variables * 16 month)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''


for month in $(seq 1 12) 19 20 21 22; do
	echo './script_project_wind_ERAi_eNATL60_1month.ksh '$month' BLBT02' >> tmp_project_wind_ERAi_eNATL60_mm${month}.ksh
	chmod +x tmp_project_wind_ERAi_eNATL60_mm${month}.ksh
	liste="$liste ./tmp_project_wind_ERAi_eNATL60_mm${month}.ksh"
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


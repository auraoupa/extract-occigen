#!/bin/bash

#SBATCH --nodes=2
#SBATCH --ntasks=36
#SBATCH -J extract3D
#SBATCH -e extract3D.e%j
#SBATCH -o extract3D.o%j
#SBATCH --time=11:30:00
#SBATCH --exclusive
#SBATCH --constraint=HSW24

NB_NPROC=36 #(= 1 regions * 3 variables * 12 months)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''


for var in e3t votemper vosaline; do
	cp script_extract_3D_eNATL60-BLBT02_NOE_VAR_07.ksh tmp_extract_3D_eNATL60-BLBT02_NOE_${var}_07.ksh
	sed -i "s/VAR/$var/g" tmp_extract_3D_eNATL60-BLBT02_NOE_${var}_07.ksh
	chmod +x tmp_extract_3D_eNATL60-BLBT02_NOE_${var}_07.ksh
	liste="$liste ./tmp_extract_3D_eNATL60-BLBT02_NOE_${var}_07.ksh"
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


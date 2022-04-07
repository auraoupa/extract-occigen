#!/bin/ksh
#SBATCH --nodes=1
#SBATCH --ntasks=7
#SBATCH --constraint=VISU
#SBATCH -J make_tide
#SBATCH -e make_tide.e%j
#SBATCH -o make_tide.o%j
#SBATCH --time=5:59:00
#SBATCH --exclusive

NB_NPROC=7 #(= 1 variables * 7 years)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

CONFIGd=TROPICO12
CONFIG=TROPICO12_NST
CASE=TRPC12NT0

for year in $(seq 2012 2018); do
	echo './script_tidal_amp_phase.ksh '$CONFIGd' '$CONFIG' '$CASE' namelist_tideharm_M2S2N2O1K1_zos '$YEAR >> tmp_tidal_amp_phase_$CONFIG-$CASE-${YEAR}.ksh
	chmod +x tmp_tidal_amp_phase_$CONFIG-$CASE-${YEAR}.ksh
	liste="$liste ./tmp_tidal_amp_phase_$CONFIG-$CASE-${YEAR}.ksh"
done

runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


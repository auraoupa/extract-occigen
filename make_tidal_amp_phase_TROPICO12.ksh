#!/bin/ksh
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --constraint=VISU
#SBATCH -J make_tide
#SBATCH -e make_tide.e%j
#SBATCH -o make_tide.o%j
#SBATCH --time=5:59:00
#SBATCH --exclusive

CONFIGd=TROPICO12
CONFIG=TROPICO12_NST
CASE=TRPC12NT0

./script_tidal_amp_phase.ksh $CONFIGd $CONFIG $CASE namelist_tideharm_M2S2N2O1K1_zos

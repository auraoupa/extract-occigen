#!/bin/bash

#SBATCH --nodes=27
#SBATCH --ntasks=730
#SBATCH -J extractbot
#SBATCH -e extractbot.e%j
#SBATCH -o extractbot.o%j
#SBATCH --time=11:00:00
#SBATCH --exclusive
#SBATCH --constraint=BDW28

NB_NPROC=730 #(= 1 variable * 1 regions * 2 simus * 365 days)

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for var in V; do 
for reg in eNATL60; do
	for CASE in BLBT02 BLB002; do
                for month in $(seq 1 12); do

			case $month in
			      7|8|9|10|11|12) year=2009;;
			         1|2|3|4|5|6) year=2010;;
			         19|20|21|22) year=2010;;
			esac

			case $month in
			      1|3|5|7|8|10|12|19|20|22) day1=1; day2=31;;
			      4|6|9|11|21) day1=1; day2=30;;
			      2) day1=1; day2=28;;
			esac

			case $month in
			        19) month=7;;
			        20) month=8;;
			        21) month=9;;
			        22) month=10;;
			esac

			for day in $(seq $day1 $day2); do
			        mm=$(printf "%02d" $month)
			        dd=$(printf "%02d" $day)
			        date=${year}${mm}${dd}

			        echo './script_compute_bottom_currents_eNATL60_date.ksh '${reg}' '${CASE}' 1h '${date}' '${var} >> tmp_compute_bottom_currents_eNATL60_${reg}_${CASE}_${date}_${var}.ksh
				chmod +x tmp_compute_bottom_currents_eNATL60_${reg}_${CASE}_${date}_${var}.ksh
				liste="$liste ./tmp_compute_bottom_currents_eNATL60_${reg}_${CASE}_${date}_${var}.ksh"
			done
		done
	done

done
done
runcode  $NB_NPROC /scratch/cnt0024/hmg2840/albert7a/bin/mpi_shell $liste


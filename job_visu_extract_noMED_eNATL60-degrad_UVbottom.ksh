#!/bin/bash

runcode() { srun --mpi=pmi2 -m cyclic -n $@ ; }
liste=''

for CASE in BLBT02; do
	for var in Ubottomdegrad Vbottomdegrad; do
		for month in $(seq 1 12); do
			cp make_extract_noMED_from_eNATL60-degrad4.ksh tmp_make_extract_noMED_from_eNATL60-degrad4_${CASE}_${var}_${month}.ksh
			sed -i "s/MONTH/$month/g" tmp_make_extract_noMED_from_eNATL60-degrad4_${CASE}_${var}_${month}.ksh
			sed -i "s/VAR/$var/g" tmp_make_extract_noMED_from_eNATL60-degrad4_${CASE}_${var}_${month}.ksh
			sed -i "s/CASE/$CASE/g" tmp_make_extract_noMED_from_eNATL60-degrad4_${CASE}_${var}_${month}.ksh
			chmod +x tmp_make_extract_noMED_from_eNATL60-degrad4_${CASE}_${var}_${month}.ksh
			liste="$liste ./tmp_make_extract_noMED_from_eNATL60-degrad4_${CASE}_${var}_${month}.ksh"
		done
	done
done

for script in $liste; do
  ./$script
done


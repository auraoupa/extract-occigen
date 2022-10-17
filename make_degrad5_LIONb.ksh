#!/bin/bash


for reg in LIONb; do
	for var in votemper_1-200 vosaline_1-200 sozotaux sometauy sowaflup qsr_oce qt_oce; do
		for month in $(seq 1 12) $(seq 19 22); do
			echo "./script_compute_degrad_eNATL60_from_extract.ksh "$reg" BLBT02 1d "$var" "$month " 5" >> tmp_make_degrad5_${reg}_${var}_${month}.ksh
			sed -i "s/MONTH/$month/g" tmp_make_degrad5_${reg}_${var}_${month}.ksh
			sed -i "s/VAR/$var/g" tmp_make_degrad5_${reg}_${var}_${month}.ksh
			sed -i "s/CASE/$CASE/g" tmp_make_degrad5_${reg}_${var}_${month}.ksh
			chmod +x tmp_make_degrad5_${reg}_${var}_${month}.ksh
		done
	done
done



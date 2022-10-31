#!/bin/bash


for reg in FARSHE; do
	for var in gridT-2D flxT gridU-2D gridV-2D; do
		for month in $(seq 2 7); do
				echo "./script_extract_surf_eNATL60_1month.ksh "$reg" BLBT02 1h "$var" "$month >> tmp_extract_2D_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
				chmod +x tmp_extract_2D_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
				./tmp_extract_2D_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
		done
	done
done



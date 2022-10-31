#!/bin/bash


for reg in FARSHE; do
	for var in votemper_0-botm vosaline_0-botm vozocrtx_0-botm vomecrty_0-botm; do
		for month in 1; do
			echo "./script_extract_from_extract_wk.ksh "$reg" "$reg" eNATL60 BLBT02 1h "$var" "$month" 0-3882m" >> tmp_extract_zlevs_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			chmod +x tmp_extract_zlevs_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			./tmp_extract_zlevs_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
		done
	done
done



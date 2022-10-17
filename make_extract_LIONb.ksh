#!/bin/bash


for reg in LIONb LABs; do
	for var in votemper vosaline; do
		for month in $(seq 1 6) $(seq 19 22); do
				cp script_extract_3D_eNATL60-BLBT02_REG_VAR_MONTH_LEVS.ksh tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}_lev1-200.ksh
				sed -i "s/MONTH/$month/g" tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}_lev1-200.ksh
				sed -i "s/VAR/$var/g" tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}_lev1-200.ksh
				sed -i "s/REG/$reg/g" tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}_lev1-200.ksh
				sed -i "s/LEV1/1/g" tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}_lev1-200.ksh
				sed -i "s/LEV2/200/g" tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}_lev1-200.ksh
				chmod +x tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}_lev1-200.ksh
		done
	done
done



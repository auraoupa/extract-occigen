#!/bin/bash


for reg in FARSHE; do
	for month in $(seq 2 7); do
		for var in votemper vosaline vozocrtx vomecrty vovecrtz; do
				cp script_extract_3D_eNATL60-BLBT02_REG_VAR_MONTH_LEVS.ksh tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
				sed -i "s/MONTH/$month/g" tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
				sed -i "s/VAR/$var/g" tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
				sed -i "s/REG/$reg/g" tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
				sed -i "s/LEV1/0/g" tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
				sed -i "s/LEV2/3882/g" tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
				chmod +x tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
#				./tmp_extract_3D_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
		done
	done
done



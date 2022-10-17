#!/bin/bash


for reg in LIONb LABs; do
#	for var in gridT-2D sozotaux somecrty flxT; do
	for var in sometauy; do
		for month in $(seq 1 6) $(seq 19 22); do
			cp script_extract_surf_eNATL60-BLBT02_REG_VAR_MONTH.ksh tmp_extract_surf_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			sed -i "s/MONTH/$month/g" tmp_extract_surf_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			sed -i "s/REG/${reg}/g" tmp_extract_surf_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			sed -i "s/VAR/${var}/g" tmp_extract_surf_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			chmod +x tmp_extract_surf_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
		done
	done
done



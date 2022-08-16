#!/bin/bash

for reg in TURK; do
	for var in sossheig; do
		for month in $(seq 1 12) ; do
				cp script_extract_surf_eNATL60-BLB002_REG_VAR_MONTH.ksh tmp_extract_surf_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				sed -i "s/MONTH/$month/g" tmp_extract_surf_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				sed -i "s/VAR/$var/g" tmp_extract_surf_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				sed -i "s/REG/$reg/g" tmp_extract_surf_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				chmod +x tmp_extract_surf_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				./tmp_extract_surf_eNATL60-BLB002_${reg}_${var}_${month}.ksh
		done
	done
done



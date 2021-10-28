#!/bin/bash



for reg in OSMOSISc MOMAR; do
	for var in vozocrtx vomecrty vovecrtz votemper vosaline; do
		for month in $(seq 1 12); do
				cp script_extract_3D_eNATL60-BLB002_REG_VAR_MONTH.ksh extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				sed -i "s/MONTH/$month/g" extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				sed -i "s/VAR/$var/g" extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				sed -i "s/REG/$reg/g" extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				chmod +x extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				./extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh
		done
	done
done



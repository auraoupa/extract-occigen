#!/bin/bash

LEV1=0
LEV2=163
for reg in TURK; do
	for var in votemper vosaline vozocrtx vomecrty; do
		for month in $(seq 2 12); do
				cp script_extract_3D_eNATL60-BLB002_REG_VAR_MONTH-LEVS.ksh tmp_extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				sed -i "s/MONTH/$month/g" tmp_extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				sed -i "s/VAR/$var/g" tmp_extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				sed -i "s/REG/$reg/g" tmp_extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				sed -i "s/LEV1/$LEV1/g" tmp_extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				sed -i "s/LEV2/$LEV2/g" tmp_extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				chmod +x tmp_extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh
				./tmp_extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh
		done
	done
done



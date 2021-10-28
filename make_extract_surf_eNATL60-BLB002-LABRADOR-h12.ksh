#!/bin/bash

	for var in sossheig sozocrtx somecrty sosstsst sosaline; do
		for month in $(seq 1 12); do
			cp script_extract_surf_eNATL60-BLB002_LABRADOR_VAR_MONTH_h12.ksh tmp_script_extract_surf_eNATL60-BLB002_LABRADOR_${var}_${month}_h12.ksh
			sed -i "s/MONTH/$month/g" tmp_script_extract_surf_eNATL60-BLB002_LABRADOR_${var}_${month}_h12.ksh
			sed -i "s/VAR/$var/g" tmp_script_extract_surf_eNATL60-BLB002_LABRADOR_${var}_${month}_h12.ksh
			chmod +x tmp_script_extract_surf_eNATL60-BLB002_LABRADOR_${var}_${month}_h12.ksh
			./tmp_script_extract_surf_eNATL60-BLB002_LABRADOR_${var}_${month}_h12.ksh
		done
	done



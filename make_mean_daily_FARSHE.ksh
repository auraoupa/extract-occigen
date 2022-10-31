#!/bin/bash
for reg in FARSHE; do
#	for var in flxT gridT-2D gridU-2D gridV-2D vomecrty_0-3882m vosaline_0-3882m votemper_0-3882m vozocrtx_0-3882m; do
#	for var in vomecrty_0-botm vosaline_0-botm votemper_0-botm vozocrtx_0-botm; do
	for var in flxT gridT-2D gridU-2D gridV-2D ; do
		for month in $(seq 2 7); do
			cp script_mean_daily_eNATL60-BLBT02_REG_VAR_MONTH.ksh tmp_mean_daily_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			sed -i "s/MONTH/$month/g" tmp_mean_daily_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			sed -i "s/VAR/$var/g" tmp_mean_daily_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			sed -i "s/REG/$reg/g" tmp_mean_daily_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			chmod +x tmp_mean_daily_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			./tmp_mean_daily_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
		done
	done
done



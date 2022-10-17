#!/bin/bash
for reg in FAROE; do
	for var in flxT gridT-2D gridU-2D gridV-2D vomecrty_0-botm vosaline_0-botm votemper_0-botm vozocrtx_0-botm; do
		for month in 1; do
			cp script_mean_daily_eNATL60-BLBT02_REG_VAR_MONTH.ksh tmp_mean_daily_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			sed -i "s/MONTH/$month/g" tmp_mean_daily_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			sed -i "s/VAR/$var/g" tmp_mean_daily_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			sed -i "s/REG/$reg/g" tmp_mean_daily_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			chmod +x tmp_mean_daily_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
		done
	done
done



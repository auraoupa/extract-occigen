#!/bin/bash
for reg in eNATL60; do
#	for var in votemper_60m vosaline_60m vovecrtz_60m votemper_600m vosaline_600m vovecrtz_600m; do
	for var in vovecrtz_61m vovecrtz_601m; do
		for month in $(seq 1 12); do
			cp script_mean_daily_eNATL60-BLBT02_REG_VAR_MONTH.ksh tmp_mean_daily_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			sed -i "s/MONTH/$month/g" tmp_mean_daily_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			sed -i "s/VAR/$var/g" tmp_mean_daily_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			sed -i "s/REG/$reg/g" tmp_mean_daily_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			chmod +x tmp_mean_daily_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
			./tmp_mean_daily_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
		done
	done
done



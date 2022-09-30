#!/bin/bash


for reg in LION; do
	for var in sozotaux sometauy; do
		for month in $(seq 1 7); do
				echo './script_extract_surf_eNATL60_1month.ksh '$reg' BLBT02 1h '$var' '$month >> tmp_extract_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
				sed -i "s/MONTH/$month/g" tmp_extract_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
				sed -i "s/VAR/$var/g" tmp_extract_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
				sed -i "s/REG/$reg/g" tmp_extract_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
				chmod +x tmp_extract_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
				./tmp_extract_eNATL60-BLBT02_${reg}_${var}_${month}.ksh
		done
	done
done



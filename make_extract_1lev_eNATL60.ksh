#!/bin/bash

REG=eNATL60
CASE=BLBT02
FREQ=1h

#for var in votemper vosaline vovecrtz; do 
for var in vovecrtz; do 
	for month in $(seq 1 12); do
		for dep in 60m 600m; do
			echo './script_extract_1lev_eNATL60_1month.ksh '$REG' '$CASE' '$FREQ' '$var' '$month' '$dep >> tmp_extract_1lev_eNATL60-${CASE}_${FREQ}_${var}_${dep}_${month}.ksh
			chmod +x tmp_extract_1lev_eNATL60-${CASE}_${FREQ}_${var}_${dep}_${month}.ksh
			./tmp_extract_1lev_eNATL60-${CASE}_${FREQ}_${var}_${dep}_${month}.ksh
		done
	done
done



#!/bin/bash

liste=''

for reg in DYF; do
		for month in $(seq 1 12); do
			echo './compute_uvgeo_eNATL60_1month.ksh '$reg' BLB002 1h '$month >> tmp_compute_uvgeo_eNATL60-BLB002_m${month}.ksh
			chmod +x tmp_compute_uvgeo_eNATL60-BLB002_m${month}.ksh
			liste="$liste ./tmp_compute_uvgeo_eNATL60-BLB002_m${month}.ksh"
		done
done

for file in $liste; do
	. $file
done


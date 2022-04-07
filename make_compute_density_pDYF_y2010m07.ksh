#!/bin/bash


for reg in pDYF; do
		for month in 19; do
			echo './compute_density_eNATL60_1month.ksh '$reg' BLB002 1h '$month >> tmp_compute_density_eNATL60-BLB002_m${month}.ksh
			chmod +x tmp_compute_density_eNATL60-BLB002_m${month}.ksh
			./tmp_compute_density_eNATL60-BLB002_m${month}.ksh
		done
done



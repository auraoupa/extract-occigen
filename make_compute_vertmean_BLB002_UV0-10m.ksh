#!/bin/bash


for CASE in BLB002; do
		for month in $(seq 1 12) 19; do
			echo './compute_vertmean_eNATL60_1month.ksh eNATL60 '$CASE' 1h '$month' 0 10' >> tmp_compute_UVvertmean0-10m_eNATL60-BLB002_m${month}.ksh
			chmod +x tmp_compute_UVvertmean0-10m_eNATL60-BLB002_m${month}.ksh
		#	./tmp_compute_UVvertmean0-10m_eNATL60-BLB002_m${month}.ksh
		done
done



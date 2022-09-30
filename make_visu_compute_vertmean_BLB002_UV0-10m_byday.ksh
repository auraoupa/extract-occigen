#!/bin/bash


for CASE in BLB002; do
		for month in $(seq 1 12) 19; do
			echo './make_compute_vertmean_BLB002_UV0-10m_byday_1month.ksh '$month >> tmp_compute_UVvertmean0-10m_eNATL60-BLB002_m${month}.ksh
			chmod +x tmp_compute_UVvertmean0-10m_eNATL60-BLB002_m${month}.ksh
		done
done



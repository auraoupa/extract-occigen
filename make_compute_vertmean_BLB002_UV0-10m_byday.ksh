#!/bin/bash

YEAR=2010
MONTH=3
DAY=16

for CASE in BLB002; do
			echo './compute_vertmean_eNATL60_1day.ksh eNATL60 '$CASE' 1h '$YEAR' '$MONTH' '$DAY' 0 10' >> tmp_compute_UVvertmean0-10m_eNATL60-BLB002_y${YEAR}m${MONTH}d${DAY}.ksh
			chmod +x tmp_compute_UVvertmean0-10m_eNATL60-BLB002_y${YEAR}m${MONTH}d${DAY}.ksh
			./tmp_compute_UVvertmean0-10m_eNATL60-BLB002_y${YEAR}m${MONTH}d${DAY}.ksh
done



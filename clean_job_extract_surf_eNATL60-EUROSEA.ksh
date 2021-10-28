#!/bin/bash

rm extract2D.e* extract2D.o*

for reg in NANFL MEDWEST; do
	for var in sossheig sozocrtx somecrty sosstsst sosaline; do
		for month in $(seq 1 12); do
			rm extract_surf_eNATL60-BLB002_${reg}_${var}_${month}.ksh
		done
	done
done



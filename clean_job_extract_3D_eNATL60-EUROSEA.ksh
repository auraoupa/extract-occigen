#!/bin/bash

rm extract3D.e* extract3D.o*

for reg in COSNWA MEDBAL; do
        for var in vozocrtx vomecrty vovecrtz votemper vosaline; do
		for month in $(seq 1 12); do
			rm extract_3D_eNATL60-BLB002_${reg}_${var}_${month}.ksh
		done
	done
done



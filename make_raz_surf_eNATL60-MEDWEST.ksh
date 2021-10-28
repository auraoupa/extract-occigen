#!/bin/bash


for reg in MEDWEST; do
	for var in sossheig sozocrtx somecrty sosstsst sosaline; do
		for month in $(seq 1 12); do
			./script_compute_raz_eNATL60_reg.ksh MEDWEST BLB002 1h $var $month
		done
	done
done



#!/bin/bash

liste=''

list_V='y2009m07d12 y2009m08d12 y2009m09d12 y2009m11d12 y2009m12d12 y2009m10d04 y2009m10d13 y2010m02d12 y2010m03d12 y2010m04d12 y2010m05d12 y2010m06d12 y2009m10d04 y2010m10d13 y2010m01d20'
for CASE in BLBT02 ; do
	for var in Vbottom ; do
		for date in $list_V; do
			cp make_degrad_UVbottom4_eNATL60_date.ksh tmp_make_degrad_UVbottom4_eNATL60_${CASE}_${var}_${date}.ksh
			sed -i "s/DATE/$date/g" tmp_make_degrad_UVbottom4_eNATL60_${CASE}_${var}_${date}.ksh
			sed -i "s/VAR/$var/g" tmp_make_degrad_UVbottom4_eNATL60_${CASE}_${var}_${date}.ksh
			sed -i "s/CASE/$CASE/g" tmp_make_degrad_UVbottom4_eNATL60_${CASE}_${var}_${date}.ksh
			chmod +x tmp_make_degrad_UVbottom4_eNATL60_${CASE}_${var}_${date}.ksh
			liste="$liste ./tmp_make_degrad_UVbottom4_eNATL60_${CASE}_${var}_${date}.ksh"
		done
	done
done

for script in $liste; do
  ./$script
done

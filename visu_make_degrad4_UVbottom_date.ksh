#!/bin/bash

liste=''

list_U='y2009m07d10 y2009m07d21 y2009m08d10 y2009m09d10 y2009m10d10 y2009m11d10 y2009m12d10 y2010m02d10 y2010m03d10 y2010m04d10 y2010m05d10 y2010m06d10'
for CASE in BLBT02 ; do
	for var in Ubottom ; do
		for date in $list_U; do
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

#!/bin/bash

YEAR=$1

dir=$SCRATCHDIR/eNATL60/eNATL60-I/FATM

mkdir -p $dir
cd $dir


tdir=/store/CT1/hmg2840/lbrodeau/eNATL60/eNATL60-I/FATM


for var in u10 v10; do 
file=$tdir/drowned_${var}_DFS5.2_y${YEAR}.nc

for t in $(seq 1 365); do

	tm=$(expr $t - 1)
	t1=$(expr $tm \* 8 + 1)
	t2=$(expr $tm \* 8 + 8)
	yyyy=$(date -d "${YEAR}0101 $tm day" +%Y)
	mm=$(date -d "${YEAR}0101 $tm day" +%m)
	dd=$(date -d "${YEAR}0101 $tm day" +%d)
	date=y${yyyy}m${mm}d${dd}
	fileo=drowned_${var}_DFS5.2_${date}.nc
	ncks -O -F -d time,$t1,$t2 $file $fileo
done

done





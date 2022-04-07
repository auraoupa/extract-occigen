#!/bin/bash

REG=$1
CASE=$2
FREQ=$3
MONTH=$4

CONFIG=eNATL60
dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/$FREQ/$REG

cd $dir #assume the directory exists and there is a file containing sossheig extracted for the region

if [ ! -f  mesh_hgr.nc ] ; then
	ln -sf $SCRATCHDIR/${CONFIG}/${CONFIG}-I/mesh_hgr_${CONFIG}${REG}_3.6.nc mesh_hgr.nc
fi
if [ ! -f  mesh_zgr.nc ] ; then
        ln -sf $SCRATCHDIR/${CONFIG}/${CONFIG}-I/mesh_zgr_${CONFIG}${REG}_3.6.nc mesh_zgr.nc
fi

for month in $MONTH; do

	case $month in
                7|8|9|10|11|12) year=2009;;
                1|2|3|4|5|6|19|20|21|22) year=2010;;
        esac

        case $month in
                1|3|5|7|8|10|12|19|20|22) day1=1; day2=31;;
                4|6|9|11|21) day1=1; day2=30;;
                2) day1=1; day2=28;;
        esac
  
	for day in $(seq $day1 $day2); do

		mm=$(printf "%02d" $month)
	        dd=$(printf "%02d" $day)

		for file in $(ls ${CONFIG}${REG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_sossheig.nc); do

			fileugeo=$(echo $file | sed 's/sossheig/ugeo/g')
			filevgeo=$(echo $file | sed 's/sossheig/vgeo/g')
			if [ ! -f  $fileugeo ]; then 
				echo $fileugeo $filevgeo
				/scratch/cnt0024/ige2071/aalbert/git/CDFTOOLS/bin/cdfgeo-uv -f $file -o $fileugeo $filevgeo -C 1 -ssh sossheig
			fi
		done
	done
done




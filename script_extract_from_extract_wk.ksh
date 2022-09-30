#!/bin/bash

REGin=$1
REGout=$2
CONFIG=$3
CASE=$4
FREQ=$5
VAR=$6
MONTH=$7

case $REGout in
	pDYF) case $REGin in
		DYF) coord='-d x,27,27 -d y,70,70';; 
# get it with : ulimit -s unlimited; /scratch/cnt0024/ige2071/aalbert/git/CDFTOOLS/bin/cdffindij -w 8 8 43.5 43.5 -c /scratch/cnt0024/ige2071/aalbert/eNATL60/eNATL60-I/coordinates_eNATL60DYF.nc
	      esac;;
	noMED) case $REGin in
		eNATL60-degrad) coord='-d x,1,1480';sREGin='';
	       esac;;
esac


dir=/work/aalbert/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/$REGout

mkdir -p $dir
cd $dir

stdir=/work/aalbert/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/$REGin

for month in $MONTH; do

        case $month in
                7|8|9|10|11|12) year=2009;;
                1|2|3|4|5|6|19|20|21|22) year=2010;;
        esac

	mm=$(printf "%02d" $month)
	for file in $(ls $stdir/${CONFIG}${sREGin}-${CASE}_y${year}m${mm}*.${FREQ}_${VAR}.nc); do

		fileo=$(basename $file | sed "s/${CONFIG}${sREGin}/${CONFIG}${REGout}/g")
		if [ ! -f  $fileo ]; then 
			echo $fileo 
			ncks -O -F $coord $file $fileo
		fi
	done
		
done




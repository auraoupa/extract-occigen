#!/bin/bash

REGin=$1
REGout=$2
CONFIG=$3
CASE=$4
FREQ=$5
VAR=$6

case $REGout in
	pDYF) case $REGin in
		DYF) coord='-d x,27,27 -d y,70,70'; sREGi=DYF;; 
# get it with : ulimit -s unlimited; /scratch/cnt0024/ige2071/aalbert/git/CDFTOOLS/bin/cdffindij -w 8 8 43.5 43.5 -c /scratch/cnt0024/ige2071/aalbert/eNATL60/eNATL60-I/coordinates_eNATL60DYF.nc
	      esac;;
esac


dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/$REGout

mkdir -p $dir
cd $dir

stdir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/$REGin

for file in $(ls $stdir/*${VAR}*); do

	fileo=$(basename $file | sed "s/$REGin/$REGout/g")
	if [ ! -f  $fileo ]; then 
		echo $fileo 
		ncks -O -F $coord $file $fileo
	fi

done




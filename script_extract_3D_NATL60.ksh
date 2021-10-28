#!/bin/bash

REG=$1
CASE=$2
FREQ=$3
VAR=$4
DATE=$5
LEVS=$6

CONFIG=NATL60

case $REG in
	NATL60) coord='';sREG=;;
esac

LEV1=$( echo $LEVS | awk -F- '{print $1}' )
LEV2=$( echo $LEVS | awk -F- '{print $2}' )

case $LEV1 in
	0) indZ1=1;;
	10) indZ1=7;;
	20) indZ1=12;;
	30) indZ1=15;;
	40) indZ1=18;;
	50) indZ1=20;;
	60) indZ1=23;;
	15) indZ1=10;;
esac

if [ -z $LEV2 ]; then
	indZ2=$indZ1
else

	case $LEV2 in
		1000) indZ2=107;; #check /store/CT1/hmg2840/lbrodeau/eNATL60/eNATL60-I/deptht.txt
		2000) indZ2=158;; #check /store/CT1/hmg2840/lbrodeau/eNATL60/eNATL60-I/deptht.txt
		bot) indZ2=300;; #check /store/CT1/hmg2840/lbrodeau/eNATL60/eNATL60-I/deptht.txt
	esac
fi

dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/$REG

mkdir -p $dir
cd $dir

for var in $VAR; do

	case $var in
        	vovecrtz) filetyp=gridW; dimZ=depthw;;
	esac

	stdir=/store/molines/NATL60/NATL60-${CASE}-S/$FREQ

        year=${DATE:0:4}
        mm=${DATE:4:2}
        dd=${DATE:6:2}

	for file in $(ls $stdir/${year}/${CONFIG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${filetyp}.nc); do

 		fileo=${CONFIG}${sREG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${var}_${LEVS}m.nc
		if [ ! -f  $fileo ]; then echo $fileo; ncks -O -F $coord -d $dimZ,$indZ1,$indZ2 -v ${var} $file $fileo; fi

 	done
 done




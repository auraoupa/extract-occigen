#!/bin/bash

REG=$1
CASE=$2
FREQ=$3
VAR=$4
DATE=$5
LEVS=$6

CONFIG=eNATL60

case $REG in
        LION) coord='-d x,6126,6135 -d y,2439,2448'; sREG=LION;;
        NOE) coord='-d x,4014,4134 -d y,1438,1576'; sREG=NOE;;
        MEDWEST) coord='-d x,5530,6412 -d y,1870,2672'; sREG=MEDWEST;;
        NANFL) coord='-d x,2574,3478 -d y,1509,2236'; sREG=NANFL;;
        COSNWA) coord='-d x,2905,3027 -d y,1829,1976'; sREG=COSNWA;;
        MEDBAL) coord='-d x,5922,6035 -d y,2222,2391'; sREG=MEDBAL;;
	OSMOSISb) coord='-d x,4424,4831 -d y,2630,3535'; sREG=OSMOb;;
	EOSMO) coord='-d x,4461,5340 -d y,2333,3895'; sREG=EOSMO;;
	EGULF) coord='-d x,1464,3106 -d y,1478,2774'; sREG=EGULF;;
	OSMOSISc) coord='-d x,4879,4879 -d y,2944,2944'; sREG=OSMOSISc;;
	MOMAR) coord='-d x,3938,3938 -d y,2028,2028'; sREG=MOMAR;;
	SICIL) coord='-d x,6352,6935 -d y,1656,2311'; sREG=SICIL;;
	pDYF) coord='-d x,6323,6323 -d y,2582,2582'; sREG=pDYF;;
	DYF) coord='-d x,6296,6349 -d y,2535,2629'; sREG=DYF;;
esac

LEV1=$( echo $LEVS | awk -F- '{print $1}' )
LEV2=$( echo $LEVS | awk -F- '{print $2}' )

if [ ! -z $LEV1 ]; then

	case $LEV1 in
		0) indZ1=1;;
		15) indZ1=10;;
		1000) indZ1=107;; #check /store/CT1/hmg2840/lbrodeau/eNATL60/eNATL60-I/deptht.txt
	esac

	if [ -z $LEV2 ]; then
		indZ2=$indZ1
	else

		case $LEV2 in
			175) indZ2=175;; 
			2500) indZ2=179;; 
			1000) indZ2=107;; #check /store/CT1/hmg2840/lbrodeau/eNATL60/eNATL60-I/deptht.txt
			2000) indZ2=158;; #check /store/CT1/hmg2840/lbrodeau/eNATL60/eNATL60-I/deptht.txt
			bot) indZ2=300;; #check /store/CT1/hmg2840/lbrodeau/eNATL60/eNATL60-I/deptht.txt
		esac
	fi
fi

dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/$REG

mkdir -p $dir
cd $dir

for var in $VAR; do

	case $var in
		votemper) filetyp=gridT; dimZ=deptht;;
        	vosaline) filetyp=gridS; dimZ=deptht;;
        	vozocrtx) filetyp=gridU; dimZ=depthu;;
        	vomecrty) filetyp=gridV; dimZ=depthv;;
        	vovecrtz) filetyp=gridW; dimZ=depthw;;
        	e3t) filetyp=gridZ; dimZ=deptht;;
	esac

	stdir=/store/CT1/hmg2840/lbrodeau/${CONFIG}

	for file in $(ls $stdir/${CONFIG}-${CASE}*-S/*/${CONFIG}-${CASE}*_${FREQ}_*_${filetyp}_${DATE}-${DATE}.nc); do

		year=${DATE:0:4}
		mm=${DATE:4:2}
		dd=${DATE:6:2}
 		if [ ! -z $LEV1 ]; then fileo=${CONFIG}${sREG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${var}_${LEVS}m.nc; else fileo=${CONFIG}${sREG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${var}.nc; fi
		if [ ! -f  $fileo ]; then 
			echo $fileo 
			if [ ! -z $LEV1 ]; then
				ncks -O -F $coord -d $dimZ,$indZ1,$indZ2 -v ${var} $file $fileo
			else
				ncks -O -F $coord -v ${var} $file $fileo
			fi
		fi

 	done
 done




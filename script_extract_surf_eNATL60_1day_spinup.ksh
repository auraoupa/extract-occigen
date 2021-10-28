#!/bin/bash

REG=$1
CASE=$2
FREQ=$3
VAR=$4
YEAR=$5
MONTH=$6
DAY=$7

CONFIG=eNATL60

case $REG in
        MEDWEST) coord='-d x,5530,6412 -d y,1870,2672'; sREG=MEDWEST;;
        NANFL) coord='-d x,2574,3478 -d y,1509,2236'; sREG=NANFL;;
        COSNWA) coord='-d x,2905,3027 -d y,1829,1976'; sREG=COSNWA;;
        MEDBAL) coord='-d x,5922,6035 -d y,2222,2391'; sREG=MEDBAL;;
	ACOl) coord='-d x,3774,4789 -d y,1507,2235'; sREG=ACOl;;
	OSMOSISb) coord='-d x,4424,4831 -d y,2630,3535'; sREG=OSMOb;;
        EOSMO) coord='-d x,4461,5340 -d y,2333,3895'; sREG=EOSMO;;
        EGULF) coord='-d x,1464,3106 -d y,1478,2774'; sREG=EGULF;;
esac

dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/$REG

mkdir -p $dir


cd $dir

for var in $VAR; do

      case $var in
        sossheig) filetyp=gridT-2D;;
        sosstsst) filetyp=gridT-2D;;
        sosaline) filetyp=gridT-2D;;
        sozocrtx) filetyp=gridU-2D;;
        somecrty) filetyp=gridV-2D;;
        somxl010) filetyp=gridT-2D;;
      esac

      mm=$(printf "%02d" $MONTH)
      dd=$(printf "%02d" $DAY)

      stdir=/store/CT1/hmg2840/lbrodeau/${CONFIG}/${CONFIG}-${CASE}-S
      for file in $(ls $stdir/*/${CONFIG}-${CASE}_${FREQ}_*_${filetyp}_${YEAR}${mm}${dd}-${YEAR}${mm}${dd}.nc); do

 	fileo=${CONFIG}${sREG}-${CASE}_y${YEAR}m${mm}d${dd}.${FREQ}_${var}.nc
	if [ ! -f  $fileo ]; then echo $fileo; ncks -O -F $coord -v ${var} $file $fileo; fi

      done
done




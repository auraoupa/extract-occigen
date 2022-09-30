#!/bin/bash

ulimit -s unlimited

REG=$1
CASE=$2
FREQ=$3
DATE=$4

CONFIG=eNATL60

dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/${REG}
mkdir -p $dir
cd $dir

case $REG in
	eNATL60) sREG='';;
        MEDWEST) sREG=MEDWEST;;
        NANFL)   sREG=NANFL;;
esac

if [ ! -f mask.nc ]; then
	ln -sf /store/CT1/hmg2840/lbrodeau/${CONFIG}/${CONFIG}-I/mask_${CONFIG}${sREG}_3.6.nc mask.nc
fi


for date in $DATE; do

	stdir=/store/CT1/hmg2840/lbrodeau/${CONFIG}/${CONFIG}-${CASE}-S

	for fileu in $(ls $stdir/*/${CONFIG}-${CASE}_${FREQ}_*_gridU_${date}-${date}.nc); do
		filev=$(echo $fileu | sed "s/gridU/gridV/g")
		fileuo=${CONFIG}${sREG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_Ubottom.nc
		if [ ! -f  $fileuo ]; then echo $fileuo; $SCRATCHDIR/git/CDFTOOLS/bin/cdfbottom -f $fileu -p U -o $fileuo; fi
		filevo=${CONFIG}${sREG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_Vbottom.nc
		if [ ! -f  $filevo ]; then echo $fileuo; $SCRATCHDIR/git/CDFTOOLS/bin/cdfbottom -f $filev -p U -o $filevo; fi

	done
    done
done


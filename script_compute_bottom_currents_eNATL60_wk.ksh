#!/bin/bash

ulimit -s unlimited

REG=$1
CASE=$2
FREQ=$3
MONTH=$4

CONFIG=eNATL60

dir=/work/aalbert/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/${REG}
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


for month in $MONTH; do
    case $month in
      7|8|9|10|11|12) year=2009;;
         1|2|3|4|5|6) year=2010;;
    esac

    case $month in
      1|3|5|7|8|10|12) day1=1; day2=31;;
      4|6|9|11) day1=1; day2=30;;
      2) day1=1; day2=28;;
    esac

    for day in $(seq $day1 $day2); do
        case $month in
                       7|8|9|10) CASEi=${CASE};;
                 12|1|2|3|4|5|6) CASEi=${CASE}X;;
                      11) case $CASE in
				'BLB002') dayt=17;;
				'BLBT02') dayt=7;;
			  esac
			  if [ $day -lt $dayt ]; then CASEi=${CASE}; else CASEi=${CASE}X; fi;;
        esac
	mm=$(printf "%02d" $month)
        dd=$(printf "%02d" $day)

	stdir=/store/CT1/hmg2840/lbrodeau/${CONFIG}/${CONFIG}-${CASEi}-S

	for fileu in $(ls $stdir/*/${CONFIG}-${CASEi}_${FREQ}_*_gridU_${year}${mm}${dd}-${year}${mm}${dd}.nc); do
		filev=$(echo $fileu | sed "s/gridU/gridV/g")
		fileuo=${CONFIG}${sREG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_Ubottom.nc
		if [ ! -f  $fileuo ]; then echo $fileuo; /work/aalbert/git/CDFTOOLS/bin/cdfbottom -f $fileu -p U -o bottom_$fileuo; mv bottom_$fileuo $fileuo; fi
		filevo=${CONFIG}${sREG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_Vbottom.nc
		if [ ! -f  $filevo ]; then echo $fileuo; /work/aalbert/git/CDFTOOLS/bin/cdfbottom -f $filev -p U -o bottom_$filevo; mv bottom_$filevo $filevo; fi

	done
    done
done


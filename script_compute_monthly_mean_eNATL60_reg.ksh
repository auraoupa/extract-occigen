#!/bin/bash

ulimit -s unlimited

REG=$1
CASE=$2
FREQ=$3
VAR=$4
MONTH=$5

CONFIG=eNATL60

dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/${REG}
cd $dir

case $REG in
	MEDWEST-degrad) sREG=MEDWEST;;
	NANFL-degrad) sREG=NANFL;;
esac

for month in $MONTH; do
    case $month in
      7|8|9|10|11|12) year=2009;;
         1|2|3|4|5|6) year=2010;;
    esac

    mm=$(printf "%02d" $month)

    for var in $VAR; do

	fileo=${CONFIG}${sREG}-${CASE}_y${year}m${mm}.1m_${var}
      	files=${CONFIG}${sREG}-${CASE}_y${year}m${mm}d??.${FREQ}_${var}.nc
	if [ ! -f  ${fileo}.nc ]; then echo ${fileo}; cdfmoy -l $files -o $fileo -nc4; fi


    done
done


#!/bin/bash

ulimit -s unlimited

REG=$1
CASE=$2
FREQ=$3
VAR=$4
MONTH=$5

CONFIG=eNATL60

dir=/work/aalbert/${CONFIG}/${CONFIG}-${CASE}-S/1d/${REG}
mkdir -p $dir
cd $dir

case $REG in
	MEDWEST-degrad) sREG=MEDWEST;;
	NANFL-degrad) sREG=NANFL;;
	eNATL60) sREG='';;
	*) sREG=$REG;;
esac

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

    case $month in
                        1|2|3|4|5|6|7|8|9|10|11|12) monthi=$month;;
                        19) monthi=7;;
                        20) monthi=8;;
                        21) monthi=9;;
                        22) monthi=10;;
    esac
    for day in $(seq $day1 $day2); do

	    mm=$(printf "%02d" $monthi)
	    dd=$(printf "%02d" $day)
	    for var in $VAR; do

		stdir=/work/aalbert/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/${REG}
		fileo=${CONFIG}${sREG}-${CASE}_y${year}m${mm}d${dd}.1d_${var}
      		files=$stdir/${CONFIG}${sREG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${var}.nc
		if [ ! -f  ${fileo}.nc ]; then echo ${fileo}; /work/aalbert/git/CDFTOOLS/bin/cdfmoy -l $files -o $fileo -nc4; fi

	    done
    done
done


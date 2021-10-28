#!/bin/bash

ulimit -s unlimited

REG=$1
CASE=$2
FREQ=$3
VAR=$4
MONTH=$5

CONFIG=eNATL60

dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/${REG}
mkdir -p $dir
cd $dir


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

        mm=$(printf "%02d" $month)
        dd=$(printf "%02d" $day)

    for var in $VAR; do


      	file=${CONFIG}${REG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${var}.nc
	cdfbathy -file $file -var $var -zoom 1 243 655 803 -raz_zone -overwrite


      done
    done

  done


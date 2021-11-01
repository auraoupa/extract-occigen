#!/bin/bash

REG=$1
CASE=$2
FREQ=$3
VAR=$4
MONTH=$5

CONFIG=NATL60

case $REG in
        EOSMO) coord='-d x,3090,4196 -d y,1351,2355'; sREG=EOSMO;;
        OSMOSIS) coord='-d x,3678,4206 -d y,1355,2260'; sREG=OSMO;;
#        GULFSTREAM) coord='-d x,988,1597 -d y,232,1025'; sREG=GULFSTREAM;;
        GULFSTREAM) coord='-d x,989,1604 -d y,452,1224'; sREG=GULFSTREAM;;
        GULF) coord='-d x,989,1640 -d y,236,1845'; sREG=GULF;; #the good one, without islands989
        EGULF) coord='-d x,988,2320 -d y,166,1283'; sREG=EGULF;;
        EATL) coord='-d x,2113,3913 -d y,1014,2094'; sREG=EATL;;
        LMX) coord='-d x,389,1420 -d y,310,1065'; sREG=LMX;;
esac

dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/$REG

mkdir -p $dir


cd $dir

for month in $MONTH; do
  
    case $month in
                  10|11|12) year=2012;;
         1|2|3|4|5|6|7|8|9) year=2013;;
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

      case $var in
       sossheig) case $FREQ in
                        1d) filetyp=gridTsurf;;
                        1h) filetyp=SSH;;
                  esac;;
        somxl010) filetyp=gridTsurf;;
        sosstsst) filetyp=gridT;;
        sosaline) filetyp=gridT;;
        vozocrtx) filetyp=gridU;;
        vomecrty) filetyp=gridV;;
      esac

      stdir=/store/molines/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/$year/

      for file in $(ls $stdir/${CONFIG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${filetyp}.nc); do

 	fileo=${CONFIG}${sREG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${var}.nc
	if [ ! -f  $fileo ]; then echo $fileo; ncks -O -F $coord -v ${var} $file $fileo; fi

      done
    done

  done
done



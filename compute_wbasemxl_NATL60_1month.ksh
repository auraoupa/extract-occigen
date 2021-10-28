#!/bin/bash

REG=$1
CASE=$2
MONTH=$3

CONFIG=NATL60

case $REG in
        EOSMO) coord='-d x,3090,4196 -d y,1351,2355'; sREG=EOSMO;;
        OSMOSIS) coord='-d x,3678,4206 -d y,1355,2260'; sREG=OSMO;;
#        GULFSTREAM) coord='-d x,988,1597 -d y,232,1025'; sREG=GULFSTREAM;;
        GULFSTREAM) coord='-d x,989,1604 -d y,452,1224'; sREG=GULFSTREAM;;
        GULF) coord='-d x,989,1640 -d y,236,1845'; sREG=GULF;; #the good one, without islands989
        EGULF) coord='-d x,988,2320 -d y,166,1283'; sREG=EGULF;;
        EATL) coord='-d x,2113,3913 -d y,1014,2094'; sREG=EATL;;
esac

dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/1d/$REG

mkdir -p $dir


cd $dir

if [ ! -f  mesh_zgr.nc ] ; then
	ln -sf $SCRATCHDIR/${CONFIG}/${CONFIG}-I/${CONFIG}${REG}_v4.1_cdf_mesh_zgr.nc mesh_zgr.nc
fi

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



      stdir=/store/molines/${CONFIG}/${CONFIG}-${CASE}-S/1d/$year/

      for file in $(ls $stdir/${CONFIG}-${CASE}_y${year}m${mm}d${dd}.1d_gridTsurf.nc); do

 	filew=$(echo $file | sed 's/gridTsurf/gridW/g')
 	fileo=${CONFIG}${sREG}-${CASE}_y${year}m${mm}d${dd}.1d_wbasemxl.nc
 	fileomld=${CONFIG}${sREG}-${CASE}_y${year}m${mm}d${dd}.1d_somxl010.nc
 	fileow=${CONFIG}${sREG}-${CASE}_y${year}m${mm}d${dd}.1d_vovecrtz.nc
	if [ ! -f  $fileomld ]; then echo $fileomld; ncks -O -F $coord -v somxl010 $file $fileomld; fi
	if [ ! -f  $fileow ]; then echo $fileow; ncks -O -F $coord -v vovecrtz $filew $fileow; fi
	if [ ! -f  $fileo ]; then echo $fileo; /scratch/cnt0024/hmg2840/albert7a/DEV/CDFTOOLS/bin/cdfbasemxl -f $fileow -mld $fileomld somxl010 -p F -o $fileo; fi

      done
    done

  done



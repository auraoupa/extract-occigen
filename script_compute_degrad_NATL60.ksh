#!/bin/bash

ulimit -s unlimited

REG=$1
CASE=$2
FREQ=$3
VAR=$4
MONTH=$5
FACT=$6

CONFIG=NATL60

dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/${VAR}-${REG}-degrad
mkdir -p $dir
cd $dir

case $REG in
	NATL60) tdir=/store/molines/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/; sREG='';;
esac

ln -sf /scratch/cnt0024/hmg2840/albert7a/${CONFIG}/${CONFIG}-I/${CONFIG}${sREG}_v4.1_cdf_byte_mask.nc mask.nc
ln -sf /scratch/cnt0024/hmg2840/albert7a/${CONFIG}/${CONFIG}-I/${CONFIG}${sREG}_v4.1_cdf_mesh_hgr.nc mesh_hgr.nc
ln -sf /scratch/cnt0024/hmg2840/albert7a/${CONFIG}/${CONFIG}-I/${CONFIG}${sREG}_v4.1_cdf_mesh_zgr.nc mesh_zgr.nc

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
        sosstsst) filetyp=gridTsurf;;
        sosaline) filetyp=gridTsurf;;
        vozocrtx) filetyp=gridUsurf;;
        vomecrty) filetyp=gridVsurf;;
      esac

      stdir=/store/molines/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/$year/

      for file in $(ls $stdir/${CONFIG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${filetyp}.nc); do

        fileo=${CONFIG}${sREG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${filetyp}degrad${FACT}.nc
        if [ ! -f  $fileo ]; then echo $fileo; /scratch/cnt0024/hmg2840/albert7a/DEV/CDFTOOLS/bin/cdfdegrad -f ${file} -v ${var} -r $FACT $FACT -p T -o ${fileo}; fi

      done
    done

  done
done


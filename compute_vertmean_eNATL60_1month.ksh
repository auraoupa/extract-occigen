#!/bin/bash

REG=$1
CASE=$2
FREQ=$3
MONTH=$4
Z1=$5
Z2=$6

CONFIG=eNATL60
dir=/work/aalbert/${CONFIG}/${CONFIG}-${CASE}-S/$FREQ/$REG

mkdir -p $dir
cd $dir 

ulimit -s unlimited

if [ ! -f mask.nc ]; then
	ln -sf /store/CT1/hmg2840/lbrodeau/eNATL60/eNATL60-I/mask_eNATL60_3.6.nc mask.nc
fi
if [ ! -f mesh_zgr.nc ]; then
	ln -sf /store/CT1/hmg2840/lbrodeau/eNATL60/eNATL60-I/mesh_zgr_eNATL60_3.6.nc mesh_zgr.nc
fi

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

        for day in $(seq $day1 $day2); do

                case $month in
                        1|2|3|4|5|6|7|8|9|10|11|12) monthi=$month;;
                        19) monthi=7;;
                        20) monthi=8;;
                        21) monthi=9;;
                        22) monthi=10;;
                esac

		mm=$(printf "%02d" $monthi)
	        dd=$(printf "%02d" $day)

		if [ $REG == 'eNATL60' ]; then
			stdir=/store/CT1/hmg2840/lbrodeau/${CONFIG}
			for fileu in $(ls $stdir/${CONFIG}-${CASE}*-S/*/${CONFIG}-${CASE}*_${FREQ}_*_gridU_${year}${mm}${dd}-${year}${mm}${dd}.nc); do
				filev=$(echo $fileu | sed 's/gridU/gridV/g')
				fileuo=${CONFIG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_Uvertmean${Z1}-${Z2}m.nc
				filevo=${CONFIG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_Vvertmean${Z1}-${Z2}m.nc
				if [ ! -f  $fileuo ]; then 
					echo $fileuo
					/work/aalbert/git/CDFTOOLS/bin/cdfvertmean -f $fileu -l vozocrtx -p U -zlim $Z1 $Z2 -o tmp_$fileuo
					mv tmp_$fileuo $fileuo
				fi
				if [ ! -f  $filevo ]; then 
					echo $filevo
					/work/aalbert/git/CDFTOOLS/bin/cdfvertmean -f $filev -l vomecrty -p V -zlim $Z1 $Z2 -o tmp_$filevo 
					mv tmp_$filevo $filevo
				fi
			done
		fi
	done
done



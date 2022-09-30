#!/bin/bash

REG=$1
CASE=$2
FREQ=$3
YEAR=$4
MONTH=$5
DAY=$6
Z1=$7
Z2=$8

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

		mm=$(printf "%02d" $MONTH)
	        dd=$(printf "%02d" $DAY)
		if [ $REG == 'eNATL60' ]; then
			stdir=/store/CT1/hmg2840/lbrodeau/${CONFIG}
			for fileu in $(ls $stdir/${CONFIG}-${CASE}*-S/*/${CONFIG}-${CASE}*_${FREQ}_*_gridU_${YEAR}${mm}${dd}-${YEAR}${mm}${dd}.nc); do
				filev=$(echo $fileu | sed 's/gridU/gridV/g')
				fileuo=${CONFIG}-${CASE}_y${YEAR}m${mm}d${dd}.${FREQ}_Uvertmean${Z1}-${Z2}m.nc
				filevo=${CONFIG}-${CASE}_y${YEAR}m${mm}d${dd}.${FREQ}_Vvertmean${Z1}-${Z2}m.nc
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




#!/bin/bash

CONFIG=$1
CASE=$2
REG=$3
FREQ=$4
FILETYP=$5
YEAR=$6

dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/$REG

cd $dir #Assumes dir exists and has file in it for the year and filetyp

date1=$(ls -l ${CONFIG}${REG}-${CASE}_y${YEAR}m??d??.${FREQ}_${FILETYP}.nc | head -1 | awk -F_ '{print $2}' | awk -F. '{print $1}')
date2=$(ls -l ${CONFIG}${REG}-${CASE}_y${YEAR}m??d??.${FREQ}_${FILETYP}.nc | tail -1 | awk -F_ '{print $2}' | awk -F. '{print $1}')

fileo=${CONFIG}${REG}-${CASE}_${date1}-${date2}.${FREQ}_${FILETYP}.nc
if [ ! -f $fileo ]; then ncrcat ${CONFIG}${REG}-${CASE}_y${YEAR}m??d??.${FREQ}_${FILETYP}.nc ${fileo}; fi


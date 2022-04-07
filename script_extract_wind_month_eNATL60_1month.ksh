#!/bin/bash

REG=$1
CASE=$2
FREQ=$3
VAR=$4
MONTH=$5

CONFIG=eNATL60

case $REG in
        MEDWEST) coord='-d x,5530,6412 -d y,1870,2672'; sREG=MEDWEST;;
        NANFL) coord='-d x,2574,3478 -d y,1509,2236'; sREG=NANFL;;
        COSNWA) coord='-d x,2905,3027 -d y,1829,1976'; sREG=COSNWA;;
        MEDBAL) coord='-d x,5922,6035 -d y,2222,2391'; sREG=MEDBAL;;
	ACOl) coord='-d x,3774,4789 -d y,1507,2235'; sREG=ACOl;;
	OSMOSISb) coord='-d x,4424,4831 -d y,2630,3535'; sREG=OSMOb;;
        EOSMO) coord='-d x,4461,5340 -d y,2333,3895'; sREG=EOSMO;;
        EGULF) coord='-d x,1464,3106 -d y,1478,2774'; sREG=EGULF;;
        SICIL) coord='-d x,6352,6935 -d y,1656,2311'; sREG=SICIL;;
	LION) coord='-d x,6126,6135 -d y,2439,2448'; sREG=LION;;
	DYF) coord='-d x,6297,6351 -d y,2513,2605'; sREG=DYF;;
	pDYF) coord='-d x,6323,6323 -d y,2582,2582'; sREG=pDYF;;

esac

dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/$REG

mkdir -p $dir


cd $dir

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



      		stdir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/eNATL60

		for file in $(ls $stdir/${CONFIG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${VAR}.nc); do

			fileo=${CONFIG}${sREG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${VAR}.nc
			if [ ! -f  $fileo ]; then 
				echo $fileo
				ncks -O -F $coord $file $fileo
			fi

		done
	done

done



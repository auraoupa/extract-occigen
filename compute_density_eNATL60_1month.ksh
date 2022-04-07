#!/bin/bash

REG=$1
CASE=$2
FREQ=$3
MONTH=$4

CONFIG=eNATL60
dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/$FREQ/$REG

cd $dir #assume the directory exists and there is a file containing votemper and another one containing vosaline extracted for the region


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

		for filet in $(ls ${CONFIG}${REG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_votemper_0-2500m.nc); do

			files=$(echo $filet | sed 's/votemper/vosaline/g')
			fileo=$(echo $filet | sed 's/votemper/sig0/g')
			if [ ! -f  $fileo ]; then 
				echo $fileo
				/scratch/cnt0024/ige2071/aalbert/git/CDFTOOLS/bin/cdfsig0 -t $filet -s $files -sal vosaline -tem votemper -o $fileo 
			fi
		done
	done
done




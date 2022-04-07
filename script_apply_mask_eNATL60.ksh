#!/bin/bash

ulimit -s unlimited

CASE=$1
REG=$2
FREQ=$3
TYP=$4
MONTH=$5

CONFIG=eNATL60

dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/${REG}
cd $dir #dir should exist

maskf=$SCRATCHDIR/${CONFIG}/${CONFIG}-I/mask_${CONFIG}${REG}_3.6.nc

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

		case $TYP in
			u10|v10) maskv=tmask; kt=8;vars=$TYP;;
		esac

		for file in $(ls ${CONFIG}${REG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${TYP}.nc); do
			fileo=$(echo $file | sed "s/.nc/_mask.nc/g")
			if [ ! -f  $fileo ]; then

				echo $fileo
				#Create the output file
				cp $file $fileo

				#Create a mask file with the same number of time_steps
				if [ ! -f  ${maskv}.nc ]; then
					ncks -v $maskv $maskf ${maskv}.nc
					ncrename -O -d t,time_counter ${maskv}.nc ${maskv}.nc
					case $TYP in
						u10|v10);;
						*) ncrename -O -d z,$dep ${maskv}.nc ${maskv}.nc;;
					esac
					for k in $(seq 1 $kt); do
						cp ${maskv}.nc ${maskv}_${k}.nc
					done
					ncrcat -O ${maskv}_?.nc ${maskv}_??.nc ${maskv}.nc
					rm ${maskv}_?.nc ${maskv}_??.nc
				fi
				#Add the mask to the file
				ncks -A -v $maskv ${maskv}.nc $fileo
	
				#Put fill value where mask says it is on land
				for var in $vars; do
					ncrename -O -v $var,var $fileo
					ncrename -O -v $maskv,mask $fileo
					ncap2 -O -s 'where(mask!=1) var=var@_FillValue' $fileo $fileo
					ncrename -O -v var,$var $fileo
					ncrename -O -v mask,$maskv $fileo
				done

				#Clean the file
				ncks -O -x -v $maskv $fileo $fileo
			fi
		done
	done
done



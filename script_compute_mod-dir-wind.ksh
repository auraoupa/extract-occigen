#!/bin/bash

ulimit -s unlimited

REG=$1
CASE=$2
FREQ=$3
MONTH=$4

CONFIG=eNATL60

dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/${REG}
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

		for fileu in $(ls ${CONFIG}${REG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_u10.nc); do
			filev=$(echo $fileu | sed "s/u10/v10/g")
			filet=eNATL60DYF-BLB002_y2009m07d01.1h_sossheig.nc

			fileo=$(echo $fileu | sed "s/u10/wind10/g")

			fileuu=$(echo $fileu | sed "s/u10/vozocrtx/g")
			filevv=$(echo $filev | sed "s/v10/vomecrty/g")

			cp $fileu $fileuu
			ncrename -v u10,vozocrtx $fileuu
			cp $filev $filevv
			ncrename -v v10,vomecrty $filevv

			if [ ! -f  $fileo ]; then

			        echo $fileo
			        $SCRATCHDIR/git/CDFTOOLS/bin/cdfvita -u $fileuu -v $filevv -t $filet -o $fileo
			fi

			rm $fileuu $filevv

		done
	done
done

#!/bin/bash

month=$1
CASE=$2

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
        date=y${year}m${mm}d${dd}

	./script_project_wind_ERAi_eNATL60_1day.ksh $date $CASE


done



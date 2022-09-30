#!/bin/bash

MONTH=$1
CASE=BLB002

case $MONTH in
                7|8|9|10|11|12) year=2009;;
                1|2|3|4|5|6|19|20|21|22) year=2010;;
esac

case $MONTH in
                1|3|5|7|8|10|12|19|20|22) day1=1; day2=31;;
                4|6|9|11|21) day1=1; day2=30;;
                2) day1=1; day2=28;;
esac
case $MONTH in
                        1|2|3|4|5|6|7|8|9|10|11|12) monthi=$MONTH;;
                        19) monthi=7;;
                        20) monthi=8;;
                        21) monthi=9;;
                        22) monthi=10;;
esac

for day in $(seq $day1 $day2); do

	./compute_vertmean_eNATL60_1day.ksh eNATL60 $CASE 1h $year $monthi $day 0 10

done

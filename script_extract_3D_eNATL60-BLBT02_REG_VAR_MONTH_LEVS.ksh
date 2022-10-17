month=MONTH

case $month in
      7|8|9|10|11|12) year=2009;;
         1|2|3|4|5|6) year=2010;;
         19|20|21|22) year=2010;;
esac

case $month in
      1|3|5|7|8|10|12|19|20|22) day1=1; day2=31;;
      4|6|9|11|21) day1=1; day2=30;;
      2) day1=1; day2=28;;
esac

case $month in
	19) month=7;;
	20) month=8;;
	21) month=9;;
	22) month=10;;
esac

for day in $(seq $day1 $day2); do
	mm=$(printf "%02d" $month)
        dd=$(printf "%02d" $day)
	date=${year}${mm}${dd}

	./script_extract_3D_eNATL60.ksh REG BLBT02 1h VAR ${date} LEV1-LEV2
done

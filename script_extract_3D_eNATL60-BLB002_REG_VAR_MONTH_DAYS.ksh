month=MONTH
day1=DAY1
day2=DAY2

case $month in
      7|8|9|10|11|12) year=2009;;
         1|2|3|4|5|6) year=2010;;
esac


for day in $(seq $day1 $day2); do
	mm=$(printf "%02d" $month)
        dd=$(printf "%02d" $day)
	date=${year}${mm}${dd}

	./script_extract_3D_eNATL60.ksh REG BLB002 1h VAR ${date} 0-bot
done

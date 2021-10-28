month=7

case $month in
      7|8|9|10|11|12) year=2009;;
         1|2|3|4|5|6) year=2010;;
esac

case $month in
      1|3|5|7|8|10|12) day1=1; day2=31;;
      4|6|9|11) day1=1; day2=30;;
      2) day1=1; day2=28;;
esac

for day in $(seq $day1 $day2); do
	mm=$(printf "%02d" $month)
        dd=$(printf "%02d" $day)
	date=${year}${mm}${dd}

	./script_extract_3D_eNATL60.ksh NOE BLBT02 1h VAR ${date} 0-bot
done

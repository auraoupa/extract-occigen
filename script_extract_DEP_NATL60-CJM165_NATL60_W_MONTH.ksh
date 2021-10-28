month=MONTH

case $month in
      10|11|12) year=2012;;
      1|2|3|4|5|6|7|8|9) year=2013;;
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

	./script_extract_3D_NATL60.ksh NATL60 CJM165 1d vovecrtz ${date} DEP
done

CONFIG=$1
CASE=$2
FREQ=$3
REG=$4
VARS=$5
MONTH=$6


mkdir -p /store/aalbert/${CONFIG}/${CONFIG}-${CASE}-S/$FREQ/$REG

cd /work/aalbert/${CONFIG}/${CONFIG}-${CASE}-S/$FREQ/$REG

for month in $MONTH; do
	for var in $VARS; do 
		case $month in 
			1|2|3|4|5|6) year=2010;monthi=$month;;
			7|8|9|10|11|12) year=2009;monthi=$month;;
			19) monthi=7;year=2010;;
			20) monthi=8;year=2010;;
			21) monthi=9;year=2010;;
			22) monthi=10;year=2010;;
		esac
		mm=$(printf "%02d" $monthi)
		tar -cvf ${var}_y${year}m${mm}.tar *y${year}m${mm}*${var}*
		dd if=${var}_y${year}m${mm}.tar of=/store/aalbert/${CONFIG}/${CONFIG}-${CASE}-S/$FREQ/$REG/${var}_y${year}m${mm}.tar bs=10M
	done
done

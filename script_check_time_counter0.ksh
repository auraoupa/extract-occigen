CONFIG=$1
CASE=$2
REG=$3
FREQ=$4
VAR=$5
sREG=$6

echo "checking "$VAR" files in /work/aalbert/"$CONFIG"/"${CONFIG}"-"${CASE}"-S/"$FREQ"/"$REG"/"

for file in $(ls /work/aalbert/$CONFIG/${CONFIG}-${CASE}-S/$FREQ/$REG/${CONFIG}${sREG}-${CASE}_*.${FREQ}_${VAR}.nc); do 
	tt=$(ncdump -h $file | grep UNLIMITED | awk -F\( '{print $2}' | awk '{print $1}')
	if [ $tt -eq '0' ]; then
		echo $tt $file
	fi
done 



CONFIG=$1
CASE=$2
REG=$3
FREQ=$4
VAR=$5
sREG=$6

for file in $(ls /work/aalbert/$CONFIG/${CONFIG}-${CASE}-S/$FREQ/$REG/${CONFIG}${sREG}-${CASE}_*.${FREQ}_${VAR}.nc); do 
	size=$(ls -lrth $file | awk '{print $5}')
	if [ $size == 0 ]; then rm $file; fi
done



CONFIG=$1
CASE=$2
REG=$3
FREQ=$4
VAR=$5
sREG=$6

for file in $(ls /scratch/cnt0024/ige2071/aalbert/$CONFIG/${CONFIG}-${CASE}-S/$FREQ/$REG/${CONFIG}${sREG}-${CASE}_*.${FREQ}_${VAR}.nc); do echo $file; ncdump -h $file | grep UNLIMITED; done > check_time_${CONFIG}${sREG}-${CASE}_${FREQ}_${VAR}.txt



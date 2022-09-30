CONFIG=$1
CASE=$2
REG=$3
FREQ=$4
FILETYP=$5
VAR=$6

for file in $(ls /work/aalbert/$CONFIG/${CONFIG}-${CASE}-S/$FREQ/$REG/${CONFIG}${REG}-${CASE}_*.${FREQ}_${FILETYP}.nc); do

	ncks -O -x -v $VAR $file $file
done

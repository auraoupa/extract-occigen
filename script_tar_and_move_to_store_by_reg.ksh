CONFIG=$1
CASE=$2
FREQ=$3
REG=$4



mkdir -p /store/aalbert/${CONFIG}/${CONFIG}-${CASE}-S/$FREQ

cd $SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/$FREQ

for reg in $REG; do 
	tar -cvf $reg.tar $reg
	dd if=$reg.tar of=/store/aalbert/${CONFIG}/${CONFIG}-${CASE}-S/$FREQ/$reg.tar bs=10M
done

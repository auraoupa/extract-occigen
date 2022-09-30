CONFIG=$1
CASE=$2
FREQ=$3
REG=$4
VARS=$5


mkdir -p /store/aalbert/${CONFIG}/${CONFIG}-${CASE}-S/$FREQ/$REG

cd $SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/$FREQ/$REG

for var in $VARS; do 
	tar -cvf $var.tar *${var}*
	dd if=$var.tar of=/store/aalbert/${CONFIG}/${CONFIG}-${CASE}-S/$FREQ/$REG/$var.tar bs=10M
done

CONFIG=eNATL60
CASE=BLB002
FREQ=1h
REG=eNATL60
VAR=Uvertmean0-10m


for month in $(seq 1 12) 19; do
	./script_tar_and_move_to_store_by_month.ksh $CONFIG $CASE $FREQ $REG $VAR $month
done


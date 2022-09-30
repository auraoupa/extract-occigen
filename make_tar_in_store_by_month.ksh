CONFIG=eNATL60
CASE=BLBT02
FREQ=1h
REG=eNATL60-degrad
VAR=Vbottomdegrad


for month in $(seq 1 12); do
	./script_tar_in_store_by_month.ksh $CONFIG $CASE $FREQ $REG $VAR $month
done


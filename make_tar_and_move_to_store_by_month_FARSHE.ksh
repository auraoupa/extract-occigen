CONFIG=eNATL60
CASE=BLBT02
FREQ=1d
REG=FARSHE

for var in flxT gridT-2D gridU-2D gridV-2D vomecrty_0-3882m vosaline_0-3882m votemper_0-3882m vozocrtx_0-3882m; do
	for month in $(seq 1 7); do
		./script_tar_and_move_to_store_by_month.ksh $CONFIG $CASE $FREQ $REG $var $month
	done
done


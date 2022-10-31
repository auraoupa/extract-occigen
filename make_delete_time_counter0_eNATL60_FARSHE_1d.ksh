CONFIG=eNATL60
CASE=BLBT02
FREQ=1d

for reg in FARSHE; do 
#	for var in flxT gridT-2D gridU-2D gridV-2D; do
	for var in vomecrty_0-3882m vosaline_0-3882m votemper_0-3882m vozocrtx_0-3882m; do
		./script_delete_time_counter0.ksh $CONFIG $CASE $reg $FREQ $var $reg
	done
done

CONFIG=eNATL60
CASE=BLBT02
FREQ=1d

for reg in FAROE; do 
#	for var in flxT gridT-2D gridU-2D gridV-2D; do
	for var in vomecrty_0-botm vosaline_0-botm votemper_0-botm vozocrtx_0-botm; do
		./script_check_time_counter0.ksh $CONFIG $CASE $reg $FREQ $var $reg
	done
done

CONFIG=eNATL60
CASE=BLBT02
FREQ=1d



for reg in LIONb; do 
#	for var in flxT sometauy sozotaux vosaline_1-200 votemper_1-200; do
#                ./script_check_nb_files.ksh $CONFIG $CASE ${reg} $FREQ $var $reg
#                ./script_check_time_counter0.ksh $CONFIG $CASE ${reg} $FREQ $var $reg
#	done
#	for var in sometauy_degrad5 sozotaux_degrad5 vosaline_degrad5 votemper_degrad5 sowaflup_degrad5 qt_oce_degrad5 qsr_oce_degrad5; do
	for var in votemper_degrad5; do
#		./script_check_nb_files.ksh $CONFIG $CASE ${reg}-degrad $FREQ $var $reg
		#./script_check_time_counter0.ksh $CONFIG $CASE ${reg}-degrad $FREQ $var $reg
		./script_delete_time_counter0.ksh $CONFIG $CASE ${reg}-degrad $FREQ $var $reg
	done
done

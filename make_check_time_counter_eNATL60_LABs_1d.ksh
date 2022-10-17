CONFIG=eNATL60
CASE=BLBT02
FREQ=1d

for reg in LABs; do 
	for var in flxT sometauy sozotaux vosaline_1-200 votemper_1-200; do
		./script_check_time_counter0.ksh $CONFIG $CASE $reg $FREQ $var $reg
	done
done

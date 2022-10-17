CONFIG=eNATL60
CASE=BLBT02
REG=LABs
sREG=LABs
FREQ=1d

#for var in flxT sometauy sozotaux vosaline_1-200 votemper_1-200; do
for var in vosaline_1-200 votemper_1-200; do
	./script_delete_time_counter0.ksh $CONFIG $CASE $REG $FREQ $var $sREG
done

CONFIG=eNATL60
CASE=BLBT02
REG=LABs
sREG=LABs
FREQ=1d

#for var in flxT sometauy sozotaux vosaline_1-200 votemper_1-200; do
#for var in vosaline_1-200 votemper_1-200; do
        for var in sometauy_degrad5 sozotaux_degrad5 vosaline_degrad5 votemper_degrad5 sowaflup_degrad5 qt_oce_degrad5 qsr_oce_degrad5; do

	./script_delete_time_counter0.ksh $CONFIG $CASE ${REG}-degrad $FREQ $var $sREG
done

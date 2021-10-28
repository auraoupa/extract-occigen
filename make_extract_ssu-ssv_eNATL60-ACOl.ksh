
for month in $(seq 1 12); do
	./script_extract_surf_eNATL60_1month.ksh ACOl BLB002 1h 'sozocrtx' $month
	./script_extract_surf_eNATL60_1month.ksh ACOl BLB002 1h 'somecrty' $month
	./script_extract_surf_eNATL60_1month.ksh ACOl BLBT02 1h 'sozocrtx' $month
	./script_extract_surf_eNATL60_1month.ksh ACOl BLBT02 1h 'somecrty' $month
done

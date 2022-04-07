#!/bin/bash

DATE=$1
CASE=$2

dir=$SCRATCHDIR/eNATL60/eNATL60-I/FATM


mkdir -p $dir
cd $dir

sdir=$SCRATCHDIR/eNATL60/eNATL60-${CASE}-S/3h/eNATL60
mkdir -p $sdir

for var in u10 v10; do

	source ~/.bashrc
	load_default

	file=drowned_${var}_DFS5.2_${DATE}.nc
	filet=drowned_${var}_DFS5.2_${DATE}_time_counter.nc
	if [ ! -f $filet ]; then
		cp $file $filet
		ncks -O -F -d time_counter,1,24,3 $SCRATCHDIR/eNATL60/eNATL60-${CASE}-S/1h/DYF/eNATL60DYF-${CASE}_${DATE}.1h_sossheig.nc eNATL60-${CASE}_${DATE}.3h_time_counter.nc
		ncrename -O -d time_counter,time eNATL60-${CASE}_${DATE}.3h_time_counter.nc
	        ncks -A -v time_counter eNATL60-${CASE}_${DATE}.3h_time_counter.nc $filet
	        ncap2 -O -s "time=time_counter" $filet $filet
	        ncks -O -x -v time_counter $filet $filet
	        ncrename -O -d time,time_counter $filet
	        ncrename -O -v time,time_counter $filet
	fi

	case $var in
		u10) mask=umaskutil; lon=glamu; lat=gphiu;;
		v10) mask=vmaskutil; lon=glamv; lat=gphiv;;
	esac
	if [ ! -f $sdir/eNATL60-${CASE}_${DATE}.3h_${var}.nc ]; then
		echo "projecting eNATL60-${CASE}_"${DATE}".3h_"${var}".nc"
		load_intel_lb

		cp /home/aalbert/EXTRACT.restored/namelist_sosie_ERAi-eNATL60 namelist_sosie_ERAi-eNATL60_${var}${DATE}
		sed -i "s%FILEIN%$filet%g" namelist_sosie_ERAi-eNATL60_${var}${DATE}
		sed -i "s/VARIN/${var}/g" namelist_sosie_ERAi-eNATL60_${var}${DATE}
		sed -i "s/VAROUT/${var}/g" namelist_sosie_ERAi-eNATL60_${var}${DATE}
		sed -i "s/MASK/${mask}/g" namelist_sosie_ERAi-eNATL60_${var}${DATE}
		sed -i "s/LON/${lon}/g" namelist_sosie_ERAi-eNATL60_${var}${DATE}
		sed -i "s/LAT/${lat}/g" namelist_sosie_ERAi-eNATL60_${var}${DATE}
		sed -i "s/DATE/$DATE/g" namelist_sosie_ERAi-eNATL60_${var}${DATE}

		/store/brodeau/DEV/sosie/bin/sosie3.x -f namelist_sosie_ERAi-eNATL60_${var}${DATE}
		mv ${var}_ERAi-eNATL60_${DATE}.nc $sdir/eNATL60-${CASE}_${DATE}.3h_${var}.nc
	fi
done




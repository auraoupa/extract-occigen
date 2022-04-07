#!/bin/bash

REG=$1
LEVS=$2


CONFIG=eNATL60

case $REG in
	LION) coord='-d x,6126,6135 -d y,2439,2448'; sREG=LION;;
	NOE) coord='-d x,4014,4134 -d y,1438,1576'; sREG=NOE;;
	ACOl) coord='-d x,3774,4789 -d y,1507,2235'; sREG=ACOl;;
	MEDWEST) coord='-d x,5530,6412 -d y,1870,2672'; sREG=MEDWEST;;
	NANFL) coord='-d x,2574,3478 -d y,1509,2236'; sREG=NANFL;;
	COSNWA) coord='-d x,2905,3027 -d y,1829,1976'; sREG=COSNWA;;
	MEDBAL) coord='-d x,5922,6035 -d y,2222,2391'; sREG=MEDBAL;;
	OSMOSISb) coord='-d x,4424,4831 -d y,2630,3535'; sREG=OSMOb;;
	OSMOSISc) coord='-d x,4879,4879 -d y,2944,2944'; sREG=OSMOc;;
	EOSMO) coord='-d x,4461,5340 -d y,2333,3895'; sREG=EOSMO;;
	EGULF) coord='-d x,1464,3106 -d y,1478,2774'; sREG=EGULF;;
	MOMAR) coord='-d x,3938,3938 -d y,2028,2028'; sREG=MOMAR;;
	LAB) coord='-d x,2450,3392 -d y,3618,4365'; sREG=LAB;;
        DYF) coord='-d x,6297,6351 -d y,2513,2605'; sREG=DYF;;
	SICIL) coord='-d x,6352,6935 -d y,1656,2311'; sREG=SICIL;;
	pDYF) coord='-d x,6323,6323 -d y,2582,2582'; sREG=pDYF;;
esac

dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-I
mkdir -p $dir
cd $dir

if [ ! -z "$LEVS" ]; then
	LEV1=$( echo $LEVS | awk -F- '{print $1}' )
	LEV2=$( echo $LEVS | awk -F- '{print $2}' )
	case $LEV1 in
        	0) indZ1=1;;
	esac

	case $LEV2 in
        	1000) indZ2=107;; #check /store/CT1/hmg2840/lbrodeau/eNATL60/eNATL60-I/deptht.txt
        	2000) indZ2=158;; #check /store/CT1/hmg2840/lbrodeau/eNATL60/eNATL60-I/deptht.txt
        	bot) indZ2=300;; #check /store/CT1/hmg2840/lbrodeau/eNATL60/eNATL60-I/deptht.txt
	esac
fi

stdir=/store/CT1/hmg2840/lbrodeau/${CONFIG}/${CONFIG}-I

for file in coordinates_eNATL60.nc eNATL60_BATHY_GEBCO_2014_2D_msk_v3.1_lb.nc4 mask_eNATL60_3.6.nc mesh_hgr_eNATL60_3.6.nc mesh_zgr_eNATL60_3.6.nc; do
	echo $file
	fileo=$(echo $file | sed "s/eNATL60/eNATL60${sREG}/g")
	if [ $file == 'mesh_hgr_eNATL60_3.6.nc' ] || [ $file == 'mesh_zgr_eNATL60_3.6.nc' ]; then
		if [ ! -z "$LEVS" ]; then
			if [ ! -f  $fileo ]; then echo $fileo; ncks -O -F -d z,$indZ1,$indZ2 $coord $stdir/$file $fileo; fi
		else
			if [ ! -f  $fileo ]; then echo $fileo; ncks -O -F $coord $stdir/$file $fileo; fi
		fi
	else
		if [ ! -f  $fileo ]; then echo $fileo; ncks -O -F $coord $stdir/$file $fileo; fi
	fi

done




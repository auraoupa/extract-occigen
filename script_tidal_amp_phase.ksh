#!/bin/ksh

CONFIGd=$1
CONFIG=$2
CASE=$3
NAMELIST=$4
YEARS=$5


case $CONFIGd in
	eNATL60) stdir=/store/CT1/hmg2840/lbrodeau;;
	TROPICO12) stdir=/store/CT1/ige2071/brodeau;;
esac

dir=$SCRATCHDIR/${CONFIGd}/${CONFIGd}-${CASE}-S/1h/tide
mkdir -p $dir
cd $dir

rm ${CONFIG}-${CASE}*_1h_*_gridT-2D*.nc*

YEAR1=$( echo $YEARS | awk -F- '{print $1}' )
YEAR2=$( echo $YEARS | awk -F- '{print $2}' )

if [ ! -z $YEAR2 ]; then
	for year in $(seq $YEAR1 $YEAR2); do
		ln -sf $stdir/${CONFIGd}/${CONFIG}-${CASE}*-S/????????-????????/${CONFIG}-${CASE}*_1h_*_gridT-2D*${year}*.nc* .
	done
else
	ln -sf $stdir/${CONFIGd}/${CONFIG}-${CASE}*-S/????????-????????/${CONFIG}-${CASE}*_1h_*_gridT-2D*${YEAR1}*.nc* .
fi

cp /home/aalbert/EXTRACT-git/$NAMELIST namelist 

/scratch/cnt0024/ige2071/aalbert/git/TIDAL_TOOLS/bin/tid_harm_ana -l *gridT-2D*nc*


if [ ! -z $YEAR2 ]; then
	mv res_harm_ssh_0-360.nc res_harm_ssh_0-360_${YEAR1}-${YEAR2}.nc
else 
	mv res_harm_ssh_0-360.nc res_harm_ssh_0-360_${YEAR1}.nc
fi


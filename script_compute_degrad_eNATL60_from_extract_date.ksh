#!/bin/bash

ulimit -s unlimited

REG=$1
CASE=$2
FREQ=$3
VAR=$4
DATE=$5
ratio=$6

CONFIG=eNATL60

dir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/${REG}-degrad
mkdir -p $dir
cd $dir

case $REG in
	eNATL60) sREG='';;
        MEDWEST) sREG=MEDWEST;;
        NANFL)   sREG=NANFL;;
esac

if [ ! -f  mask.nc ]; then ln -sf /store/CT1/hmg2840/lbrodeau/eNATL60/eNATL60-I/mask_${CONFIG}${sREG}_3.6.nc mask.nc; fi
if [ ! -f  mesh_hgr.nc ]; then ln -sf /store/CT1/hmg2840/lbrodeau/eNATL60/eNATL60-I/mesh_hgr_${CONFIG}${sREG}_3.6.nc mesh_hgr.nc; fi
if [ ! -f mesh_zgr.nc ]; then ln -sf /store/CT1/hmg2840/lbrodeau/eNATL60/eNATL60-I/mesh_zgr_${CONFIG}${sREG}_3.6.nc mesh_zgr.nc; fi



for date in $DATE; do
    	for var in $VAR; do

      		if [ $REG == 'eNATL60' ]; then
      			case $var in
        			sossheig) filetyp=gridT-2D; pt=T;;
        			sosstsst) filetyp=gridT-2D; pt=T;;
        			sosaline) filetyp=gridT-2D; pt=T;;
        			sozocrtx) filetyp=gridU-2D; pt=U;;
        			somecrty) filetyp=gridV-2D; pt=V;;
				Ubottom) filetyp=$var; pt=U;var=vozocrtx;;
				Vbottom) filetyp=$var; pt=V;var=vomecrty;;
      			esac

      			stdir=$SCRATCHDIR/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/${REG}
      			for file in $(ls $stdir/${CONFIG}${sREG}-${CASE}_${date}.${FREQ}_${filetyp}.nc); do

        			fileo=${CONFIG}${sREG}-${CASE}_${date}.${FREQ}_${filetyp}degrad.nc
        			if [ ! -f  $fileo ]; then echo $fileo; ulimit -s unlimited; /scratch/cnt0024/ige2071/aalbert/git/CDFTOOLS/bin/cdfdegrad -f ${file} -v ${var} -r $ratio $ratio -p ${pt} -o ${fileo}; fi
      			done
    		fi
	done
done


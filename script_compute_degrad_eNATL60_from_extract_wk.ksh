#!/bin/bash

ulimit -s unlimited

REG=$1
CASE=$2
FREQ=$3
VAR=$4
MONTH=$5
ratio=$6

CONFIG=eNATL60

dir=/work/aalbert/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/${REG}-degrad
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



for month in $MONTH; do
    case $month in
      7|8|9|10|11|12) year=2009;;
         1|2|3|4|5|6) year=2010;;
    esac

    case $month in
      1|3|5|7|8|10|12) day1=1; day2=31;;
      4|6|9|11) day1=1; day2=30;;
      2) day1=1; day2=28;;
    esac

    for day in $(seq $day1 $day2); do
	mm=$(printf "%02d" $month)
        dd=$(printf "%02d" $day)

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

      			stdir=/work/aalbert/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/${REG}
      			for file in $(ls $stdir/${CONFIG}${sREG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${filetyp}.nc); do

        			fileo=${CONFIG}${sREG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${filetyp}degrad.nc
        			if [ ! -f  $fileo ]; then echo $fileo; ulimit -s unlimited; /work/aalbert/git/CDFTOOLS/bin/cdfdegrad -f ${file} -v ${var} -r $ratio $ratio -p ${pt} -o ${fileo}; fi
      			done
    		else
        		case $var in
                		sossheig) pt=T;;
                		sosstsst) pt=T;;
                		sosaline) pt=T;;
                		sozocrtx) pt=U;;
                		somecrty) pt=V;;
        		esac
			stdir=/work/aalbert/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/${REG}
			for file in $(ls $stdir/${CONFIG}${REG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${var}.nc); do
				fileo=${CONFIG}${REG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${var}_degrad${ratio}.nc
				if [ ! -f  $fileo ]; then echo $fileo; /scratch/cnt0024/hmg2840/albert7a/DEV/CDFTOOLS/bin/cdfdegrad -f ${file} -v ${var} -r $ratio $ratio -p ${pt} -o ${fileo}; fi
  			done
    		fi
	done
    done
done


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
	eNATL60) sREG=''; idir= /store/CT1/hmg2840/lbrodeau/eNATL60/eNATL60-I/;;
        *) sREG=$REG; idir=/work/aalbert/eNATL60/eNATL60-I;;
esac

if [ ! -f  mask.nc ]; then ln -sf $idir/mask_${CONFIG}${sREG}_3.6.nc mask.nc; fi
if [ ! -f  mesh_hgr.nc ]; then ln -sf $idir/mesh_hgr_${CONFIG}${sREG}_3.6.nc mesh_hgr.nc; fi
if [ ! -f mesh_zgr.nc ]; then ln -sf $idir/mesh_zgr_${CONFIG}${sREG}_3.6.nc mesh_zgr.nc; fi



for month in $MONTH; do
    case $month in
      7|8|9|10|11|12) year=2009;;
         1|2|3|4|5|6|19|20|21|22) year=2010;;
    esac

    case $month in
      1|3|5|7|8|10|12|19|20|22) day1=1; day2=31;;
      4|6|9|11|21) day1=1; day2=30;;
      2) day1=1; day2=28;;
    esac
    case $month in
    	1|2|3|4|5|6|7|8|9|10|11|12) monthi=$month;;
        19) monthi=7;;
        20) monthi=8;;
        21) monthi=9;;
        22) monthi=10;;
    esac

    for day in $(seq $day1 $day2); do
	mm=$(printf "%02d" $monthi)
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
        			if [ ! -f  $fileo ]; then echo $fileo; ulimit -s unlimited; /scratch/cnt0024/ige2071/aalbert/git/CDFTOOLS/bin/cdfdegrad -f ${file} -v ${var} -r $ratio $ratio -p ${pt} -o ${fileo}; fi
      			done
    		else
        		case $var in
                		votemper_1-200) pt=T;filetyp=$var;var=votemper;;
                		vosaline_1-200) pt=T;filetyp=$var;var=vosaline;;
                		sossheig|sosstsst|sosaline) pt=T;filetyp=$var;;
                		sozocrtx|sozotaux) pt=U;filetyp=$var;;
                		somecrty|sometauy) pt=V;filetyp=$var;;
				sowaflup|qsr_oce|qt_oce) pt=T; filetyp=flxT;;
        		esac
			stdir=/work/aalbert/${CONFIG}/${CONFIG}-${CASE}-S/${FREQ}/${REG}
			for file in $(ls $stdir/${CONFIG}${REG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${filetyp}.nc); do
				fileo=${CONFIG}${REG}-${CASE}_y${year}m${mm}d${dd}.${FREQ}_${var}_degrad${ratio}.nc
				if [ ! -f  $fileo ]; then echo $fileo; /work/aalbert/git/CDFTOOLS/bin/cdfdegrad -f ${file} -v ${var} -r $ratio $ratio -p ${pt} -o ${fileo}; fi
  			done
    		fi
	done
    done
done


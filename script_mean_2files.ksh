CONFIG=$1
CASE=$2
REG=$3
FREQ=$4
FILETYP1=$5
FILETYP2=$6
VAR=$7

ulimit -s unlimited

case $REG in
	eNATL60) sREG='';;
	*) sREG=$REG;;
esac

for file in $(ls /work/aalbert/$CONFIG/${CONFIG}-${CASE}-S/$FREQ/$REG/${CONFIG}${sREG}-${CASE}_*.${FREQ}_${FILETYP1}.nc); do

	file2=$(echo $file | sed "s/${FILETYP1}/${FILETYP2}/g")
	fileo=$(echo $file | sed "s/${FILETYP1}/${FILETYP1}m/g")
	/work/aalbert/git/CDFTOOLS/bin/cdfmoy_weighted -l $file $file2 -o $fileo
#	cp $file tmp.nc
#	cp $file2 tmp2.nc
#	ncrename -v ${VAR},var1 tmp.nc
#	ncrename -v ${VAR},var2 tmp2.nc
#	ncks -A -v ${VAR}2 tmp2.nc tmp.nc
#	ncap2 -O -s 'var3=0.5*(var1+var2)' tmp.nc tmp.nc
#	ncks -O -x -v var1 tmp.nc tmp.nc
#	ncks -O -x -v var2 tmp.nc tmp.nc
#	ncrename -v var3,${VAR} tmp.nc
#	cp tmp.nc $file
	
#	rm tmp.nc tmp2.nc	
done

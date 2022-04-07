#!/bin/bash

CONFIG=eNATL60
CASE=BLB002
REG=pDYF
FREQ=1h

#for filetyp in sozotaux sometauy; do
#	for year in 2010; do
#		./script_concat_by_year.ksh $CONFIG $CASE $REG $FREQ ${filetyp} ${year}
#	done
#done
for filetyp in sig0_0-2500m ; do
	for year in 2009 2010; do
		./script_concat_by_year.ksh $CONFIG $CASE $REG $FREQ ${filetyp} ${year}
	done
done


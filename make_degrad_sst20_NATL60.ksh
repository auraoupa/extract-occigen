
for m in $(seq 1 12); do
	./script_compute_degrad_NATL60.ksh NATL60 CJM165 1d sosstsst $m 3
done

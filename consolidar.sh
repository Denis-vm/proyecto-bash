#!/bin/bash

while true; do
for archivo in entrada/*.txt; do

	if [ -f "$archivo" ]; then
		cat $archivo >> salida/"$FILENAME".txt
		mv $archivo procesado/
	
		fecha=$(date +"%d/%m/%Y %H:%M:%S")
		nombre=$(basename "$archivo")
		echo "$fecha - Procesado archivo $nombre" >> procesado.log
	fi
	done

	sleep 1
done

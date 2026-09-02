#!/bin/bash

while true; do
for archivo in "$HOME/EPNro1/entrada/"*.txt; do

	if [ -f "$archivo" ]; then
		cat "$archivo" >> "$HOME/EPNro1/salida/$FILENAME.txt"
		mv "$archivo" "$HOME/EPNro1/procesado/"
	
		fecha=$(date +"%d/%m/%Y %H:%M:%S")
		nombre=$(basename "$archivo")
		echo "$fecha - Procesado archivo $nombre" >> "$HOME/EPNro1/procesado.log"
	fi
	done

	sleep 1
done

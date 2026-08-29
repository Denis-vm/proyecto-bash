#!/bin/bash

DIR_BASE="$HOME/EPNro1"
ENTRADA_DIR="$DIR_BASE/entrada"
SALIDA_DIR="$DIR_BASE/salida"
PROCESADO_DIR="$DIR_BASE/procesado"
LOG_FILE="$DIR_BASE/procesado.log"

FILENAME="$FILENAME"
SALIDA_FILE="$SALIDA_DIR/$FILENAME.txt"

while true; do
    for archivo in "$ENTRADA_DIR"/*.txt; do
	if [ -f "$archivo" ]; then
	   cat "$archivo" >> "$SALIDA_FILE"
	   mv "$archivo" "$PROCESADO_DIR/"
	   FECHA=$(date +"%d/%m/%Y %H:%M:%S")
	   NOMBRE=$(basename "$archivo")
	   echo "$FECHA - Procesado archivo $NOMBRE" >> "$LOG_FILE"
	fi
    done
    sleep 5
done

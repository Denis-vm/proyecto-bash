#!/bin/bash

DIR_BASE="$HOME/EPNro1"
ENTRADA_DIR="$DIR_BASE/entrada"
SALIDA_DIR="$DIR_BASE/salida"
PROCESADO_DIR="$DIR_BASE/procesado"
CONSOLIDAR_SCRIPT="$DIR_BASE/consolidar.sh"
LOG_FILE="$DIR_BASE/procesado.log"

export FILENAME="$FILENAME"
SALIDA_FILE="$SALIDA_DIR/$FILENAME.txt"

if [ "$1" == "-d" ]; then
    killall -9 consolidar.sh 2>/dev/null
    rm -rf "$DIR_BASE"
    echo "Entorno y procesos eliminados"
    exit 0
fi

OPCION=0


while [ "$OPCION" -ne 7 ]
do
  echo "MENU"
  echo "1.Crear entorno"
  echo "2.Correr proceso"
  echo "3.Mostrar lista de alumnos por padron"
  echo "4.Mostrar las 10 notas mas altas"
  echo "5.Buscar alumno por padron"
  echo "6.Visualizar log"
  echo "7.Salir"
  read -p "Seleccione una opcion:" OPCION

  case $OPCION in
	1)
	   mkdir -p "$ENTRADA_DIR" "$SALIDA_DIR" "$PROCESADO_DIR"
	   cp "./consolidar.sh" "$DIR_BASE/"
	   echo "Entorno creado" ;;

	2)
	   if [ -f "$CONSOLIDAR_SCRIPT" ]; then
	   	FILENAME="$FILENAME" nohup bash "$CONSOLIDAR_SCRIPT" >/dev/null 2>&1 &
	   	echo "Proceso corriendo en background"
	   fi ;;


	3) if [ -f "$SALIDA_FILE" ]; then
	       sort -n "$SALIDA_FILE"
	   fi ;;

	4) if [ -f "$SALIDA_FILE" ]; then
	       awk '{print $NF , $0}' "$SALIDA_FILE" | sort -nr | head -n 10
	   fi ;;

	5) if [ -f "$SALIDA_FILE" ]; then
	       echo -n "Ingrese padron: "
	       read padron
	       grep "^$padron " "$SALIDA_FILE" # ^(que este al principio de la linea)
	   fi ;;

	6) if [ -f "$LOG_FILE" ]; then
	       cat "$LOG_FILE"
	   fi  ;;

	7) echo "Saliendo..."
	   exit 0 ;;

  esac
  echo ""
done

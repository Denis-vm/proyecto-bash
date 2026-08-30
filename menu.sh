#!/bin/bash

main(){
if [ "$1" = "-d" ]; then
 echo "Eliminando el entorno EPNro1 y matando procesos..."

 rm -rf "$HOME/EPNro1"

 echo "Entorno eliminado."
 exit 0
fi

if [ -n "$1" ]; then
 FILENAME="$1"
fi

if [ -z "$FILENAME" ]; then
 FILENAME="alumnos"
fi

export FILENAME

menu

}

menu(){
PS3="Seleccione una opción (1-7): "

opciones=("Crear entorno" "Correr Proceso" "Mostrar el listado de alumnos ordenados por número de padrón" "Mostrar las 10 notas más altas del listado" "Mostrar datos de un alumno" "Visualizar log" "Salir")

select opt in "${opciones[@]}"; do
	case $REPLY in
		1) crear_entorno;;

		2) correr_proceso;;

		3) listado_alumnos;;

		4) mejores_notas;;

		5) dato_alumno;;

		6) visualizar_log;;

		7) echo "Saliendo..."; break;;

		*) echo "$REPLY no es una opción válida";;
	esac
	echo ""
done
}

crear_entorno(){
mkdir -p EPNro1/entrada EPNro1/salida EPNro1/procesado
mv consolidar.sh EPNro1/consolidar.sh

echo "Entorno creado exitosamente"
}

listado_alumnos(){
echo ""
sort -k1,1n ./EPNro1/salida/"$FILENAME".txt 
}

mejores_notas(){
echo ""
sort -k5,5nr ./EPNro1/salida/"$FILENAME".txt | head -n 10
}

visualizar_log(){
cat EPNro1/procesado.log
}

correr_proceso(){
FILENAME="$FILENAME" nohup bash EPNro1/consolidar.sh &> /dev/null &
echo "Proceso corriendo en background"
}

dato_alumno(){
echo -n "Ingrese número de padrón: "
read padron
grep "^$padron " EPNro1/salida/"$FILENAME".txt
}

main "$@"

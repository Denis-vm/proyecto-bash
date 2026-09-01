#!/bin/bash

main(){
    if [ "$1" = "-d" ]; then
        echo "Eliminando el entorno EPNro1 y matando procesos..."

        pkill -f "consolidar.sh" 2> /dev/null
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
    mkdir -p "$HOME/EPNro1/entrada" "$HOME/EPNro1/salida" "$HOME/EPNro1/procesado"

    if [ -f "consolidar.sh" ]; then
        mv consolidar.sh "$HOME/EPNro1/"
    fi

    echo "Entorno creado exitosamente"
}

correr_proceso(){
    if [ -f "$HOME/EPNro1/consolidar.sh" ]; then
        if pgrep -f consolidar.sh > /dev/null; then
            echo "El proceso ya se encuentra corriendo en background"
        else
            nohup bash "$HOME/EPNro1/consolidar.sh" &> /dev/null &
            echo "Proceso corriendo en background"
        fi
    else
        echo "Primero debes crear el entorno"
    fi
}

listado_alumnos(){
    echo ""
    if verificar_salida; then
        sort -k1,1n "$HOME/EPNro1/salida/$FILENAME.txt"
    fi 
}

mejores_notas(){
    echo ""
    if verificar_salida; then
        sort -k5,5nr "$HOME/EPNro1/salida/$FILENAME.txt" | head -n 10
    fi
}

dato_alumno(){
    if verificar_salida; then
        echo -n "Ingrese número de padrón: "
        read padron
        grep "^$padron " "$HOME/EPNro1/salida/$FILENAME.txt" || echo "Padrón no encontrado"
    fi
}

visualizar_log(){
    cat "$HOME/EPNro1/procesado.log" 2> /dev/null || echo "No hay registros de log aún"
}

verificar_salida(){
    if [ ! -f "$HOME/EPNro1/salida/$FILENAME.txt" ]; then
        echo "El archivo $FILENAME.txt aún no existe en la carpeta salida."
        return 1
    fi
    return 0 
}

main "$@"

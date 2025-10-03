#!/bin/bash

#Parametros
INPUT="$1"
OUTPUT="$2"
CORES="$3"

echo "Copiando estructura de directorios..."
rsync -av --ignore-existing -f"+ */" -f"- *" input/ output/

echo "Procesando archivos WAV..."


birdnet-analyze --lat 14.45 --lon -89.70 --week 31 --threads $CORES -o $OUTPUT $INPUT

echo "Procesamiento completado."

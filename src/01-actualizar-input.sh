#!/bin/bash

# Directorio de salida
OUTPUT="input"
mkdir -p "$OUTPUT"

# Recorre todos los archivos WAV en la ruta indicada
for file in files/*/*/Data/*.wav; do
    # Verifica que el archivo exista
    [ -e "$file" ] || continue

    # Extraer fecha (YYYYMMDD del nombre)
    fecha=$(echo "$file" | grep -oE '[0-9]{8}')

    # Calcular semana ISO (01–53)
    semana=$(date -d "${fecha:0:4}-${fecha:4:2}-${fecha:6:2}" +%V)

    # Extraer grabadora (nombre antes del primer "_")
    grabadora=$(basename "$file" | cut -d'_' -f1)

    # Crear carpeta destino: input/semanaXX/GRABADORA/
    destino="$OUTPUT/semana$semana/$grabadora"
    mkdir -p "$destino"

    # Crear enlace simbólico (sobrescribe si ya existe)
    ln -sf "$(realpath "$file")" "$destino/$(basename "$file")"
done

echo "✅ Organización completa en $OUTPUT/"

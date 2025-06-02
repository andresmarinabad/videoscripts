#!/bin/bash

set -euo pipefail

SONY_CAMERA_VIDEOS="/media/andres/disk/PRIVATE/AVCHD/BDMV/STREAM/"
LOCAL_SONY_VIDEOS="$HOME/Videos/Sony"

echo "==> Iniciando importación desde $SONY_CAMERA_VIDEOS a $LOCAL_SONY_VIDEOS"

# Verifica que el directorio de origen exista
if [[ ! -d "$SONY_CAMERA_VIDEOS" ]]; then
    echo "❌ ERROR: No se encuentra el directorio de la cámara: $SONY_CAMERA_VIDEOS"
    exit 1
fi

mkdir -p "$LOCAL_SONY_VIDEOS"

# Obtener todos los archivos .MTS
mapfile -t FILES < <(find "$SONY_CAMERA_VIDEOS" -type f -name "*.MTS")
TOTAL=${#FILES[@]}
COUNT=0

echo "==> Procesando $TOTAL archivos..."

# Función para barra de progreso
progress_bar() {
    local current=$1
    local total=$2
    local filename=$3
    local width=50

    local percent=$(( current * 100 / total ))
    local done=$(( percent * width / 100 ))
    local left=$(( width - done ))
    local fill=$(printf "%${done}s")
    local empty=$(printf "%${left}s")

    local shortname=$(basename "$filename")
    shortname=${shortname:0:30}  # Máximo 30 caracteres

    printf "\r[%s%s] %3d%% (%d/%d) Procesando: %s" \
        "${fill// /#}" "${empty// /-}" "$percent" "$current" "$total" "$shortname"
}


for input_file in "${FILES[@]}"; do
    COUNT=$((COUNT + 1))
    timestamp=$(date -r "$input_file" "+%Y%m%d%H%M%S")
    output_file="$LOCAL_SONY_VIDEOS/${timestamp}.mp4"

    if ffmpeg -y -i "$input_file" -c:v copy "$output_file" -c:a aac -b:a 192k > /dev/null 2>&1 ; then
        progress_bar "$COUNT" "$TOTAL" "$input_file"
    else
        echo -e "\n❌ ERROR al procesar $input_file"
    fi
done

echo -e "\n🎉 Todos los videos fueron importados, renombrados y comprimidos."

which notify-send &>/dev/null && notify-send "🎥 Importación completa" "Los videos fueron procesados correctamente."

exit 0

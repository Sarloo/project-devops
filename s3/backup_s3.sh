#!/bin/bash

DIRECTORIO=$1
BUCKET=$2
LOG_DIR="logs"
FECHA=$(date +"%Y-%m-%d_%H-%M-%S")
ARCHIVO="backup_$FECHA.tar.gz"
LOG_FILE="$LOG_DIR/backup_$FECHA.log"
mkdir -p "$LOG_DIR"

if [ -z "$DIRECTORIO" ] || [ -z "$BUCKET" ]; then
    echo "Uso: bash backup_s3.sh <directorio> <bucket>" | tee -a "$LOG_FILE"
    exit 1
fi

if [ ! -d "$DIRECTORIO" ]; then
    echo "Error: el directorio $DIRECTORIO no existe." | tee -a "$LOG_FILE"
    exit 1
fi

echo "Comprimiendo archivos..." | tee -a "$LOG_FILE"
tar -czf "$ARCHIVO" "$DIRECTORIO"

if [ $? -ne 0 ]; then
    echo "Error al comprimir archivos." | tee -a "$LOG_FILE"
    exit 1
fi

echo "Subiendo respaldo a S3..." | tee -a "$LOG_FILE"
aws s3 cp "$ARCHIVO" "s3://$BUCKET/"

if [ $? -ne 0 ]; then
    echo "Error al subir archivo a S3." | tee -a "$LOG_FILE"
    exit 1
fi

echo "Respaldo subido correctamente: $ARCHIVO" | tee -a "$LOG_FILE"

rm -f "$ARCHIVO"
echo "Archivo temporal eliminado." | tee -a "$LOG_FILE"

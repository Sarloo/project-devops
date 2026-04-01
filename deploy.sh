#!/bin/bash

source config/config.env

ACCION=${1:-iniciar}
INSTANCE_ID=${2:-$INSTANCE_ID}
DIRECTORIO=${3:-$DIRECTORY}
BUCKET=${4:-$BUCKET_NAME}

LOG_DIR="logs"
FECHA=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/deploy_$FECHA.log"

mkdir -p "$LOG_DIR"

echo "Acción: $ACCION" | tee -a "$LOG_FILE"
echo "Instancia: $INSTANCE_ID" | tee -a "$LOG_FILE"
echo "Directorio: $DIRECTORIO" | tee -a "$LOG_FILE"
echo "Bucket: $BUCKET" | tee -a "$LOG_FILE"

python3 ec2/gestionar_ec2.py "$ACCION" "$INSTANCE_ID" | tee -a "$LOG_FILE"
if [ ${PIPESTATUS[0]} -ne 0 ]; then
    echo "Error en script EC2." | tee -a "$LOG_FILE"
    exit 1
fi

bash s3/backup_s3.sh "$DIRECTORIO" "$BUCKET" | tee -a "$LOG_FILE"
if [ ${PIPESTATUS[0]} -ne 0 ]; then
    echo "Error en backup S3." | tee -a "$LOG_FILE"
    exit 1
fi

echo "Proceso completado correctamente." | tee -a "$LOG_FILE"

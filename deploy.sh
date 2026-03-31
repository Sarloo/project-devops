#!/bin/bash

ACCION=$1
INSTANCE_ID=$2
DIRECTORIO=$3
BUCKET=$4

LOG_DIR="logs"
FECHA=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE="$LOG_DIR/deploy_$FECHA.log"

mkdir -p "$LOG_DIR"

if [ -z "$ACCION" ] || [ -z "$INSTANCE_ID" ] || [ -z "$DIRECTORIO" ] || [ -z "$BUCKET" ]; then
    echo "Uso: ./deploy.sh <accion> <instance_id> <directorio> <bucket>" | tee -a "$LOG_FILE"
    exit 1
fi

echo "Ejecutando acción EC2: $ACCION sobre $INSTANCE_ID" | tee -a "$LOG_FILE"
python3 ec2/gestionar_ec2.py "$ACCION" "$INSTANCE_ID" | tee -a "$LOG_FILE"

if [ ${PIPESTATUS[0]} -ne 0 ]; then
    echo "Error al ejecutar script EC2." | tee -a "$LOG_FILE"
    exit 1
fi

echo "Ejecutando respaldo y subida a S3..." | tee -a "$LOG_FILE"
bash s3/backup_s3.sh "$DIRECTORIO" "$BUCKET" | tee -a "$LOG_FILE"

if [ ${PIPESTATUS[0]} -ne 0 ]; then
    echo "Error al ejecutar backup S3." | tee -a "$LOG_FILE"
    exit 1
fi

echo "Deploy ejecutado correctamente." | tee -a "$LOG_FILE"

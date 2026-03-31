#!/bin/bash

DIRECTORIO=$1
BUCKET=$2
LOG_DIR="logs"
FECHA=$(date +"%Y-%m-%d_%H-%M-%S")
ARCHIVO="backup_$FECHA.tar.gz"
LOG_FILE="$LOG_DIR/backup_$FECHA.log"

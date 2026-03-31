# Proyecto DevOps

## Descripción del proyecto
Este proyecto simula un flujo básico de DevOps utilizando Git, GitHub CLI, Python, Bash y servicios de AWS.  
Permite gestionar instancias EC2, generar respaldos de archivos y subirlos a Amazon S3, además de orquestar todo desde un script principal.

## Estructura del proyecto
```bash
project-devops/
│
├── ec2/
│   └── gestionar_ec2.py
├── s3/
│   └── backup_s3.sh
├── logs/
├── config/
│   └── config.env
├── deploy.sh
└── README.md

Requisitos
	•	Git
	•	GitHub CLI
	•	Python 3
	•	AWS CLI
	•	boto3

Uso

Listar instancias
python3 ec2/gestionar_ec2.py listar

Iniciar instancia
python3 ec2/gestionar_ec2.py iniciar <instance_id>

Detener instancia
python3 ec2/gestionar_ec2.py detener <instance_id>

Terminar instancia
python3 ec2/gestionar_ec2.py terminar <instance_id>

Respaldo a S3
bash s3/backup_s3.sh <directorio> <bucket>

Deploy completo
./deploy.sh <accion> <instance_id> <directorio> <bucket>


Flujo Git
	•	main = versión estable
	•	develop = integración
	•	feature/* = desarrollo de funcionalidades

Flujo:
	1.	Crear rama feature
	2.	Desarrollar funcionalidad
	3.	Hacer commits progresivos
	4.	Push a GitHub
	5.	Merge a develop
	6.	Merge a main

Ejemplos:
python3 ec2/gestionar_ec2.py listar
python3 ec2/gestionar_ec2.py iniciar i-1234567890abcdef0
bash s3/backup_s3.sh ./data mi-bucket-devops
./deploy.sh iniciar i-1234567890abcdef0 ./data mi-bucket-devops

Guardar con `Esc` y `:wq`.

## Commit de README

```bash
git add README.md
git commit -m "docs: documentación inicial del proyecto"


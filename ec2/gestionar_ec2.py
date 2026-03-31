#!/usr/bin/env python3

import sys
import boto3
from botocore.exceptions import ClientError

def mostrar_uso():
    print("Uso:")
    print("  python3 gestionar_ec2.py listar")
    print("  python3 gestionar_ec2.py iniciar <instance_id>")
    print("  python3 gestionar_ec2.py detener <instance_id>")
    print("  python3 gestionar_ec2.py terminar <instance_id>")

def listar_instancias():
    ec2 = boto3.client("ec2")
    response = ec2.describe_instances()

    for reservation in response["Reservations"]:
        for instance in reservation["Instances"]:
            instance_id = instance.get("InstanceId", "N/A")
            state = instance.get("State", {}).get("Name", "N/A")
            instance_type = instance.get("InstanceType", "N/A")
            print(f"ID: {instance_id} | Estado: {state} | Tipo: {instance_type}")

def iniciar_instancia(instance_id):
    ec2 = boto3.client("ec2")
    ec2.start_instances(InstanceIds=[instance_id])
    print(f"Instancia {instance_id} iniciada correctamente.")

def detener_instancia(instance_id):
    ec2 = boto3.client("ec2")
    ec2.stop_instances(InstanceIds=[instance_id])
    print(f"Instancia {instance_id} detenida correctamente.")

def terminar_instancia(instance_id):
    ec2 = boto3.client("ec2")
    ec2.terminate_instances(InstanceIds=[instance_id])
    print(f"Instancia {instance_id} terminada correctamente.")

def main():
    if len(sys.argv) < 2:
        mostrar_uso()
        sys.exit(1)

    accion = sys.argv[1]

    if accion == "listar":
        listar_instancias()
    elif accion in ["iniciar", "detener", "terminar"]:
        if len(sys.argv) < 3:
            print("Error: falta el instance_id.")
            mostrar_uso()
            sys.exit(1)

        instance_id = sys.argv[2]

        if accion == "iniciar":
            iniciar_instancia(instance_id)
        elif accion == "detener":
            detener_instancia(instance_id)
        elif accion == "terminar":
            terminar_instancia(instance_id)
    else:
        print("Acción no válida.")
        mostrar_uso()
        sys.exit(1)

if __name__ == "__main__":
    main()

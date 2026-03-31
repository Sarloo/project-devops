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

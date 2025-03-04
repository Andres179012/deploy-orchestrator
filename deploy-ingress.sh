#!/bin/bash

# Parámetros que puedes cambiar
INGRESS_NAME=$1
DOMAIN_NAME=$2
SERVICE_NAME=$3
SERVICE_PORT=${4:-80}  # Si no se pasa, por defecto es 80

# Validar parámetros
if [[ -z "$INGRESS_NAME" || -z "$DOMAIN_NAME" || -z "$SERVICE_NAME" ]]; then
  echo "Uso: ./deploy-ingress.sh <ingress_name> <domain_name> <service_name> [service_port]"
  exit 1
fi

# Reemplazar los valores en la plantilla y crear el archivo final
envsubst < ingress-template.yaml > ingress.yaml

# Aplicar el Ingress en Kubernetes
kubectl apply -f ingress.yaml

echo "✅ Ingress $INGRESS_NAME creado con dominio $DOMAIN_NAME para el servicio $SERVICE_NAME en el puerto $SERVICE_PORT"

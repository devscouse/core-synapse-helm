#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

echo "Initializing minikube..."
minikube start
eval $(minikube -p minikube docker-env --shell bash)


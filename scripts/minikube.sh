#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

# Parse command-line arguments
INIT_MINIKUBE=false
UPGRADE_HELM=false

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --init) INIT_MINIKUBE=true ;;
        --upgrade) UPGRADE_HELM=true ;; 
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

if $INIT_MINIKUBE; then
    source scripts/minikube_init.sh
    minikube status
fi

if $UPGRADE_HELM; then
    bash -c scripts/upgrade.sh
    sleep 3
fi

bash scripts/minikube_expose.sh

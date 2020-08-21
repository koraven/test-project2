#!/bin/bash
cd helm
helm install storage -f init/values.yaml init/
kubectl create namespace monitoring
helm install mysql --namespace default -f mysql.yml --set persistence.storageClass=storage-init stable/mysql --version 1.6.6
helm install prometheus --namespace monitoring -f prometheus.yml --set server.persistentVolume.storageClass=storage-init stable/prometheus --version 11.12.0
helm install grafana --namespace monitoring -f grafana.yml --set persistence.storageClassName=storage-init stable/grafana --version 5.5.5
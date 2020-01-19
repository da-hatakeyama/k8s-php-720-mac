#!/bin/bash

kubectl config set-context docker-desktop --namespace=php-720

kubectl delete -f ./k8s-sv.yaml
skaffold run


@echo off

kubectl config set-context docker-desktop --namespace=php-720  
kubectl port-forward postgresql-0 5432:5432

@echo on

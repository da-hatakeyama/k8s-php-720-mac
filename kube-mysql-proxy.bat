@echo off

kubectl config set-context docker-desktop --namespace=php-720  
kubectl port-forward mysql-0 3306:3306

@echo on

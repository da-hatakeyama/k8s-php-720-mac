#!/bin/bash

/usr/local/bin/kubectl config set-context docker-desktop --namespace=php-720  
nohup /usr/local/bin/kubectl port-forward mysql-0 3306:3306 > /dev/null 2>&1 &

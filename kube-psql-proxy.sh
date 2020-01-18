#!/bin/bash

/usr/local/bin/kubectl config set-context docker-desktop --namespace=php-720  
/usr/local/bin/kubectl port-forward postgresql-0 5432:5432 > /dev/null 2>&1 &

#!/bin/bash

#### namespace作成
kubectl create namespace php-720

#### namespace切り替え
kubectl config set-context docker-desktop --namespace=php-720  

#### ＜DBのpvc構築＞
cd ~/Documents/Kubernetes/k8s-php-720-mac/1.db-disk
kubectl apply -f 1.PersistentVolume.yaml
kubectl apply -f 2.PersistentVolumeClaim.yaml

#### secretの作成
##### キーの作成は以下のようにして行う
##### echo -n "database_user" | base64
##### echo -n "database_password" | base64
##### echo -n "secret_key_base" | base64
kubectl apply -f 3.php-apache-psql-secret.yaml

#### ＜src-deployのpvc構築＞
cd ~/Documents/Kubernetes/k8s-php-720-mac/2.src-deploy-disk

#### PersistentVolumeの構築
kubectl apply -f 1.PersistentVolume.yaml

#### PersistentVolumeClaimの構築
kubectl apply -f 2.PersistentVolumeClaim.yaml

#### ＜postgreSQL構築＞
##### postgreSQLイメージビルド
cd ~/Documents/Kubernetes/k8s-php-720-mac/3.psql-rebuild
./skaffold_run.sh

#### ＜MySQL構築＞
##### MySQLイメージビルド
cd ~/Documents/Kubernetes/k8s-php-720-mac/4.mysql-rebuild
./skaffold_run.sh

#### ＜DNS(bind)構築＞
##### DNS(bind)イメージビルド
cd ~/Documents/Kubernetes/k8s-php-720-mac/5.dns
./skaffold_run.sh

#### ＜php7構築＞
##### php7イメージビルド
cd ~/Documents/Kubernetes/k8s-php-720-mac/6.php7-rebuild
./skaffold_run.sh

##### php5イメージビルド
cd ~/Documents/Kubernetes/k8s-php-720-mac/7.php5-rebuild
./skaffold_run.sh

#### ＜apache構築＞
##### apacheイメージビルド
cd ~/Documents/Kubernetes/k8s-php-720-mac/8.apache-rebuild
./skaffold_run.sh

#### ＜nuxt構築＞
##### nuxtイメージビルド
cd ~/Documents/Kubernetes/k8s-php-720-mac/9.nuxt-rebuild
./skaffold_run.sh

#### ＜mailsv構築＞
##### mailsvイメージビルド
cd ~/Documents/Kubernetes/k8s-php-720-mac/10.mailsv-rebuild
kubectl apply -f ./k8s-sv.yaml

#### ＜ingressを構築＞
##### Ingress Controllerの作成
##### 参考サイト：https://kubernetes.github.io/ingress-nginx/deploy/
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/cloud-generic.yaml
cd ~/Documents/Kubernetes/k8s-php-720-mac/11.ingress

#### sslの鍵登録 ※HTTPSを使用する際は実施
##### kubectl create secret tls example1.co.jp --key ../8.apache-rebuild/ssl/example1.co.jp/svrkey-sample-empty.key --cert ../8.apache-rebuild/ssl/example1.co.jp/svrkey-sample-empty.crt

#### Ingressの作成
kubectl apply -f 80.ingress.yaml


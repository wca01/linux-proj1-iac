#!/bin/bash

echo "atualizando servidor..."
dnf update -y
dnf upgrade -y
dnf install httpd unzip -y

echo "------ Iniciando servico HTTP ---------"
sudo systemctl start httpd.service
sudo systemctl enable httpd

echo "-----Configurando firewall e acesso HTTP no servidor------"
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --add-service=https 
sudo firewall-cmd --reload

echo "--------Atualizando rede servidor-------"
sudo systemctl stop httpd
sudo systemctl restart httpd
sudo systemctl reload httpd

echo "Configurando site..."
cd /tmp
wget https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip
unzip main.zip
cd linux-site-dio-main
cp -R * /var/www/html/

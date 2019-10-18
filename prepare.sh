#!/bin/bash
#NOTE: Change the distributer
KUBE_VER=v1.16.2

if [ $# == 1 ] 
then
    KUBE_VER=$1
fi
DEB_DIR=debs/${KUBE_VER}

dpkg -i ${DEB_DIR}/*.deb

echo "127.0.0.1 dl.k8s.io" >> /etc/hosts
swapoff -a

sleep 5
./import_images.sh images ${KUBE_VER}

swapoff -a

iptables -P FORWARD ACCEPT

ufw disable

cp daemon.json /etc/docker/
systemctl restart docker


#!/bin/bash

KUBE_VER=v1.16.2

./prepare.sh ${KUBE_VER}

#TODO
# after install master, it will show something like as below, just copy it and run at slave node.
# kubeadm join 192.168.19.242:6443 --token 3103e3.33cc37005f04433c \
#    --discovery-token-ca-cert-hash sha256:82ea893f07dba16a31569e93a921dcc094a8467d8fe7d15bde7a4fcf1d7e78bd

#!/bin/bash
KUBE_VER=v1.16.2

./prepare.sh ${KUBE_VER}

kubeadm init --pod-network-cidr 10.244.0.0/16 --token 3103e3.33cc37005f04433c
#kubeadm init --kubernetes-version=v.1.14.1 --pod-network-cidr 10.244.0.0/16 --token 3103e3.33cc37005f04433c
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=/etc/kubernetes/admin.conf
sysctl net.bridge.bridge-nf-call-iptables=1
#kubectl apply -f yaml/kube-flannel-rbac.yml  
kubectl apply -f yaml/kube-flannel-${KUBE_VER}.yml
#kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/62e44c867a2846fefb68bd5f178daf4da3095ccb/Documentation/kube-flannel.yml


kubectl taint nodes --all node-role.kubernetes.io/master-

#route add -net 10.96.0.0 netmask 255.255.0.0 dev flannel.1

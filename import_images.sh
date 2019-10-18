#!/bin/bash

DIR=images
IMG_DIR=${DIR}/v1.16.2

if [ $# == 2 ] 
then
    DIR=$1
    VER=$2
    IMG_DIR=${DIR}/$VER
fi

gzip -dkc ${IMG_DIR}/kube-proxy.tar.gz      |docker load            
gzip -dkc ${IMG_DIR}/kube-apiserver.tar.gz |docker load
gzip -dkc ${IMG_DIR}/kube-scheduler.tar.gz |docker load
gzip -dkc ${IMG_DIR}/kube-controller-manager.tar.gz |docker load

gzip -dkc ${IMG_DIR}/pause.tar.gz |docker load
gzip -dkc ${IMG_DIR}/etcd.tar.gz |docker load
gzip -dkc ${IMG_DIR}/coredns.tar.gz |docker load

while read REPOSITORY TAG IMAGE_ID
do
        echo "== Tagging $REPOSITORY $TAG $IMAGE_ID =="
        docker tag "$IMAGE_ID" "$REPOSITORY:$TAG"
done < ${IMG_DIR}/images.list


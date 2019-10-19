KUBE_VER=v1.16.2
PAUSE_VER=3.1
ETCD_VER=3.3.15-0
COREDNS_VER=1.6.2

if [ $# == 1 ] 
then
    DIR=$1
elif [ $# == 5 ]
then
    DIR=$1
    KUBE_VER=$2
    PAUSE_VER=$3
    ETCD_VER=$4
    COREDNS_VER=$5
fi

IMG_DIR=${DIR}/images/${KUBE_VER}
DEB_DIR=${DIR}/debs
mkdir ${DIR} -p
mkdir ${IMG_DIR} -p
mkdir ${DEB_DIR} -p

echo docker save k8s.gcr.io/kube-proxy:${KUBE_VER}  gzip -c               ${IMG_DIR}/kube-proxy.tar.gz
docker save k8s.gcr.io/kube-proxy:${KUBE_VER} | gzip -c              > ${IMG_DIR}/kube-proxy.tar.gz
docker save k8s.gcr.io/kube-apiserver:${KUBE_VER} | gzip -c          > ${IMG_DIR}/kube-apiserver.tar.gz
docker save k8s.gcr.io/kube-scheduler:${KUBE_VER} | gzip -c          > ${IMG_DIR}/kube-scheduler.tar.gz
docker save k8s.gcr.io/kube-controller-manager:${KUBE_VER} | gzip -c > ${IMG_DIR}/kube-controller-manager.tar.gz

docker save k8s.gcr.io/pause:${PAUSE_VER} | gzip -c   > ${IMG_DIR}/pause.tar.gz
docker save k8s.gcr.io/etcd:${ETCD_VER} | gzip -c   > ${IMG_DIR}/etcd.tar.gz
docker save k8s.gcr.io/coredns:${COREDNS_VER} | gzip -c   > ${IMG_DIR}/coredns.tar.gz

#docker images |grep "k8s.gcr.io\|quay.io" |awk '{print $1"\t"$2"\t"$3}' > ${IMG_DIR}/images.list

cd ${DEB_DIR}
curl -fsSL https://download.daocloud.io/docker/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository \
    "deb [arch=$(dpkg --print-architecture)] https://download.daocloud.io/docker/linux/ubuntu \
    $(lsb_release -cs) \
    stable"
apt-get update
apt-get download conntrack docker-ce-cli docker-ce  ebtables socat containerd.io
apt-get download cri-tools  kubeadm  kubectl  kubelet  kubernetes-cni

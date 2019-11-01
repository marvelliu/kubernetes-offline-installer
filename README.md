# Kubernetes离线安装
目前支持Ubuntu 18.04，因为是离线的，所以版本部署最新，可能对已有的软件要降级，可安装完再apt-get upgrade即可

由于已将主节点设置为可部署容器，所以可支持单节点安装，如果要单节点安装，则只需要运行install_master.sh。

## 安装说明
### 确定安装kubernetes的版本
目前支持Ubuntu 18.04，默认安装的kubernetes版本为install_master/slave.sh的KUBE_VER，如果需要安装其他版本则修改$KUBE_VER，目前支持的版本见debs/images下的目录。
### 安装
主节点运行install_master.sh，从节点运行install_slave.sh

当主节点运行完后，会出现如下提示：

kubeadm join 192.168.19.244:6443 --token 3103e3.33cc37005f04433c \
    --discovery-token-ca-cert-hash sha256:7697a85c0199533f9c891f9f2e2f92931b02d5a60ef25dfc0ad52c25f7f0f0eb

则将该命令在所有从节点运行即可。

## 注意事项
运行过程中会连接dl.k8s.io，事先已重定向到了127.0.0.1，出现warning不需要管


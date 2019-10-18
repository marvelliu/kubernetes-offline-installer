# Kubernetes离线安装
目前支持Ubuntu 16.04和18.04，因为是离线的，所以版本部署最新，可能对已有的软件要降级，可安装完再apt-get upgrade即可

## 安装说明
根据自己的Ubuntu版本修改install.sh的$(DEB_DIR)

## 注意事项
运行过程中会连接dl.k8s.io，事先已重定向到了127.0.0.1，出现warning不需要管


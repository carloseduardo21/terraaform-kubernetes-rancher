#!/bin/bash -x

curl https://releases.rancher.com/install-docker/24.0.sh | sh

sudo usermod -aG docker ubuntu

curl -fL https://rancher.strongsoftwares.com.br/system-agent-install.sh | sudo  sh -s - --server https://rancher.strongsoftwares.com.br --label 'cattle.io/os=linux' --token vx2hwq7s6vdj5g72stbrs6g72l9hbbjlntllqzfhtf5w9fnbnt46ht --etcd --controlplane --worker

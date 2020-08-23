FROM ubuntu

RUN apt upgrade -y && apt-get update -y
# Install new docker-engine based on https://docs.docker.com/engine/install/ubuntu/
RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    wget \
    gnupg-agent \
    software-properties-common

## > Get GPG key, GPG key is used when we install a package, since the docker has their own package repository it needs to validate the image
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

RUN apt-get update -y

## > Download the docker-engine
RUN apt-get install docker-ce docker-ce-cli containerd.io -y

# downloading the kubernetes binarry
RUN wget -P . https://storage.googleapis.com/kubernetes-release/release/v1.18.0/kubernetes-server-linux-amd64.tar.gz 
RUN tar -xzf ./kubernetes-server-linux-amd64.tar.gz
RUN cd /kubernetes/server/bin/ && mv kubectl kubelet kube-apiserver kube-controller-manager kube-scheduler kube-proxy /usr/bin
RUN kubectl 
RUN rm -rf kubernetes-server-linux-amd64.tar.gz kubernetes
#RUN echo "Y" | bash /kubernetes/cluster/get-kube-binaries.sh

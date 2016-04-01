FROM ubuntu
#RUN  apt-get install  -y curl
#RUN curl -L  https://github.com/coreos/etcd/releases/download/v2.3.0/etcd-v2.3.0-linux-amd64.tar.gz -o /etcd-v2.3.0-linux-amd64.tar.gz && tar xzvf /etcd-v2.3.0-linux-amd64.tar.gz 
#RUN mv /etcd-v2.3.0-linux-amd64/* /usr/bin
ADD . /usr/bin

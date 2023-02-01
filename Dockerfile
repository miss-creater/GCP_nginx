FROM ansible/centos7-ansible
LABEL maintainer jonh wick
RUN yum install -y gcc gcc-c++ make \     #将依赖包和调试工具全部安装上，清理其环境。清理yum的缓存
    openssl-devel pcre-devel gd-devel \
    iproute net-tools telnet wget curl && \
    yum clean all && \
    rm -rf /var/cache/yum/*

ADD nginx-1.16.1.tar.gz /usr/src  ##文件放在当前目录下,拷过去会自动解压

RUN cd /usr/src/nginx-1.16.1 && \
    ./configure --prefix=/usr/local/nginx \
    --with-http_ssl_module \
    --with-http_stub_status_module && \
    make && make install && \ 
    mkdir -p /usr/local/nginx/conf/vhost && \  # COPY nginx.conf/usr/local/nginx/conf/nginx.conf 如果你这里有自己的配置文件可以加上这句
    rm -rf /usr/src/nginx-1.16.1 && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime #软连接一个上海时区到当前时区

ENV PATH /usr/local/nginx/sbin:$PATH  #设置环境变量
WORKDIR /usr/local/nginx
EXPOSE 80
CMD ["nginx","-g","daemon off;"]

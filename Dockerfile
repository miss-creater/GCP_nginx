FROM centos:centos7

# 从centos基础镜像构建

# 添加nginx用户
RUN useradd -M -s /sbin/nologin nginx

# 安装相关依赖
RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
RUN  yum -y install nginx \
    && echo "hello aoppp.com" > /usr/share/nginx/html/index.html \
    && sudo tee /etc/yum.repos.d/gcsfuse.repo > /dev/null <<EOF
            [gcsfuse]
            name=gcsfuse (packages.cloud.google.com)
            baseurl=https://packages.cloud.google.com/yum/repos/gcsfuse-el7-x86_64
            enabled=1
            gpgcheck=1
            repo_gpgcheck=0
            gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
            https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
       EOF
RUN  sudo yum install gcsfuse -y && mkdir /data && gcsfuse test-nginx /data
EOFEXPOSE 80

# 启动nginx 将nginx主进程 pid为1 nginx一旦挂掉那么docker容器就会直接退出
CMD ["nginx", "-g", "daemon off;"]
CMD ["cat /data/test.html"]

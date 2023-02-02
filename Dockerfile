FROM centos:centos7

# 从centos基础镜像构建

# 添加nginx用户
RUN useradd -M -s /sbin/nologin nginx

# 安装相关依赖
RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
RUN  yum -y install nginx \
    && echo "hello aoppp.com" > /usr/share/nginx/html/index.html
RUN  sudo yum install gcsfuse -y && mkdir /data && gcsfuse test-nginx /data
EOFEXPOSE 80

# 启动nginx 将nginx主进程 pid为1 nginx一旦挂掉那么docker容器就会直接退出
CMD ["nginx", "-g", "daemon off;"]
CMD ["cat /data/test.html"]

FROM centos:centos7

# 从centos基础镜像构建

# 添加nginx用户
RUN useradd -M -s /sbin/nologin nginx

# 安装相关依赖
RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el6.ngx.noarch.rpm
RUN  yum -y install nginx \
    && echo "hello aoppp.com" > /usr/local/nginx/html/index.html

# 表示对外期望暴露得端口
EXPOSE 80

# 启动nginx 将nginx主进程 pid为1 nginx一旦挂掉那么docker容器就会直接退出
CMD ["nginx"]

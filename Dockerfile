FROM centos:centos7

# 从centos基础镜像构建

# 添加nginx用户
RUN useradd -M -s /sbin/nologin nginx

# 安装相关依赖
RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
RUN  yum -y install nginx \
    && echo "hello aoppp.com" > /usr/share/nginx/html/index.html
ADD gcsfuse.repo /etc/yum.repos.d/
ADD start.sh /tmp/
RUN chmod 777 /tmp/start.sh
RUN yum install gcsfuse -y 
EXPOSE 80
CMD ["nginx"]
CMD ["/tmp/start.sh"]

FROM centos:centos7

# 从centos基础镜像构建

# 添加nginx用户
RUN useradd -M -s /sbin/nologin nginx

# 安装相关依赖
RUN rpm -Uvh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
RUN  yum -y install nginx \
    && echo "hello aoppp.com" > /usr/share/nginx/html/index.html
ADD gcsfuse.repo /etc/yum.repos.d/
RUN yum install gcsfuse -y 
RUN mkdir /data 
RUN nohup gcsfuse test-nginx /data &
RUN touch /data/111.txt
RUN rm -rf /usr/share/nginx/html/index.html
RUN cp -p /data/test.html /usr/share/nginx/html/index.html

EXPOSE 80

# 启动nginx 将nginx主进程 pid为1 nginx一旦挂掉那么docker容器就会直接退出
CMD ["nginx", "-g", "daemon off;"]
CMD ["cat /data/test.html"]

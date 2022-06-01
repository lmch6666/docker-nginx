# 选择一个镜像系统
FROM node:14-alpine

#设置一个工作目录
WORKDIR /code

#宿主机的代码添加到镜像的工作目录之中
ADD . /code

# 安装依赖

RUN yarn

# 运行服务 启动node server
CMD npm run serverbuild

#暴露出能够访问的端口
EXPOSE 3000


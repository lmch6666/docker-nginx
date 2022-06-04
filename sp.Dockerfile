FROM node:14-alpine

#设置一个工作目录
WORKDIR /code

#宿主机的代码添加到镜像的工作目录之中 .表示所有文件
ADD . /code

EXPOSE 3000

# 初始化执行
RUN npm i && npm run build

# 运行
CMD npx serve -s dist


# VOLUME [ "/nginx.conf" ]




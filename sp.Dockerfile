FROM node:14-alpine as nodeenv

#设置一个工作目录
WORKDIR /code

# 单独分离 package.json，是为了安装依赖可最大限度利用缓存
ADD package.json /code/
RUN npm install

# 我们可以使用多阶段构建进行优化，最终使用 nginx 进行服务化。

# 第一阶段 Node 镜像: 使用 node 镜像对单页应用进行构建，生成静态资源
# 第二阶段 Nginx 镜像: 使用 nginx 镜像对单页应用的静态资源进行服务化

# EXPOSE 3000

#宿主机的代码添加到镜像的工作目录之中 .表示所有文件
# ADD . /code

# 单独分离 public/src，是为了避免 ADD . /code 时，因为 Readme/nginx.conf 的更改避免缓存生效
# 也是为了 npm run build 可最大限度利用缓存
ADD index.html /code/
ADD src /code/src
ADD public /code/public
ADD vite.config.ts /code/
ADD tsconfig.json /code/
ADD env.d.ts /code/
ADD tsconfig.vite-config.json /code/

# 初始化执行
RUN npm run build

# 运行
# CMD npx serve -s dist

FROM nginx:alpine

# ADD nginx.conf /etc/nginx/conf.d/default.conf
# 从源镜像的工作目录拷贝文件到容器的工作目录
COPY --from=nodeenv /code/dist /usr/share/nginx/html





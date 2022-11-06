#下载Node环境
FROM node:latest
LABEL description="jgaonet docoment"
#配置环境
ENV TZ Asia/Shanghai
#指定到工作目录
WORKDIR /docs
#Docker镜像环境执行npm
RUN npm install -g docsify-cli
#拷贝代码到Docker镜像工作目录
#COPY . .  不拷贝，使用挂载的方式，以免每次都需要打包
#服务透出端口
EXPOSE 3000
#开始运行服务
ENTRYPOINT docsify serve .
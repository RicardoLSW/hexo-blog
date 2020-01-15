#!/bin/bash

cd /home/hexo-blog/
docker-compose down
echo "关闭容器"

docker rmi -f $(docker images |  grep "hexo-nginx"  | awk '{print $1}')
echo "删除容器"

git pull
echo "拉取代码"

yarn install
echo "安装依赖"

yarn run build
echo "打包"

cp favicon.png public/
echo "复制网站图标到public"

docker-compose up -d
echo "生成镜像，启动容器"

docker ps

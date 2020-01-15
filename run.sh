#!/bin/bash

echo "关闭容器"
cd /home/hexo-blog/
docker-compose down

echo "删除容器"
docker rmi -f $(docker images |  grep "hexo-nginx"  | awk '{print $1}')

echo "拉取代码"
git pull

echo "安装依赖"
yarn install

echo "打包"
yarn run build

echo "复制网站图标到public"
cp favicon.png public/

echo "生成镜像，启动容器"
docker-compose up -d

docker ps

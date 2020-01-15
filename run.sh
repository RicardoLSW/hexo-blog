#!/bin/bash

cd /home/hexo-blog/
docker-compose down
echo "关闭容器"

docker rmi -f $(docker images |  grep "hexo-nginx"  | awk '{print $1}')
echo "删除容器"

git pull
rm -rf public/
yarn run build
cp favicon.png public/
echo "拉取代码，重新打包"

docker-compose up -d
echo "生成镜像，启动容器"

docker ps

---
title: Centos7一键安装Shadowsocks
date: 2019-12-15 17:48:58
tags:
---

### 适用于Centos7的Shadowsocks一键安装脚本

### 安装命令

```shell
wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh &&  
chmod +x shadowsocks-all.sh &&  
./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
```

### 卸载命令

```shell
./shadowsocks-all.sh uninstall
```

### 启动脚本

启动脚本后面的参数含义，从左至右依次为：启动，停止，重启，查看状态

1. Shadowsocks-Python 版：

   ```shell
   /etc/init.d/shadowsocks-python start | stop | restart | status
   ```

2. ShadowsocksR 版：

   ```shell
   /etc/init.d/shadowsocks-r start | stop | restart | status
   ```

3. Shadowsocks-Go 版：

   ```shell
   /etc/init.d/shadowsocks-go start | stop | restart | status
   ```

4. Shadowsocks-libev 版：

   ```shell
   /etc/init.d/shadowsocks-libev start | stop | restart | status
   ```

### 各版本默认配置文件

1. Shadowsocks-Python 版：

   ```shell
   /etc/shadowsocks-python/config.json
   ```

2. ShadowsocksR 版：

   ```shell
   /etc/shadowsocks-r/config.json
   ```

3. Shadowsocks-Go 版：

   ```shell
   /etc/shadowsocks-go/config.json
   ```

4. Shadowsocks-libev 版：

   ```shell
   /etc/shadowsocks-libev/config.json
   ```
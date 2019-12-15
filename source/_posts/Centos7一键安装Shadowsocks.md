---
title: Centos7一键安装Shadowsocks
date: 2019-12-15 17:48:58
tags:
---

```shell
wget --no-check-certificate -O shadowsocks-all.sh https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-all.sh &&  
chmod +x shadowsocks-all.sh &&  
./shadowsocks-all.sh 2>&1 | tee shadowsocks-all.log
```
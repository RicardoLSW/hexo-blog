---
title: python3.8.0一键安装脚本
---

###python3.8.0一键安装脚本

```shell
yum install gcc -y &&  
yum -y install wget &&  
yum -y groupinstall "Development tools" &&  
yum -y install zlib-devel libffi-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel &&  
wget https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tgz &&  
mkdir /usr/local/python3 &&  
tar -zxvf  Python-3.8.0.tgz &&  
cd Python-3.8.0 &&  
./configure --prefix=/usr/local/python3 &&  
make &&  
make install &&  
ln -s /usr/local/python3/bin/python3 /usr/bin/python3 &&  
ln -s /usr/local/python3/bin/pip3 /usr/bin/pip3 &&  
yum -y install epel-release &&  
yum -y install python-pip &&  
pip install --upgrade pip &&  
yum install python-devel
```


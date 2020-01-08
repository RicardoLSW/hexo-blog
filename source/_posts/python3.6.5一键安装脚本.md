---
title: python3.6.5一键安装脚本
date: 2019-12-21 17:48:58
---

### 适用于Centos7的python3.6.5一键安装脚本

```shell
yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel libpcap-devel xz-devel -y &&
yum install -y git &&  
git clone https://github.com/pyenv/pyenv.git ~/.pyenv &&  
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bash_profile &&  
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bash_profile &&  
echo -e 'if command -v pyenv 1>/dev/null 2>&1; then\n  eval "$(pyenv init -)"\nfi' >> ~/.bash_profile &&  
source .bash_profile &&  
pyenv install 3.6.5 &&  
pyenv global 3.6.5 &&
pip install --upgrade pip &&  
pip install --upgrade setuptools
```
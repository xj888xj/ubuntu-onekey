#!/bin/bash
#Author:孤_存

SYSTEM_NAME=`lsb_release -is`
SYSTEM_VERSION=`lsb_release -cs`
SYSTEM_VERSION_NUMBER=`lsb_release -rs`
echo -e '\033[37m##################################################### \033[0m'
echo -e ''
echo -e '\033[37m            提供以下国内更新源可供选择： \033[0m'
echo -e ''
echo -e '\033[37m##################################################### \033[0m'
echo -e ''
echo -e '\033[37m *  1)    中科大 \033[0m'
echo -e '\033[37m *  2)    华为云 \033[0m'
echo -e '\033[37m *  3)    阿里云 \033[0m'
echo -e '\033[37m *  4)    网易 \033[0m'
echo -e '\033[37m *  4)    搜狐 \033[0m'
echo -e '\033[37m *  6)    清华大学 \033[0m'
echo -e '\033[37m *  7)    浙江大学 \033[0m'
echo -e '\033[37m *  8)    南京大学 \033[0m'
echo -e '\033[37m *  9)    重庆大学 \033[0m'
echo -e '\033[37m *  10)   兰州大学 \033[0m'
echo -e '\033[37m *  11)   上海交通大学 \033[0m'
echo -e '\033[37m *  12)   北京交通大学 \033[0m'
echo -e '\033[37m *  13)   北京理工大学 \033[0m'
echo -e '\033[37m *  14)   南京邮电大学 \033[0m'
echo -e '\033[37m *  15)   华中科技大学 \033[0m'
echo -e '\033[37m *  16)   哈尔滨工业大学 \033[0m'
echo -e '\033[37m *  17)   北京外国语大学 \033[0m'
echo -e ''
echo -e '\033[37m##################################################### \033[0m'
echo -e ''
echo -e "\033[37m      当前操作系统  $SYSTEM_NAME $SYSTEM_VERSION_NUMBER \033[0m"
echo -e "\033[37m      当前系统时间  $(date +%Y-%m-%d) $(date +%H:%M) \033[0m"
echo -e ''
echo -e '\033[37m##################################################### \033[0m'
echo -e ''
CHOICE=$(echo -e '\033[32m请输入您想使用的国内更新源 [ 1~17 ]：\033[0m')
read -p "$CHOICE" INPUT
case $INPUT in
1)
  SOURCE="mirrors.ustc.edu.cn"
  ;;
2)
  SOURCE="mirrors.huaweicloud.com"
  ;; 
3)
  SOURCE="mirrors.aliyun.com"
  ;;
4)
  SOURCE="mirrors.163.com"
  ;;
5)
  SOURCE="mirrors.sohu.com"
  ;;
6)
  SOURCE="mirrors.tuna.tsinghua.edu.cn"
  ;;
7)
  SOURCE="mirrors.zju.edu.cn"
  ;;
8)
  SOURCE="mirrors.nju.edu.cn"
  ;;
9)
  SOURCE="mirrors.cqu.edu.cn"
  ;;
10)
  SOURCE="mirror.lzu.edu.cn"
  ;;
11)
  SOURCE="ftp.sjtu.edu.cn"
  ;;
12)
  SOURCE="mirror.bjtu.edu.cn"
  ;;
13)
  SOURCE="mirror.bit.edu.cn"
  ;;
14)
  SOURCE="mirrors.njupt.edu.cn"
  ;;
15)
  SOURCE="mirrors.hust.edu.cn"
  ;;
16)
  SOURCE="mirrors.hit.edu.cn"
  ;;
17)
  SOURCE="mirrors.bfsu.edu.cn"
  ;;
*)
  SOURCE="mirrors.ustc.edu.cn"
  echo -e ''
  echo -e '\033[33m----------输入错误，更新源将默认使用中科大源---------- \033[0m'
  sleep 3s
  ;;
esac
ls /etc/apt | grep sources.list.bak -qw
if [ $? -eq 0 ];then
  echo -e '\033[32m检测到已备份的 source.list源 文件，跳过备份操作...... \033[0m'
else
  cp -rf /etc/apt/sources.list /etc/apt/sources.list.bak
  echo -e '\033[32m已备份原有 source.list 更新源文件...... \033[0m'
fi
sleep 2s
sed -i '1,$d' /etc/apt/sources.list
echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-security main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-security main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-updates main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-proposed main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-proposed main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-backports main restricted universe multiverse" >> /etc/apt/sources.list
echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-backports main restricted universe multiverse" >> /etc/apt/sources.list
apt update

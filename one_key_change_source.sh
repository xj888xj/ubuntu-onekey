#!/bin/bash

# 一键换源脚本

# 备份当前sources.list
sudo cp /etc/apt/sources.list /etc/apt/sources.list.bak

# 获取当前Ubuntu版本代号
VERSION_CODENAME=$(lsb_release -c | awk '{print $2}')

# 提示用户选择镜像源
echo "请选择要使用的镜像源:"
echo "1) 清华大学"
echo "2) 阿里云"
echo "3) 网易"
echo "4) 搜狐"
echo "5) 华为云"
read -p "请输入选项 (1-5): " OPTION

# 根据用户选择设置sources.list
case $OPTION in
    1)
        MIRROR="https://mirrors.tuna.tsinghua.edu.cn/ubuntu/"
        ;;
    2)
        MIRROR="http://mirrors.aliyun.com/ubuntu/"
        ;;
    3)
        MIRROR="http://mirrors.163.com/ubuntu/"
        ;;
    4)
        MIRROR="http://mirrors.sohu.com/ubuntu/"
        ;;
    5)
        MIRROR="https://repo.huaweicloud.com/ubuntu/"
        ;;
    *)
        echo "无效选项，退出脚本。"
        exit 1
        ;;
esac

# 替换为选择的镜像源
sudo tee /etc/apt/sources.list > /dev/null <<EOL
deb $MIRROR $VERSION_CODENAME main restricted universe multiverse
deb $MIRROR $VERSION_CODENAME-updates main restricted universe multiverse
deb $MIRROR $VERSION_CODENAME-backports main restricted universe multiverse
deb $MIRROR $VERSION_CODENAME-security main restricted universe multiverse
deb $MIRROR $VERSION_CODENAME-proposed main restricted universe multiverse
EOL

# 更新软件包列表
sudo apt update

echo "源已成功更换为选定的镜像源！"

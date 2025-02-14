#!/bin/bash

set -e  # 如果任何命令失败，立即退出

# 获取系统信息
SYSTEM_NAME=$(lsb_release -is)
SYSTEM_VERSION=$(lsb_release -cs)
SYSTEM_VERSION_NUMBER=$(lsb_release -rs)

# 显示可选的国内更新源
echo -e '#####################################################'
echo -e '            提供以下国内更新源可供选择               '
echo -e '#####################################################'
echo -e ''
declare -A SOURCES=(
    [1]="mirrors.ustc.edu.cn 中科大"
    [2]="mirrors.huaweicloud.com 华为云"
    [3]="mirrors.aliyun.com 阿里云"
    [4]="mirrors.163.com 网易"
    [5]="mirrors.sohu.com 搜狐"
    [6]="mirrors.tuna.tsinghua.edu.cn 清华大学"
    [7]="mirrors.zju.edu.cn 浙江大学"
    [8]="mirrors.nju.edu.cn 南京大学"
    [9]="mirrors.cqu.edu.cn 重庆大学"
    [10]="mirror.lzu.edu.cn 兰州大学"
    [11]="ftp.sjtu.edu.cn 上海交通大学"
    [12]="mirror.bjtu.edu.cn 北京交通大学"
    [13]="mirror.bit.edu.cn 北京理工大学"
    [14]="mirrors.njupt.edu.cn 南京邮电大学"
    [15]="mirrors.hust.edu.cn 华中科技大学"
    [16]="mirrors.hit.edu.cn 哈尔滨工业大学"
    [17]="mirrors.bfsu.edu.cn 北京外国语大学"
)

for key in "${!SOURCES[@]}"; do
    echo -e " *  $key)    ${SOURCES[$key]#* }"
done

echo -e '#####################################################'
echo -e "      当前操作系统  $SYSTEM_NAME $SYSTEM_VERSION_NUMBER"
echo -e "      当前系统时间  $(date +%Y-%m-%d) $(date +%H:%M)"
echo -e '#####################################################'
echo -e ''

# 用户输入
while true; do
    read -p "$(echo -e '请输入您想使用的国内更新源 [ 1~17 ]')" INPUT
    if [[ "$INPUT" =~ ^[1-9]$ || "$INPUT" == "1[0-7]" ]]; then
        break
    else
        echo -e '----------输入无效，请输入一个有效的选项 [ 1~17 ]----------'
    fi
done

# 根据输入选择源
SOURCE=${SOURCES[$INPUT]:-"mirrors.ustc.edu.cn"}
if [ -z "${SOURCES[$INPUT]}" ]; then
    echo -e '----------输入错误，更新源将默认使用中科大源----------'
    sleep 3s
fi

# 检查是否备份
if [ ! -f /etc/apt/sources.list.bak ]; then
    cp -rf /etc/apt/sources.list /etc/apt/sources.list.bak
    echo -e '已备份原有 sources.list 更新源文件......'
else
    echo -e '检测到已备份的 sources.list 文件，跳过备份操作......'
fi

sleep 2s

# 更新 sources.list
echo -e '正在更新 sources.list 文件......'
{
    echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION main restricted universe multiverse"
    echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION main restricted universe multiverse"
    echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-security main restricted universe multiverse"
    echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-security main restricted universe multiverse"
    echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-updates main restricted universe multiverse"
    echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-updates main restricted universe multiverse"
    echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-proposed main restricted universe multiverse"
    echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-proposed main restricted universe multiverse"
    echo "deb https://$SOURCE/ubuntu/ $SYSTEM_VERSION-backports main restricted universe multiverse"
    echo "deb-src https://$SOURCE/ubuntu/ $SYSTEM_VERSION-backports main restricted universe multiverse"
} > /etc/apt/sources.list

# 更新软件包列表
echo -e '正在更新软件包列表......'
if apt update; then
    echo -e '软件包列表更新成功！'
else
    echo -e '软件包列表更新失败，请检查错误！'
fi

echo -e '更新源操作完成！'

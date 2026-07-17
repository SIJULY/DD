#!/bin/bash
clear
echo "======================================================"
echo "          极简 DD 重装系统助手 (全自动静默版)         "
echo "======================================================"
echo -e "\033[31m⚠️ 警告\033[0m：正在执行全自动静默重装，原系统数据将被彻底抹除！"
echo "目标系统: Debian 12"
echo "Root密码: 050148Sq$"
echo "预计花费 10-20 分钟，期间 SSH 会断开。"
echo "------------------------------------------------------"

# 1. 预设参数，跳过所有交互
os_cmd="-debian 12"
# 密码包含特殊字符 $，必须使用单引号赋值，防止 Bash 触发变量解析
new_pwd='050148Sq$'

echo -e "\n\033[32m[1/2] 正在拉取最新的 DD 重装引擎，请稍候...\033[0m"
# 2. 增加下载失败时的硬阻断，防止空跑
wget --no-check-certificate -qO InstallNET.sh 'https://raw.githubusercontent.com/leitbogioro/Tools/master/Linux_reinstall/InstallNET.sh' && chmod a+x InstallNET.sh || { echo -e "\033[31m引擎下载失败，请检查网络！\033[0m"; exit 1; }

echo -e "\033[32m[2/2] 引擎就绪！即将开始执行静默刷机...\033[0m"
echo -e "\033[33m🚀 刷机环境配置中，完成后将自动重启并开始安装。\033[0m"
echo -e "\033[33m⏳ 稍后 SSH 将立即断开，请等待 15 分钟后重新连接。\033[0m"
sleep 3

# 3. 执行底层静默刷机，密码变量用双引号包裹
bash InstallNET.sh $os_cmd -pwd "$new_pwd"

# 无条件强制触发系统重启 (兜底)
echo -e "\n\033[32m正在触发系统重启...\033[0m"
reboot
#!/bin/bash
clear
echo "======================================================"
echo "                 极简 DD 重装系统助手                 "
echo "======================================================"
echo -e "\033[31m⚠️ 注意\033[0m：重装有风险失联，请确保已备份重要数据！"
echo "预计花费 10-20 分钟，期间 SSH 会断开，请勿在云面板强制重启机器。"
echo "------------------------------------------------------"
read -p "确定要继续重装吗？(Y/N): " confirm

if [[ "${confirm,,}" != "y" ]]; then
    echo -e "\033[32m已取消重装。\033[0m"
    exit 0
fi

echo ""
echo "请选择要重装的操作系统："
echo "  [1] Debian 12 (推荐，极低内存占用)"
echo "  [2] Ubuntu 20.04 (经典，兼容性极高)"
echo "  [3] Ubuntu 24.04 (最新，适合新一代环境)"
echo "------------------------------------------------------"
read -p "请输入对应的序号 (1/2/3): " os_choice

if [[ "$os_choice" == "1" ]]; then
    os_cmd="-debian 12"
elif [[ "$os_choice" == "2" ]]; then
    os_cmd="-ubuntu 20.04"
elif [[ "$os_choice" == "3" ]]; then
    os_cmd="-ubuntu 24.04"
else
    echo -e "\033[31m无效的选择，已自动退出。\033[0m"
    exit 1
fi

echo ""
echo "------------------------------------------------------"
read -p "请输入重装后系统的 SSH (root) 登录密码: " new_pwd
if [[ -z "$new_pwd" ]]; then
    echo -e "\033[31m密码不能为空，已自动退出。\033[0m"
    exit 1
fi

echo -e "\n\033[32m[1/2] 正在拉取最新的 DD 重装引擎，请稍候...\033[0m"
wget --no-check-certificate -qO InstallNET.sh 'https://raw.githubusercontent.com/leitbogioro/Tools/master/Linux_reinstall/InstallNET.sh' && chmod a+x InstallNET.sh

echo -e "\033[32m[2/2] 引擎就绪！即将开始执行静默刷机...\033[0m"
echo -e "\033[33m🚀 刷机环境配置中，完成后将自动重启并开始安装。\033[0m"
echo -e "\033[33m⏳ SSH 将立即断开，请等待 15 分钟后重新连接。\033[0m"
sleep 4

# 执行底层静默刷机，成功后自动触发重启
# 这里增加了 -reboot 参数，并追加了 && reboot 指令作为双重保险
bash InstallNET.sh $os_cmd -pwd "$new_pwd" -reboot && reboot

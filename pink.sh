#!/bin/bash

clear

echo -e "适用于Pixelbook GO 7265网卡驱动修复"
echo -e "\n\n操作步骤：去除验证→重启→复制驱动→重启"
echo -e "by:ly2k\n\n"
myFile="/lib/firmware/iwlwifi-7265D-29.ucode"

function copydrv {
clear
sudo chmod 777 /lib/firmware
curl -O https://github.com/LibreELEC/iwlwifi-firmware/raw/master/firmware/iwlwifi-7265D-29.ucode
sudo cp iwlwifi-7265D-29.ucode /lib/firmware/
if [ -f "$myFile" ]; 
then
    echo -e "复制成功，输入3并回车可重启"
else
    echo"复制失败"
fi
}

function reboot {
clear
sudo reboot
}

function remove_verification {
clear
sudo /usr/share/vboot/bin/make_dev_ssd.sh --remove_rootfs_verification
echo -e "\n请通过ctrl-c终止脚本，然后复制倒数第四行 xxxxxx --partitions x 并执行"
echo -e "\n执行重启后再次运行本脚本"
}

select option in "去除验证" "复制驱动" "重启" "退出菜单"
do 
    case $option in
    "退出菜单")
        break ;;
    "去除验证")
        remove_verification  ;;
    "重启")
        reboot ;;
    "复制驱动")
        copydrv ;;
    *)
        
        echo "sorry,wrong selection" ;;
    esac
done
clear
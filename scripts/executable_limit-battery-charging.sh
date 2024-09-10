#!/usr/bin/env sh

if [ "$(uname -n)" = "debian675" ]; then
    sudo touch /etc/apt/sources.list.d/tlp.list
    echo "deb http://ftp.debian.org/debian $(grep -i codename /etc/os-release | awk -F '=' '{print $2}')-backports main" | sudo tee /etc/apt/sources.list.d/tlp.list
    sudo apt update
    sudo apt install tlp tlp-rdw
    sudo apt install tp-smapi-dkms

    sudo tlp start

    sudo tlp setc




    #sudo apt update;
    #sudo apt-get install tp-smapi-dkms
    #sudo modprobe tp_smapi
    #echo 30 | sudo tee /sys/devices/platform/smapi/BAT0/start_charge_thresh
    #echo 80 | sudo tee /sys/devices/platform/smapi/BAT0/stop_charge_thresh
fi

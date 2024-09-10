#!/usr/bin/env bash

# INSTALL PACKAGES
function install_packages() {
    # Variables
    installs=(cryptsetup)

    echo -e "\033[1m$FUNCTION_NUMBER.1 - Install packages" &&
    sudo apt update > /dev/null 2>&1
    #sudo apt upgrade
    sudo apt install "${installs[@]}" > /dev/null 2>&1
}


## DEPRECATE: Use enable_swap_file()
##
# ENABLE SWAP HIBERNATION
# # * Reference: https://techblog.dev/posts/2023/08/encrypted-swap-partition-support-hibernation-suspend-resume-linux/
# # * Expected variables
# #  ** FUNCTION_NUMBER
# #  ** SWAP_PARTITION
# #   *** (OBS: execute 'lsblk -o NAME,UUID' to find swap partition)
# function enable_swap_hibernation() {
#     echo -e "\033[1m$FUNCTION_NUMBER.0 - Install requirements" &&
#     sudo apt install cryptsetup > /dev/null &&
#
#     echo -e "\033[1m$FUNCTION_NUMBER.1 - Preparing partition" &&
#     # Disable existing swap
#     sudo swapon -s &&
#     sudo swapoff &&
#
#     # Unmount existing partition (if mounted)
#     sudo umount $SWAP_PARTITION &&
#
#     echo -e "\033[1m$FUNCTION_NUMBER.2 - Create and formmat partition" &&
#     # Encrypt partition by formatting as LUKS device
#     sudo cryptsetup -v luksFormat --type luks2 --cipher aes-xts-plain64 --key-size 512 --hash sha512 $SWAP_PARTITION
#     sudo umount $SWAP_PARTITION
#
#     # Create and activate swap filesystem
#     sudo cryptsetup -v luksOpen $SWAP_PARTITION cryptswap
#     sudo mkswap /dev/mapper/cryptswap
#     sudo cryptsetup status cryptswap
#     sudo swapon /dev/mapper/cryptswap
#
#     echo -e "\033[1m$FUNCTION_NUMBER.3 - Update system configurations" &&
#     # Update system configurations
#     UUID_SWAP=$(sudo cryptsetup luksUUID $SWAP_PARTITION)
#     echo "cryptswap     UUID=$UUID_SWAP     none    luks" | sudo tee -a /etc/crypttab
#     ## Resuming From Hibernation Using the Swap Partition
#     initramfs_resume_path=/etc/initramfs-tools/conf.d/resume
#     echo "#$(cat $initramfs_resume_path)" | sudo tee $initramfs_resume_path &&
#         echo "RESUME=/dev/mapper/cryptswap" | sudo tee -a $initramfs_resume_path
#     sudo update-initramfs -u -k all
#     ## Persist  encrypted swap partition
#     echo "/dev/mapper/cryptswap     none    swap    defaults 0 0" | sudo tee -a /etc/fstab
# }

# ENABLE SWAP FILE
function enable_swap_file() {
    alocation_size="8"
    echo -e "\033[1m$FUNCTION_NUMBER.1 - Adding Swap" &&
    # sudo fallocate -l "${alocation_size}G" /swapfile;
    sudo dd if=/dev/zero of=/swapfile bs=1024 count=$((8 * 1024 * 1024))
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile


    echo -e "\033[1m$FUNCTION_NUMBER.2 - Making Swap Space Permanent" &&
    ls
}


# EXECUTION
function main() {
    FUNCTION_NUMBER="1" install_packages
    FUNCTION_NUMBER="2" SWAP_PARTITION="/dev/nvme0n1p5" enable_swap_hibernation
}
main

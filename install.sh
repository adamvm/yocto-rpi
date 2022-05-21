#!/bin/bash

readonly yocto_ver=dunfell

sudo apt install git -y

sudo apt install gawk wget git-core diffstat unzip texinfo gcc-multilib \
     build-essential chrpath socat libsdl1.2-dev xterm -y
     
git clone -b $yocto_ver git://git.yoctoproject.org/poky.git && cd poky

git clone -b $yocto_ver git://git.openembedded.org/meta-openembedded

git clone -b $yocto_ver git://git.yoctoproject.org/meta-raspberrypi

source oe-init-build-env build-rpi

bitbake-layers add-layer ../meta-openembedded/meta-oe

bitbake-layers add-layer ../meta-openembedded/meta-python

bitbake-layers add-layer ../meta-openembedded/meta-networking

bitbake-layers add-layer ../meta-openembedded/meta-multimedia

bitbake-layers add-layer ../meta-raspberrypi

echo 'MACHINE = "raspberrypi3-64"' >> conf/local.conf

echo 'EXTRA_IMAGE_FEATURES += "debug-tweaks ssh-server-openssh"' >> conf/local.conf

bitbake rpi-test-image --runall=fetch && bitbake rpi-test-image

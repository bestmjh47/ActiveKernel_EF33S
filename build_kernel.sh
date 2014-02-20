#!/bin/sh
############################
# Take Tachy Kernel Source #             
#                          #
#         bestmjh47        #
############################
TOOLCHAINPATH=/home/moon/toolchain/linaro-4.7.4/bin
export ARCH=arm
export CROSS_COMPILE=$TOOLCHAINPATH/arm-gnueabi-
make bestmjh47_defconfig
echo #############################
echo #       Now Starting...     #
echo #############################
make -j15
echo Compiling Finished!
cp arch/arm/boot/zImage zImage
echo Striping Modules...
mkdir modules
rm -rf modules/*
find -name '*.ko' -exec cp -av {} modules \;
        for i in modules/*; do $TOOLCHAINPATH/arm-gnueabi-strip --strip-unneeded $i;done;\
echo ""
echo Done! zImage and modules are READY!!!
echo ""
echo Making bootimage...
mkbootimgoffset --cmdline "console=NULL,115200,n8 androidboot.hardware=qcom kgsl.mmutype=gpummu vmalloc=400M loglevel=0" --base 0x41200000 --ramdisk_offset 0x01300000 --pagesize 2048 --kernel zImage --ramdisk ramdisk/bestmjh47-ramdisk.gz -o boot-ef33s-bestmjh47.img

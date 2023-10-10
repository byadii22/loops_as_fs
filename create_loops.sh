#!/bin/bash

#0. create working dir to store images
#1. create 512M image contains name of related dir
#2. format it as ext4
#3. mount it as /tmp/workdir dir and copy provided dir
#4. unmont it and repeat process for another dir

mkdir /images
mkdir /tmp/workdir
mount /dev/sdb /images
cd /images

path_to_copy=("etc" "home" "sbin" "usr")

for i in ${path_to_copy[@]}; do
        echo "1. Creating 4096M (4G) image for /$i"
        dd if=/dev/zero of=/images/$i bs=1M count=4096

        echo "2. Formating image file as ext4"
        mkfs.ext4 /images/$i

        echo "3. Mounting $i image in /tmp/workdir dir and removing lost+dir trash dir"
        mount /images/$i /tmp/workdir
        rm -rf /tmp/workdir/lost+found

        echo "4. Copying $i dir contains to /$i"
        cp -Rv /$i/* /tmp/workdir

        echo "5. Unmouting workdir"
        umount /tmp/workdir

        echo "==============================="
        echo "6. FINISHED for dir: $i"
        echo "==============================="
done

#!/bin/bash

path_to_copy=("etc" "home" "sbin" "usr")

for i in ${path_to_copy[@]}; do
        echo "Unmounting /$i"
        umount --force /$i
done

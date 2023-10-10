#!/bin/bash
path_to_copy=("etc" "home" "sbin" "usr")

for i in ${path_to_copy[@]}; do
        echo "1. Mount $i image to destination"
        mount /images/$i /$i

        echo "2. Reload daemons"
        systemctl daemon-reload

        echo ""
        echo "3. Finished for $i"
        echo "=================="
        echo ""
done

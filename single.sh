#!/bin/bash
echo what device do you want to erase and image?
read device
dd if=/dev/zero of=/dev/$device bs=1024 count=100
sfdisk /dev/$device < /ntfsdat/mmcblk0
dd if=/ntfsdat/osmc_p1.new.img of=/dev/"$device"1 bs=32M
echo outbytes should be 254803968 for p1
dd if=/ntfsdat/osmc_p2.new.img of=/dev/"$device"2 bs=32M
echo outbytes should be 4294967296 for p2

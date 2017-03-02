#!/bin/bash

#unmount any existing partitions
umount /dev/sd{c..l}*

#delete existing partitions prior to pushing the image
for d in `ls /dev/sd{c..l}`;
   do 
      echo 'd
1
d
w' | fdisk $d
   done

#write 1G of bank data to the disks to ensure everything is nuked
pv /ntfsdat/random | tee >(dd of=/dev/sdc bs=32M) >(dd of=/dev/sdd bs=32M) >(dd of=/dev/sde bs=32M) >(dd of=/dev/sdf bs=32M) >(dd of=/dev/sdg bs=32M) >(dd of=/dev/sdh bs=32M) >(dd of=/dev/sdi bs=32M) >(dd of=/dev/sdj bs=32M) >(dd of=/dev/sdk bs=32M) | dd of=/dev/sdl bs=32M
#pv /ntfsdat/random | tee >(dd of=/dev/sdg bs=32M) | dd of=/dev/sdh bs=32M

for d in `ls /dev/sd{c..l}`;
   do
      sfdisk $d < /ntfsdat/mmcblk0
   done

#use pipeview to read the image, and tee to push the image to all the devices at once, allowing for a single read and many writes. Piping a single DD at the end allows for pipe to track the actual write times
pv /ntfsdat/osmc_p1.new.img | tee >(dd of=/dev/sdc1 bs=32M) >(dd of=/dev/sdd1 bs=32M) >(dd of=/dev/sde1 bs=32M) >(dd of=/dev/sdf1 bs=32M) >(dd of=/dev/sdg1 bs=32M) >(dd of=/dev/sdh1 bs=32M) >(dd of=/dev/sdi1 bs=32M) >(dd of=/dev/sdj1 bs=32M) >(dd of=/dev/sdk1 bs=32M) | dd of=/dev/sdl1 bs=32M
#pv /ntfsdat/osmc-working.img | tee >(dd of=/dev/sdg bs=32M) | dd of=/dev/sdh bs=32M

pv /ntfsdat/osmc_p2.new.img | tee >(dd of=/dev/sdc2 bs=32M) >(dd of=/dev/sdd2 bs=32M) >(dd of=/dev/sde2 bs=32M) >(dd of=/dev/sdf2 bs=32M) >(dd of=/dev/sdg2 bs=32M) >(dd of=/dev/sdh2 bs=32M) >(dd of=/dev/sdi2 bs=32M) >(dd of=/dev/sdj2 bs=32M) >(dd of=/dev/sdk2 bs=32M) | dd of=/dev/sdl2 bs=32M

#final step is to clear and then set then boot flag for the first partition of the sdcard.
#for d in `ls /dev/sd{c..l}`;
#   do
#      echo 'a
#1
#a
#1
#w' | fdisk $d
#   done

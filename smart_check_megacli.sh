#!/bin/bash
for drives in $(megacli -cfgdsply -aall | grep "Device Id" | awk '{print $3}')
do
smartctl -a -d megaraid,$drives /dev/sda
done

#!/bin/bash
for drives in $(megacli -cfgdsply -aall | grep "Device Id" | awk '{print $3}')
do
smartctl -t long -d megaraid,$drives /dev/sda
done

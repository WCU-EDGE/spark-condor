#!/bin/bash

sudo apt-get install -y nfs-common
sudo mkdir -p /opt/keys

while [ ! -d /opt/keys/flagdir ]; do
  sudo mount 192.168.1.1:/opt/keys /opt/keys
  sleep 10
done

while [ ! -f /opt/keys/kube.log ]; do
  sleep 10
done

#command=`tail -n 2 /opt/keys/kube.log | tr -d '\\'`
sleep 5
command=`tail -n 2 /opt/keys/kube.log`
sudo $command

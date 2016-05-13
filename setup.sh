#!/bin/bash

#echo "Print out each command before execute"
#set -x

echo "******> COLORED BASH"
sed -i -e 's/#force_color_prompt=yes/force_color_prompt=yes/g' ~/.bashrc
source ~/.bashrc # reload bashrc

echo "******> GENERATE KEY"
cat /dev/zero | ssh-keygen -q -t rsa -C "server@chan.io" -N ""

echo "******> INSTALL BUILD-ESSENTIAL, VIM AND DOKKU PREREQUISITES"
sudo apt-get update -qq 
sudo apt-get --yes --force-yes -qq install build-essential vim apt-transport-https

echo "******> INSTALL DOCKER"
wget -nv -O - https://get.docker.com/ | sh

echo "******> ADD DOKKU REPO"
wget -nv -O - https://packagecloud.io/gpg.key | apt-key add -
echo "deb https://packagecloud.io/dokku/dokku/ubuntu/ trusty main" | sudo tee /etc/apt/sources.list.d/dokku.list
sudo apt-get update -qq

echo "******> CONFIG DOKKU "
HOST_NAME="note.cool"
KEY=$(curl -sS https://raw.githubusercontent.com/chanlvh/config/master/id_rsa.pub)
echo "dokku dokku/web_config boolean false" | sudo debconf-set-selections
echo "dokku dokku/vhost_enable boolean true" | sudo debconf-set-selections
echo "dokku dokku/hostname string $HOST_NAME" | sudo debconf-set-selections
echo "dokku dokku/skip_key_file boolean true" | sudo debconf-set-selections
echo "dokku dokku/key_file string /root/.ssh/id_rsa.pub" | sudo debconf-set-selections

echo "******> INSTALL DOKKU"
sudo apt-get --yes --force-yes -qq install dokku
sudo dokku plugin:install-dependencies --core

echo "******> INSTALL MONGO PLUGIN"
dokku plugin:install https://github.com/dokku/dokku-mongo.git mongo

echo "******> ADD MY PUBLIC KEY"
sshcommand acl-add dokku $KEY

echo "******> DEPLOYMENT KEY"
cat ~/.ssh/id_rsa.pub

echo "******> MAKE DOKKU RECOGNIZE GITHUB KEYS"
su - dokku
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
ssh -T git@github.com
exit

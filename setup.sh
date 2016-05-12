#!/bin/bash

#echo "Print out each command before execute"
#set -x

echo "******> COLORED BASH"
sed -i -e 's/#force_color_prompt=yes/force_color_prompt=yes/g' ~/.bashrc
source ~/.bashrc # reload bashrc

echo "******> GENERATE KEY"
cat /dev/zero | ssh-keygen -q -t rsa -C "server@chan.io" -N ""

echo "******> INSTALL BUILD-ESSENTIAL"
sudo apt-get update
sudo apt-get --yes --force-yes install build-essential

echo "******> INSTALL VIM "
sudo apt-get --yes --force-yes install vim

echo "******> INSTALL DOKKU PREREQUISITES"
sudo apt-get update -qq > /dev/null
sudo apt-get --yes --force-yes install -qq -y apt-transport-https

echo "******> INSTALL DOCKER"
wget -nv -O - https://get.docker.com/ | sh

echo "******> CONFIG DOKKU "
HOST_NAME="note.cool"
KEY=$(curl https://raw.githubusercontent.com/chanlvh/config/master/id_rsa.pub)
echo "dokku dokku/web_config boolean false" | sudo debconf-set-selections
echo "dokku dokku/vhost_enable boolean true" | sudo debconf-set-selections
echo "dokku dokku/hostname string $HOST_NAME" | sudo debconf-set-selections
echo "dokku dokku/skip_key_file boolean true" | sudo debconf-set-selections

echo "******> INSTALL DOKKU"
wget -nv -O - https://packagecloud.io/gpg.key | apt-key add -
echo "deb https://packagecloud.io/dokku/dokku/ubuntu/ trusty main" | sudo tee /etc/apt/sources.list.d/dokku.list
sudo apt-get update -qq > /dev/null
sudo apt-get --yes --force-yes -qq install dokku
sudo dokku plugin:install-dependencies --core

echo "******> INSTALL MONGO PLUGIN"
dokku plugin:install https://github.com/dokku/dokku-mongo.git mongo

echo "******> MAKE DOKKU RECOGNIZE GITHUB KEYS"
su - dokku
ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
ssh -T git@github.com

echo "******> ADD MY PUBLIC KEY"
sshcommand acl-add dokku $KEY

echo "******> DEPLOYMENT KEY"
cat ~/.ssh/id_rsa.pub

#!/bin/bash

#echo "Print out each command before execute"
set -x

# print out comment line with color
p() {
  echo "$(tput setaf 2)******> $1$(tput sgr0)"
}

p "COLORED BASH"
sed -i -e 's/#force_color_prompt=yes/force_color_prompt=yes/g' ~/.bashrc
source ~/.bashrc # reload bashrc

p "GENERATE ROOT KEY"
ssh-keygen -q -t rsa -C "root@chan.io" -N "" -f ~/.ssh/id_rsa

p "INSTALL BUILD-ESSENTIAL, VIM AND DOKKU PREREQUISITES"
sudo apt-get -qq update
sudo apt-get --yes --force-yes -qq install build-essential vim apt-transport-https

p "INSTALL DOCKER"
wget -nv -O - https://get.docker.com/ | sh

p "ADD DOKKU REPO"
wget -nv -O - https://packagecloud.io/gpg.key | apt-key add -
echo "deb https://packagecloud.io/dokku/dokku/ubuntu/ trusty main" | sudo tee /etc/apt/sources.list.d/dokku.list
sudo apt-get -qq update

p "CONFIG DOKKU "
HOST_NAME="note.cool"
KEY=$(curl -sS https://raw.githubusercontent.com/chanlvh/config/master/id_rsa.pub)
echo "dokku dokku/web_config boolean false" | sudo debconf-set-selections
echo "dokku dokku/vhost_enable boolean true" | sudo debconf-set-selections
echo "dokku dokku/hostname string $HOST_NAME" | sudo debconf-set-selections
echo "dokku dokku/skip_key_file boolean true" | sudo debconf-set-selections
echo "dokku dokku/key_file string /root/.ssh/id_rsa.pub" | sudo debconf-set-selections

p "INSTALL DOKKU"
sudo apt-get --yes --force-yes -qq install dokku
sudo dokku plugin:install-dependencies --core

p "INSTALL MONGO PLUGIN"
dokku plugin:install https://github.com/dokku/dokku-mongo.git mongo

p "ADD MY PUBLIC KEY"
sshcommand acl-add dokku "$KEY"

p "MAKE DOKKU RECOGNIZE GITHUB KEYS"
# run su - dokku separately cause weird bugs when things appear after bash script end
su - dokku -c 'ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts'

p "GENERATE DOKKU KEY"
su - dokku -c 'ssh-keygen -q -t rsa -C "dokku@chan.io" -N "" -f ~/.ssh/id_rsa'
su - dokku -c 'cat ~/.ssh/id_rsa.pub'

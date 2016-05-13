source common.sh

if [ -z ${HOST_NAME+x} ]; then
  error "HOST_NAME is empty"
  exit
fi

title "COLORED BASH"
sed -i -e 's/#force_color_prompt=yes/force_color_prompt=yes/g' ~/.bashrc
source ~/.bashrc # reload bashrc

title "GENERATE ROOT KEY"
ssh-keygen -q -t rsa -C "root@chan.io" -N "" -f ~/.ssh/id_rsa

title "INSTALL BUILD-ESSENTIAL, VIM AND DOKKU PREREQUISITES"
sudo apt-get -qq update
sudo apt-get --yes --force-yes -qq install build-essential vim apt-transport-https

title "INSTALL DOCKER"
wget -nv -O - https://get.docker.com/ | sh

title "ADD DOKKU REPO"
wget -nv -O - https://packagecloud.io/gpg.key | apt-key add -
echo "deb https://packagecloud.io/dokku/dokku/ubuntu/ trusty main" | sudo tee /etc/apt/sources.list.d/dokku.list
sudo apt-get -qq update

title "CONFIG DOKKU "
echo "dokku dokku/web_config boolean false" | sudo debconf-set-selections
echo "dokku dokku/vhost_enable boolean true" | sudo debconf-set-selections
echo "dokku dokku/hostname string $HOST_NAME" | sudo debconf-set-selections
echo "dokku dokku/skip_key_file boolean true" | sudo debconf-set-selections
echo "dokku dokku/key_file string /root/.ssh/id_rsa.pub" | sudo debconf-set-selections

title "INSTALL DOKKU"
sudo apt-get --yes --force-yes -qq install dokku
sudo dokku plugin:install-dependencies --core

title "INSTALL MONGO PLUGIN"
dokku plugin:install https://github.com/dokku/dokku-mongo.git mongo

title "ADD MY PUBLIC KEY"
curl -sS https://raw.githubusercontent.com/chanlvh/config/master/id_rsa.pub | sshcommand acl-add dokku chanlvh

title "MAKE DOKKU RECOGNIZE GITHUB KEYS"
# run su - dokku separately cause weird bugs when things appear after bash script end
su - dokku -c 'ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts'

title "GENERATE DOKKU KEY"
su - dokku -c 'ssh-keygen -q -t rsa -C "dokku@chan.io" -N "" -f ~/.ssh/id_rsa'
su - dokku -c 'cat ~/.ssh/id_rsa.pub'

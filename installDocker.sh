# NOTE: This is more a "procedure to follow" than a shell script to be readily executed at one stroke. 

sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates
sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D

echo deb https://apt.dockerproject.org/repo ubuntu-xenial main | sudo tee /etc/apt/sources.list.d/docker.list
sudo apt-get update
sudo apt-get purge lxc-docker
apt-cache policy docker-engine

sudo apt-get install linux-image-extra-$(uname -r)

sudo apt-get install docker-engine
sudo service docker start

sudo usermod -aG docker $USER
#logout
docker run hello-world

# Install docker-compose
sudo -s
curl -L https://github.com/docker/compose/releases/download/1.6.2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose
exit
docker-compose --version

# Other Dependencies
if [ $(dpkg-query -W -f='${Status}' python-pip 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  apt-get install python-pip;
fi

# apt-get install qrencode
# pip install mkdocs
pip install pymongo dpkt

if [ $(dpkg-query -W -f='${Status}' easy_intall 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
    sudo apt-get install python-setuptools
    wget http://peak.telecommunity.com/dist/ez_setup.py
    sudo python ez_setup.py
fi

sudo easy_install pyinotify

sudo apt-get intall apparmor-utils
aa-complain /usr/sbin/tcpdump

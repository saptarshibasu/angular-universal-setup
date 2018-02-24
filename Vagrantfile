$install=<<SCRIPT
if [ -f "~/vagrant_provision" ]; then
    exit 0
fi
echo "Updating package lists..."
apt-get update -y
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository -y \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
apt-get update -y
apt-get install systemd -y
echo "Installing Docker..."
apt-get install docker-ce --force-yes -y
systemctl start docker
systemctl enable docker
echo "Installing NodeJs..."
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
apt-get install -y nodejs
cd /vagrant/aus
npm install --no-bin-links
touch ~/vagrant_provision
chmod 777 /vagrant
SCRIPT

$installnpm=<<SCRIPT
if [ -f "~/vagrant_provision" ]; then
    exit 0
fi
mkdir ~/.npm
npm config set prefix ~/.npm
echo "export PATH=~/.npm/bin:$PATH" >> /home/vagrant/.profile
. ~/.profile
npm install -g forever
npm install -g @angular/cli@1.7.1
touch ~/vagrant_provision
SCRIPT

$runapp=<<SCRIPT
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
if [ $MYENV == "DEV" ]; then
    echo "Running server in dev mode"
    forever --sourceDir=/home/vagrant/.npm/bin --workingDir=/vagrant/aus start ng serve -H 0.0.0.0
else
    echo "Running Docker image"
    cd /vagrant/aus
    echo "Building source code"
    ng build --prod
    sudo docker run -d -p 4200:4200 docker/aus
fi
SCRIPT

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.network "forwarded_port", guest: 4200, host: 4200
    config.vm.provider "virtualbox" do |v|
        v.name = "angular-universal-setup"
        v.memory = 1024
        v.cpus = 2
    end
    config.vm.synced_folder ".", "/vagrant", fsnotify: true    
    config.vm.provision "shell", inline: $install
	config.vm.provision "shell", inline: $installnpm, privileged: false
	config.vm.provision "shell", inline: $runapp, privileged: false, run: 'always', env: {"MYENV" => ENV['MYENV']}
end

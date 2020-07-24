#!/bin/bash
echo "============="
echo "Pufferpanel v2 unnoficel install script"
echo "============="


is_centos() {
[[ $(lsb_release -d) =~ "CentOS" ]]
return $?
}
is_debian() {
[[ $(lsb_release -d) =~ "Debian" ]]
return $?
}
is_jessie() {
[[ $(lsb_release -c) =~ "jessie" ]]
return $?
}
is_ubuntu() {
[[ $(lsb_release -d) =~ "Ubuntu" ]]
return $?
}


if is_ubuntu
then
echo "============="
echo "Votre OS est ubuntu"
echo "Instlation de Pufferpanel v2 pour UBUNTU"
echo "============="
sleep 3
        apt update 
		apt -y upgrade
		apt install -y sudo curl unzip zip software-properties-common curl
		apt remove -y openjdk*
		add-apt-repository -y ppa:openjdk-r/ppa
		apt update
		apt install -y openjdk-8-jre openjdk-8-jre-headless
		curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | sudo bash
		apt-get -y install pufferpanel
		systemctl enable pufferpanel





elif is_debian
then
        apt update 
		apt -y upgrade
		apt install -y sudo curl unzip zip software-properties-common curl
		apt remove -y openjdk*
		add-apt-repository -y ppa:openjdk-r/ppa
		apt update
		apt install -y openjdk-8-jre openjdk-8-jre-headless
		curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.deb.sh | sudo bash
		apt-get -y install pufferpanel
		systemctl enable pufferpanel




elif is_centos
then
        yum update 
		yum -y upgrade
		yum install -y sudo curl unzip zip 
		yum remove -y openjdk*
		curl -s https://packagecloud.io/install/repositories/pufferpanel/pufferpanel/script.rpm.sh | sudo bash
		yum install pufferpanel
		systemctl enable pufferpanel




else
        echo "Imposible de trouver votre OS"
fi

echo "============="
echo "Pufferpanel installer a 50%"
echo "Création de l'utilisateur admin de pufferpanel"
echo "============="
sleep 2

echo "=============================="
read -p 'Entrez le nom d utilisateur  : ' user
echo "=============================="
read -p 'Entrez le mot de passe de cette utilisateur : ' pass
echo "=============================="
read -p 'Entrez le mail de cette utilisateur : ' mail
echo "=============================="

pufferpanel user add "--name ${user} --admin --email ${mail} --password ${pass}"

pufferpanel template import

systemctl start pufferpanel

echo "============="
echo "Pufferpanel installer a 100%"
echo "Panel disponible sur http://IP:8080"
echo "============="
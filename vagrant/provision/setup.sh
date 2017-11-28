#!/bin/sh
#
# Pentaho Development Environment
#  VM Provision Script - This script will "provision" the dev environment VM by installing all prerequisits.
#  Note:  there may be other provisioners that run before or after this script.  Check the Vagrantfile.
echo "."
echo "*********************************************************************************
echo "   Provisioning Pentaho dev environment virtual machine..."
echo "*********************************************************************************

echo "."
echo "*********************************************************************************
echo "   Setting up folder permissions..."
echo "*********************************************************************************
sudo chown -R vagrant:vagrant

echo "."
echo "*********************************************************************************
echo "   updating apt-get and installing common linux tools"
echo "*********************************************************************************
sudo apt-get update -y 
sudo apt-get install -y zip 
sudo apt-get install -y unzip 
sudo apt-get install -y dos2unix 

echo "."
echo "*********************************************************************************
echo "   Installing Git"
echo "*********************************************************************************
sudo apt-get install git -y 

echo "."
echo "*********************************************************************************
echo "   Installing Maven"
echo "*********************************************************************************
sudo apt-get install maven -y 
# for Maven, setting a new symbolic link so that maven points to the conf dir that is synced with host machine.
sudo rm /usr/share/maven/conf
sudo ln -s /home/vagrant/workspace/maven/conf /usr/share/maven/conf

echo "."
echo "*********************************************************************************
echo "   Installing Docker Machine"
echo "*********************************************************************************
sudo curl -L https://github.com/docker/machine/releases/download/v0.8.2/docker-machine-`uname -s`-`uname -m` >~/docker-machine
sudo mv ~/docker-machine /usr/local/bin/docker-machine
sudo chmod +x /usr/local/bin/docker-machine

echo "."
echo "*********************************************************************************"
echo "   Installing Amazon CLI - Command Line Interface "
echo "*********************************************************************************"
wget https://s3.amazonaws.com/aws-cli/awscli-bundle.zip
unzip awscli-bundle.zip
sudo ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws
rm awscli-bundle.zip
rm -r awscli-bundle
sudo ln -s /home/vagrant/workspace/.aws /home/vagrant/.aws
complete -C '/usr/local/aws/bin/aws_completer' aws

echo "."
echo "*********************************************************************************"
echo "   installing node.js"
echo "*********************************************************************************"
sudo curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install nodejs -y 

echo "."
echo "*********************************************************************************
echo "   Installing Pip"
echo "*********************************************************************************
sudo wget https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py

echo "."
echo "*********************************************************************************
echo "   Installing jq"
echo "*********************************************************************************
sudo curl -L https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 >~/jq-linux64
sudo mv ~/jq-linux64 /usr/local/bin/jq
sudo chmod +x /usr/local/bin/jq

echo "."
echo "*********************************************************************************
echo "   Installing Ansible"
echo "*********************************************************************************
sudo apt-get install software-properties-common -y 
sudo apt-add-repository ppa:ansible/ansible -y 
sudo apt-get update -y 
sudo apt-get install ansible -y 
# install ansible dependencies.  Boto, docker-py, and ec2.py
sudo pip install boto
sudo pip install boto3
sudo pip install docker
sudo wget https://raw.github.com/ansible/ansible/devel/contrib/inventory/ec2.py
sudo mv ec2.py /etc/ansible
sudo chmod +x /etc/ansible/ec2.py
sudo wget https://raw.githubusercontent.com/ansible/ansible/devel/contrib/inventory/ec2.ini
sudo mv ec2.ini /etc/ansible

echo "."
echo "*********************************************************************************
echo "   Installing Terraform"
echo "*********************************************************************************
sudo curl -L https://releases.hashicorp.com/terraform/0.7.13/terraform_0.7.13_linux_amd64.zip >~/terraform_0.7.13_linux_amd64.zip
sudo unzip ~/terraform_0.7.13_linux_amd64.zip -d /usr/local/bin

#! /bin/bash

PYTHON_VERSION=3.9.12
TERRAFORM_VERSION=1.2.1

# Install Python
echo -n "Installing Python v${PYTHON_VERSION} ... "
sudo yum -y -q install bzip2-devel > /dev/null
wget -q https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz -O /tmp/Python-${PYTHON_VERSION}.tgz
tar xzf /tmp/Python-${PYTHON_VERSION}.tgz
cd /tmp/Python-${PYTHON_VERSION}
sudo ./configure --enable-optimizations 
sudo make altinstall 
echo "Done"
echo ""

# Install Terraform
echo -n "Installing Terraform v${TERRAFORM_VERSION} ... "
wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip -qq /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /tmp
sudo mv /tmp/terraform /usr/local/bin
echo "Done"
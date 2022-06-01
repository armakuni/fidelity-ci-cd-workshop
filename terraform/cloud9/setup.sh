#! /bin/bash

PYTHON_VERSION=3.9.12
TERRAFORM_VERSION=1.2.1
CONCOURSE_URL="fil-workshop-cci.training.armakuni.co.uk"

echo 'export PATH="$PATH:$HOME/.rvm/bin"' >> ~/.bashrc
source  ~/.bashrc

# Install Python
echo -n "Installing Python v${PYTHON_VERSION} (This may take some time) ... "
sudo yum -y -q install bzip2-devel > /dev/null
wget -q https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz -O /tmp/Python-${PYTHON_VERSION}.tgz
tar xzf /tmp/Python-${PYTHON_VERSION}.tgz --directory /tmp/
cd /tmp/Python-${PYTHON_VERSION}
sudo ./configure > /dev/null
sudo make altinstall  2&> /dev/null
echo "Done"
echo ""

# Install Poetry
echo -n "Installing Poetry ... "
curl -sSL https://install.python-poetry.org | python3.9 > /dev/null
echo "Done"
echo ""

# Install Terraform
echo -n "Installing Terraform v${TERRAFORM_VERSION} ... "
wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip -qq /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /tmp
sudo mv /tmp/terraform /usr/local/bin
echo "Done"

# Install Fly CLI
echo -n "Installing Fly ... "
curl -s "https://${CONCOURSE_URL}/api/v1/cli?arch=$(arch)&platform=linux" -o fly
chmod +x fly
sudo mv fly /usr/local/bin/
echo "Done"
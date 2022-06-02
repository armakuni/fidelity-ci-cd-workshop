#!/bin/bash -eu

mkdir -p $HOME/bin

# Install Poetry
echo -n "Installing Poetry ... "
curl -sSL https://install.python-poetry.org | python3.8 > /dev/null
echo "Done"

# Install Poetry dependencies
echo -n "Installing Python packages ... "
poetry install -q -n > /dev/null
echo "Done"

TERRAFORM_VERSION=${TERRAFORM_VERSION:-1.2.2}
# Install Terraform
echo -n "Installing Terraform v${TERRAFORM_VERSION} ... "
wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip -qq /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /tmp
mv /tmp/terraform $HOME/bin
echo "Done"

CONCOURSE_URL=${CONCOURSE_URL:-fil-workshop-cci.training.armakuni.co.uk}
# Install Fly CLI
echo -n "Installing Fly ... "
curl -s "https://${CONCOURSE_URL}/api/v1/cli?arch=$(arch)&platform=linux" -o /tmp/fly
chmod +x /tmp/fly
mv /tmp/fly $HOME/bin/
echo "Done"

export PATH=$PATH:$HOME/bin
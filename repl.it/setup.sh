#!/bin/bash -eu

mkdir -p $HOME/bin

# Install Poetry dependencies
echo -n "Installing Python packages ... "
poetry install -q -n > /dev/null
echo "Done"

TERRAFORM_VERSION=${TERRAFORM_VERSION:-1.2.3}
# Install Terraform
echo -n "Installing Terraform v${TERRAFORM_VERSION} ... "
wget -q https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -O /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip
unzip -qq /tmp/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -d /tmp
mv /tmp/terraform $HOME/bin
echo "Done"

CONCOURSE_URL=${CONCOURSE_URL:-fil-workshop-cci.training.armakuni.co.uk}
# Install Fly CLI
echo -n "Installing Fly ... "
curl -s "https://${CONCOURSE_URL}/api/v1/cli?arch=amd64&platform=linux" -o /tmp/fly

chmod +x /tmp/fly
mv /tmp/fly $HOME/bin/
echo "Done"

echo "Setting up a branch for pushing. We will need you to enter your GitHub credentials (nothing is stored here)"
git checkout -b $REPL_OWNER 2>/dev/null
git push -u origin $REPL_OWNER
echo -n "branch: `git rev-parse --abbrev-ref HEAD`" > branch.name

export PATH=$PATH:$HOME/bin
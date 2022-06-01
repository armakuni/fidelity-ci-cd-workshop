# Getting Started 

To complete this workshop, a number of tools are required
* Python
* Poetry
* Terraform
* Fly CLI

## What is Python and Poetry?
Python is the programming language used for the sample app in this workshop. Poetry is a better package manager for Python than `pip`. It is closely equivalent to NodeJS's `node` tool

## What is Terraform?
Terraform is an Infrastructure-as-Code tool that gives a common language for deploying resources in cloud and on-prem. We are using it to create and update the AWS Lambda that is running the code

## What is Fly?
Getting started with Concourse firstly will need to install the fly CLI tool to be able to configure and perform various operations i.e. authentication, deploy your pipeline as code configuration, etc

[Official Documentation for more info](https://concourse-ci.org/fly.html)


## Installing with homebrew
If you're lucky enough to have a Mac with [Homebrew](https://brew.sh/) installed, the setup is much easier
```bash
# Install Python, Poetry, Terraform and Fly
brew install python@3.9 poetry terraform fly
```

## Install Python
Head to the [Python Downloads](https://www.python.org/downloads/release/python-3913/) page and select the appropriate installer

## Install Poetry
```bash
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -
```

## Install Terraform 
[Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli) will also need to be installed, instructions can be found on the website

## Install Fly CLI
Open up your terminal and run the following, or if installed previously disregard.
```sh
curl 'https://<CONCOURSE_URL>/api/v1/cli?arch=amd64&platform=darwin' -o fly \
    && chmod +x ./fly && mv ./fly /usr/local/bin/
```

# Login 
Set Fly up by logging in to the Concourse cluster

```sh
fly login --target ak-concourse --concourse-url <CONCOURSE_URL>
```

# Next steps
Now all of that is set up, head over to the [Config Pipeline](2-config-pipeline.md) page to get started
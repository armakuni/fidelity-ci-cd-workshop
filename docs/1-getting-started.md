# Getting Started 

## Intro 
For the purposes of this demo, there is already a Concourse CI cluster setup for your usage, so this will not be part of the workshop. There are many ways to run Concourse, feel free to reach out with questions.

This repo contains a basic Python app built to be run as an AWS Lambda function

## What is Fly 
Getting started with Concourse firstly will need to install the fly CLI tool to be able to configure and perform various operations i.e. authentication, deploy your pipeline as code configuration, etc

[Official Documentation for more info](https://concourse-ci.org/fly.html)


## Download and install Fly CLI.
Open up your terminal and run the following, or if installed previously disregard.
```sh
$ curl 'https://<CONCOURSE_URL>/api/v1/cli?arch=amd64&platform=darwin' -o fly \
    && chmod +x ./fly && mv ./fly /usr/local/bin/
```

## Is fly accessible? 
Check by typing `fly --version` on your terminal, you should be prompted with a version number, if not reach out for assistance.

## Login 
login to the Concourse cluster

```sh
fly login --target ak-concourse --concourse-url <CONCOURSE_URL>
```

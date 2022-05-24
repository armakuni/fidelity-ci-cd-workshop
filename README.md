# CI/CD Workshop 

## Purpose 
A quickstart to demonstrate how you can quickly configure a pipeline as code with Concourse CI to build, test and deploy.

For the purposes of this demo, there is already a Concourse CI cluster setup for your usage, so this will not be part of the workshop. There are many ways to run Concourse, feel free to reach out with questions.

## Outcome
- Why use Pipelines as code 
- Awareness of Concourse CI, being able to understand the constructs, terminology, flow, and best practices 
- Being comfortable to write your own concourse pipeline 

## Python App
The workshop includes a basic Lambda Python app to demonstrate the lifecycle of code using CI/CD techniques. The app uses [poetry](https://python-poetry.org/docs/) as the python build tool, and [Terraform](https://www.terraform.io/) as the Infrastructure-as-Code deployment tool.

## Prerequisites
There are a few tools required for this workshop. They are defined in the [Getting Started](docs/1-getting-started.md) guide. Please install and verify all of these tools before continuing


<br />
<br />
<br />

## High Level Recap
### CI/CD
| Integrate                                                      |Deliver                                                       | Deploy   |
|----------------------------------------------------------------|--------------------------------------------------------------|---------------------------|
| Avoid “Works on my machine™”                                   | Avoid the risk and delay associated with “Big Bang” releases | Focus more of our time on building the product                 |
| Understand health and change within the system                 |  Reduce time wasted due to rework and defects                | Increase the sense of ownership in the product team (as a whole)|
| Standardise approaches to linting, security and code style     |                                                              |          |


### Concourse CI Concepts
- [Resources](https://concourse-ci.org/resources.html)
- [Jobs](https://concourse-ci.org/jobs.html)
- [Steps](https://concourse-ci.org/steps.html)
- [Tasks](https://concourse-ci.org/tasks.html)
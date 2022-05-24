# CI/CD Workshop 

## Purpose 
A quickstart to demonstrate how you can quickly configure a pipeline as code with Concourse CI to build, test, deploy.

## Outcome
- Why use Pipelines as code 
- Awareness of Concourse CI, being able to understand the constructs, terminology, flow, and best practices 
- Being comfortable to write your own concourse pipeline 

## Python App
The workshop includes a basic Lambda Python app to demonstrate the lifecycle of code using CI/CD techniques. The app uses [poetry](https://python-poetry.org/docs/) as the python build tool.

### Setup
```
# setup Poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py | python -

# test installation
poetry --version

# install dependencies 
poetry install
```

### Tests: 
```bash
poetry run pytest
```


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
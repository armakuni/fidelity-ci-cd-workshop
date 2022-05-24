# Config Pipeline

## Deploy to production
The first goal of the workshop is to deploy the Python app to AWS. This is achieved with Terraform. 

### Resources

**This resource currently required authentication, please generate a [GitHub Access Token](https://github.com/settings/tokens)**

```yaml
# Resource for polling the GitHub repository for changes
- name: repo
  type: git
  icon: github
  source:
    uri: https://github.com/armakuni/fidelity-concourse-demo
    username: <GitHub Username>
    password: <GitHub Access Token>
```

```yaml
# Resource for a container with Terraform for running the deployment stages
- name: tf-image
  type: registry-image
  icon: terraform
  source:
    repository: hashicorp/terraform
```

### Task
```yaml
# Execute Terraform deployment
- task: deploy
  image: tf-image
  config:
    platform: linux
    inputs:
    - name: repo
    run: 
      path: /bin/sh
      dir: repo/terraform/lambda
      args: 
      - -ec
      - |
        terraform init
        terraform apply -auto-approve
```
*The resources defined above are referenced on lines 2 and 6*


## Add unit tests
The workshop app also includes unit tests that should be run to highlight any issues. These should be added before looking at the code to make sure they react correctly.

### Resource
```yaml
# Resource for a container with Poetry for installing dependencies and running unit tests
- name: poetry-image
  type: registry-image
  icon: language-python
  source:
    repository: fnndsc/python-poetry
```

### Task
```yaml
# Task for executing tests with Pytest
- task: unit-test
  image: poetry-image
  config:
    platform: linux
    inputs:
    - name: repo
    run:
      path: /bin/sh
      dir: repo
      args: 
      - -ec
      - |
        poetry install
        poetry run pytest
```

### Dependency
```yaml
# The deployment stage should now depend on the unit tests passing
# Add the following to the deployment task as a property of the repo 'get'

passed:
- test
```

## Add linting to the pipeline
We can get the pipeline to also verify that the code quality is consistent using Black and iSort. We are looking for the pipeline to fail if the code is not up to Python standards.

There are a few more commands in this task so we have moved the steps to an external script included in the repo 

### Task
```yaml
# Task for verifying code quality using black and isort
- task: lint
  image: poetry-image
  config:
    platform: linux
    inputs:
    - name: repo
    run:
      path: ci/tasks/lint/task.sh
      dir: repo
```

### Dependency
```yaml
# The deploy stage can now depend on both testing and linting to be passing, update to add the lint stage
passed:
- test
- lint
```
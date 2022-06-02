# REPL.it

## Sign up
* Go to https://repl.it and sign up for a new account

## Open repo
* Create a new repl
* On the floating window, select "Import from github" on top right
* In the repo name enter `armakuni/fidelity-ci-cd-workhop`
* Click "+ Import from Github" button

## Install tools
* Go to shell
* Run `source ./repl.it/setup.sh`

# Login
Set Fly up by logging in to the Concourse cluster

```sh
fly login --target ak-concourse --concourse-url https://${CONCOURSE_URL} --username ${CONCOURSE_USERNAME} --password ${CONCOURSE_PASSWORD}
```

# Next steps
Now all of that is set up, head over to the [Config Pipeline](../docs/2-config-pipeline.md) page to get started
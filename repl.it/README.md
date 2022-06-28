# REPL.it

## Sign up
* Go to https://repl.it and sign up for a new account

## Open repo
* Create a new repl using the "Create" button in sidebar or the "+" button on the top-right of the screen
* On the new repl dialog, click the "Import from github" button on top-right
* In the Github URL enter `armakuni/fidelity-ci-cd-workshop`
* Click "+ Import from Github" button

## Install tools
* Go to shell
* Run `source ./repl.it/setup.sh`

## Add secrets
* Ask an AKer for the Concourse password and add it to the environment like so:
`export CONCOURSE_PASSWORD='<value>'`

## Login
Set Fly up by logging in to the Concourse cluster

```sh
fly login --target ak-concourse --concourse-url https://${CONCOURSE_URL} --username ${CONCOURSE_USERNAME} --password "${CONCOURSE_PASSWORD}"
```

## Next steps
Now all of that is set up, head over to the [Config Pipeline](../docs/2-config-pipeline.md) page to get started
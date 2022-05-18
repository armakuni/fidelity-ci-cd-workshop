# Config Pipeline

## Add linting to the pipeline
```
- task: lint
    config:
      platform: linux
      image_resource:
      - name: alpine
        tag: latest
      inputs:
      - name: repo
      run:
        path: poetry run black .
        dir: repo
```
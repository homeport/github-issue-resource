# GitHub Issue Resource

Concourse resource for GitHub issues.

_Note:_ Currently, only checking and using it for `get` steps is supported.

## Source Configuration

* `hostname`: _Required._ The GitHub hostname to be used, for example `github.com`.

* `token`: _Required._ The GitHub access token to authenticate to the configured GitHub hostname.

* `repository`: _Required._ The GitHub repository to work with, for example `homeport/github-issue-resource`.

### Example

``` yaml
resources:
- name: repo-issue
  type: github-issue-resource
  check_every: 2h
  icon: github
  source:
    hostname: github.com
    token: ((github-access-token))
    repository: homeport/github-issue-resource

jobs:
- name: some-job
  plan:
  - get: repo-issue
    trigger: true
  - task: some-task
    config:
      inputs:
      - name: repo-issue
      run:
        path: /bin/bash
        args:
        - -c
        - |
          #!/bin/bash
          ...
```

## Behavior

### `check`: Check for issues

Checks the currently open issues in the configured repository.

### `in`: Get an issue

This is a no-op.

#### Parameters for `in`

There are no parameters.

### `out`: No-op

This is a no-op.

#### Parameters for `out`

There are no parameters.

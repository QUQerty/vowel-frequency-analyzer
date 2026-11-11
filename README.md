# vowel-frequency-analyzer

Custom GitHub Action with Docker (Lecture 3, Activities 1-9) for 43030.

## What it does

On every push to `main`, the workflow builds a Docker image and runs it. Inside
the container:

1. `entrypoint.sh` starts and calls `frequency.py` on `data.txt`.
2. `frequency.py` lowercases the text and counts a, e, i, o and u.
3. `entrypoint.sh` passes that result and the pushing username to `update_readme.sh`.
4. `update_readme.sh` appends a line to this README, commits it as `github-actions`
   and pushes it back to `main`.

## Structure

```
README.md                                          updated by update_readme.sh
data.txt                                           the input text
Dockerfile                                         builds the container
.github/workflows/ci.yml                           builds and runs the image
.github/actions/vowel-frequency-analyzer/action.yml   the reusable action definition
.github/scripts/frequency.py                       counts the vowels
.github/scripts/update_readme.sh                   writes and pushes the result
.github/scripts/entrypoint.sh                      runs inside the container
```

## How the push from inside the container works

`actions/checkout` writes a credential for `GITHUB_TOKEN` into `.git/config`.
The Dockerfile's `COPY . /app` copies the `.git` directory along with everything
else, so the container inherits that credential and can push. This is why the
workflow needs `permissions: contents: write`.

## Changes from the lecture version

- `actions/checkout@v4` instead of the slides' `@v2`, which is deprecated.
- The folder is `.github/`, not `./github/` as printed on the structure slide.
  A directory named `github` is an ordinary folder; Actions only reads `.github`.
- `git config --global --add safe.directory /app` added, because Git refuses to
  operate on a repository owned by a different user inside the container.
- `git push origin HEAD:main` rather than a bare push, since the container's
  checkout is in a detached state and has no upstream branch configured.
- A `SKIP_PUSH` guard added to `update_readme.sh` so the container can be run
  locally for testing without committing.
- `action.yml` points at an image under this account rather than the lecturer's.
  Note the image is not published to GHCR, so the action is a deliverable for
  Activity 5 rather than something `ci.yml` consumes - Activity 4 specifies
  building the Dockerfile directly, which is what the workflow does.

## Analysis log


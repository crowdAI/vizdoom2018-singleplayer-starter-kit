#!/usr/bin/env bash

tag=$1

if [ -z "$tag" ]; then
  echo "ERROR tag empty. Aborting." >&2
  exit 1
fi

git tag -a ${tag} -m "Auto message for tag: ${tag}"
git push origin ${tag}

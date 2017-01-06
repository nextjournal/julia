#!/usr/bin/env bash
#
# Tag with the current branch and git SHA, and push to trigger an automated build
#

TAG=$(git rev-parse --abbrev-ref HEAD)-$(git rev-parse --short HEAD)
echo "Tagging as $TAG"
git tag $TAG
echo "Pushing to trigger automated build"
git push --tags
git push
echo "Check builds at https://hub.docker.com/r/nextjournal/julia/builds/"

#!/usr/bin/env bash
#
TAG=$(git rev-parse --abbrev-ref HEAD)-$(git rev-parse --short HEAD)
GCR_IMAGE=eu.gcr.io/nextjournal-com/julia:$TAG
docker build -t nextjournal/julia:$TAG .
docker tag nextjournal/julia:$TAG $GCR_IMAGE
echo "Tagging $TAG"
git tag $TAG
echo "Pushing to $GCR_IMAGE..."
docker push $GCR_IMAGE
echo "Pushing to Github, which triggers an automated build for nextjournal/julia:$TAG"
git push --tags
git push

#!/usr/bin/env bash
#
TAG=$(git rev-parse --abbrev-ref HEAD)-$(git rev-parse --short HEAD)
docker pull nextjournal/julia:latest
docker build --cache-from nextjournal/julia:latest -t nextjournal/julia:latest .
docker tag nextjournal/julia:latest nextjournal/julia:$TAG

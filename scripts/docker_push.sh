#!/bin/bash

docker_hub_name="${DOCKER_USERNAME}/grafana-openfaas"
release_tag=$(date -u "+%Y-%m-%dT%H-%M-%S")

master_image="${docker_hub_name}:master"
latest_image="${docker_hub_name}:latest"
release_image="${docker_hub_name}:${release_tag}"

echo "Release tag: ${release_image}"

echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker tag "$master_image" "$latest_image"
docker tag "$master_image" "$release_image"

docker push "$latest_image"
docker push "$release_image"

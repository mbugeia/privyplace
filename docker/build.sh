#! /bin/bash

set -eu
export DOCKER_ID_USER="privyplace"
base_image_path="$1"
tag="${2:-latest}"

for image_path in $(find $base_image_path -type d)
do
  image="$(basename $image_path)"
  echo "#########################################"
  echo "Building image "$DOCKER_ID_USER"/"$image""
  echo "#########################################"
  docker build -t "$DOCKER_ID_USER"/"$image":"$tag" "$image_path"
  docker push "$DOCKER_ID_USER"/"$image":"$tag"
done

#! /bin/bash

set -eu
DOCKER_ID_USER=${DOCKER_ID_USER:-"privyplace"}
base_image_path="$1"
tag="${2:-"latest"}"
push="${3:-"yes"}"

for image_path in $(find $base_image_path -type d)
do
  image="$(basename $image_path)"
  echo "#########################################"
  echo "Building image "$DOCKER_ID_USER"/"$image""
  echo "#########################################"
  if [ ! "$tag" = "latest" ]
  then
    docker build -t "$DOCKER_ID_USER"/"$image":latest "$image_path" --no-cache
    docker tag "$DOCKER_ID_USER"/"$image":latest "$DOCKER_ID_USER"/"$image":"$tag"
    if [ "$push" = "yes" ]
    then
      docker push "$DOCKER_ID_USER"/"$image":"$tag" 
    fi
  else
    docker build -t "$DOCKER_ID_USER"/"$image":latest "$image_path"
  fi
  if [ "$push" = "yes" ]
  then
    docker push "$DOCKER_ID_USER"/"$image":latest
  fi
done

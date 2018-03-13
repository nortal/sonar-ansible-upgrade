#!/bin/bash

TESTS_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

if [ $# -eq 0 ]
  then
    echo "\n\nProvide container id as parameter!\n\n"
    exit 1
fi

CONTAINER_ID="$1"
NEW_IMAGE_NAME="committed_${CONTAINER_ID}"

# Run container mounting playbooks as volume
docker commit ${CONTAINER_ID} ${NEW_IMAGE_NAME}
echo "Image created. Connecting with ssh"

docker run --volumes-from ${CONTAINER_ID} --name ${NEW_IMAGE_NAME} -it ${NEW_IMAGE_NAME} /bin/bash
echo "Cleaning up container and image"

# Cleanup container and image
docker rm ${NEW_IMAGE_NAME}
docker rmi ${NEW_IMAGE_NAME}

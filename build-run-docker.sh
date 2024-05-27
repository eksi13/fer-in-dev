#!/bin/bash

PROJECT_DIR="/Users/ek/Documents/RWTH/7_SS24/BA/fer-in-dev"

# cd to project directory
if [ "$(pwd)" != "$PROJECT_DIR" ]; then
    echo "Navigating to project directory: $PROJECT_DIR"
    cd "$PROJECT_DIR" || { echo "Failed to navigate to project directory"; exit 1; }
else
    echo "Already in the project directory"
fi

# build container
IMAGE_NAME="fer-in-dev"
echo "Building Docker image: $IMAGE_NAME"
docker build -t "$IMAGE_NAME" .

if [ $? -ne 0 ]; then
    echo "Docker build failed"
    exit 1
fi

# create and run persistent volume
CONTAINER_NAME="fer-in-dev"
HOST_VOLUME_DIR="/Users/ek/Documents/RWTH/7_SS24/BA/fer-in-dev/data"
CONTAINER_VOLUME_DIR="/project/data"

echo "Running Docker container: $CONTAINER_NAME with volume $HOST_VOLUME_DIR:$CONTAINER_VOLUME_DIR"
docker run -p 8888:8888 --name "$CONTAINER_NAME" -v "$HOST_VOLUME_DIR:$CONTAINER_VOLUME_DIR" "$IMAGE_NAME"

# check if container was started
if [ $? -ne 0 ]; then
    echo "Failed to run Docker container"
    exit 1
fi
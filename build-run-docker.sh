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

# run docker container
CONTAINER_NAME="fer-in-dev"
echo "Running Docker container: $CONTAINER_NAME"
docker run -p 8888:8888 --name "$CONTAINER_NAME" "$IMAGE_NAME"

# check if container was started
if [ $? -ne 0 ]; then
    echo "Failed to run Docker container"
    exit 1
fi

echo "Docker container is running. Access Jupyter Notebook at http://localhost:8888"

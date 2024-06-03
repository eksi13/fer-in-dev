#!/bin/bash

PROJECT_DIR="/Users/ek/Documents/RWTH/7_SS24/BA/fer-in-dev"
IMAGE_NAME="fer-in-dev"
CONTAINER_NAME="fer-in-dev"
HOST_VOLUME_DIR="/Users/ek/Documents/RWTH/7_SS24/BA/fer-in-dev/data"
CONTAINER_VOLUME_DIR="/project/data"

# check if docker daemon is running
check_docker_daemon() {
    docker info > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Docker daemon is not running. Attempting to start it..."

        # start docker desktop
        open --background -a Docker
        echo "Waiting for Docker to start..."
        while ! docker info > /dev/null 2>&1; do
            sleep 1
        done

        echo "Docker daemon started successfully."
    fi
}

# cd to project directory
if [ "$(pwd)" != "$PROJECT_DIR" ]; then
    echo "Navigating to project directory: $PROJECT_DIR"
    cd "$PROJECT_DIR" || { echo "Failed to navigate to project directory"; exit 1; }
else
    echo "Already in the project directory"
fi

# check if docker daemon is running
check_docker_daemon

# check if container exists
if [ "$(docker ps -a -q -f name=$CONTAINER_NAME)" ]; then
    echo "Container $CONTAINER_NAME already exists."

    # check if the container is running
    if [ "$(docker ps -q -f name=$CONTAINER_NAME)" ]; then
        echo "Container $CONTAINER_NAME is already running."
    else
        echo "Starting the existing container $CONTAINER_NAME."
        docker start "$CONTAINER_NAME"
    fi
else
    # build container
    echo "Building Docker image: $IMAGE_NAME"
    docker build -t "$IMAGE_NAME" .

    if [ $? -ne 0 ]; then
        echo "Docker build failed"
        exit 1
    fi

    echo "Creating and running container $CONTAINER_NAME."
    docker run -p 8888:8888 --name "$CONTAINER_NAME" -v "$HOST_VOLUME_DIR:$CONTAINER_VOLUME_DIR" -it "$IMAGE_NAME"
    
    # check if container was started
    if [ $? -ne 0 ]; then
        echo "Failed to run Docker container"
        exit 1
    fi
fi
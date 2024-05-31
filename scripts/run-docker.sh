PROJECT_DIR="/Users/ek/Documents/RWTH/7_SS24/BA/fer-in-dev"
IMAGE_NAME="fer-in-dev"
CONTAINER_NAME="fer-in-dev"
HOST_VOLUME_DIR="/Users/ek/Documents/RWTH/7_SS24/BA/fer-in-dev/data"
CONTAINER_VOLUME_DIR="/project/data"

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


check_docker_daemon

docker run -p 8888:8888 --name "$CONTAINER_NAME" -v "$HOST_VOLUME_DIR:$CONTAINER_VOLUME_DIR" -it "$IMAGE_NAME"

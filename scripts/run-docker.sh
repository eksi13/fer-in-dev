PROJECT_DIR="/Users/ek/Documents/RWTH/7_SS24/BA/fer-in-dev"
IMAGE_NAME="fer-in-dev"
CONTAINER_NAME="fer-in-dev"
HOST_VOLUME_DIR="/Users/ek/Documents/RWTH/7_SS24/BA/fer-in-dev/data"
CONTAINER_VOLUME_DIR="/project/data"

docker run -p 8888:8888 --name "$CONTAINER_NAME" -v "$HOST_VOLUME_DIR:$CONTAINER_VOLUME_DIR" -it "$IMAGE_NAME"

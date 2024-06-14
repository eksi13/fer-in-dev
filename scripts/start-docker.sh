check_docker_daemon() {
    docker info > /dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "Docker daemon is not running. Attempting to start it..."

        open --background -a Docker
        echo "Waiting for Docker to start..."
        while ! docker info > /dev/null 2>&1; do
            sleep 1
        done

        echo "Docker daemon started successfully."
    fi
}

check_docker_daemon

cd /Users/ek/Documents/RWTH/7_SS24/BA/fer-in-dev

docker run -it --rm -p 8888:8888 -v "${PWD}":/home/jovyan/work quay.io/jupyter/datascience-notebook:2024-05-27


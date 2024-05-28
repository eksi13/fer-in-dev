FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /project/data /project/models /project/notebooks
WORKDIR /project

# add datasets
COPY /data/AFEW ./data/in/AFEW
COPY /data/EmoReact ./data/in/EmoReact
COPY /data/FER-2013 ./data/in/FER-2013
COPY /data/KDEF-AKDEF ./data/in/KDEF-AKDEF
COPY /data/KDEF-dyn ./data/in/KDEF-dyn
COPY /data/NIMH-CHEFS ./data/in/NIMH-CHEFS

# add models
COPY /models/face_landmarker.task /models/blaze_face_short_range.tflite ./models/

# add notebooks
COPY /notebooks/face_detection.ipynb /notebooks/mediapipe.ipynb /notebooks/video.ipynb ./notebooks/

# add requirements
COPY build-run-docker.sh .gitignore README.md requirements.txt ./

# setup
RUN apt update && \
    apt install -y git python3 python3-pip && \
    pip3 install -r requirements.txt

RUN apt-get install ffmpeg libsm6 libxext6  -y

EXPOSE 8888
ENV NAME World

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
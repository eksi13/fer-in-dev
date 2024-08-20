FROM ubuntu:20.04

ENV DEBIAN_FRONTEND noninteractive
   
RUN mkdir -p /project/volume/data /project/volume/models /project/volume/notebooks
WORKDIR /project

# add models
COPY /models/face_landmarker.task /models/blaze_face_short_range.tflite ./volume/models/

# add notebooks
COPY /notebooks/face_detection.ipynb /notebooks/mediapipe.ipynb /notebooks/video.ipynb ./volume/notebooks/

# add requirements
COPY /scripts/build-run-docker.sh ./
COPY .gitignore ./
COPY README.md ./
COPY requirements.txt ./

# setup
RUN apt-get update && \
    apt-get install -y git python3 python3-pip pkg-config ffmpeg libsm6 libxext6

RUN pip3 install -r requirements.txt

EXPOSE 8888
ENV NAME World

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
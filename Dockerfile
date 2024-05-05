FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

RUN mkdir -p /project/data
WORKDIR /project
COPY /data/FER-2013 ./data/in/FER-2013
COPY /data/NIMH-CHEFS ./data/in/NIMH-CHEFS
COPY requirements.txt .gitignore README.md face_detection.ipynb ./

# setup
RUN apt update && \
    apt install -y git python3 python3-pip && \
    pip3 install -r requirements.txt

RUN apt-get install ffmpeg libsm6 libxext6  -y

EXPOSE 8888
ENV NAME World

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
FROM ubuntu:20.04

RUN mkdir -p /project/data
WORKDIR /project
COPY /data/FER-2013 /data/NIMH-CHEFS ./data/
COPY requirements.txt .gitignore README.md face_detection.ipynb ./

# setup
RUN apt update && \
    apt install -y git python3 python3-pip && \
    pip3 install -r requirements.txt

EXPOSE 8888
ENV NAME World

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
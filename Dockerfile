FROM alpine:latest

RUN mkdir -p /app /data /models
WORKDIR /app

COPY requirements.txt README.md .gitignore /app/
COPY /data/FER-2013 /data
COPY /data/NIMH_CHEFS /data
COPY face_detection.ipynb .

RUN apk update && \
    apk add --no-cache libglib2.0-0 \
    apk add git gcc python3-dev \
    rm -rf /var/cache/apk/* 
    
RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 8888

ENV NAME World

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

# docker build -t ml-model . 
# docker run -p 8888:8888 -v /Users/ek/Documents/RWTH/7_SS24/BA/fer-in-dev/data/NIMH-CHEFS:/app/data/in/NIMH-CHEFS ml-model

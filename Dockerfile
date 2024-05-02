FROM python:3.8-slim

RUN mkdir /app
WORKDIR /app

RUN apt-get update && apt-get install -y gcc python3-dev
RUN pip install jupyter

# COPY main.py .
COPY requirements.txt .
COPY face_detection.ipynb .

# mediapipe model
COPY face_landmarker.task .


RUN pip install --no-cache-dir -r requirements.txt
RUN apt-get update && apt-get install -y libglib2.0-0 libgl1-mesa-glx && rm -rf /var/lib/apt/lists/*

EXPOSE 8888

ENV NAME World

CMD ["jupyter", "notebook", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]

# docker build -t ml-model . 
# docker run -p 8888:8888 -v /Users/ek/Documents/RWTH/7_SS24/BA/fer-in-dev/data/NIMH-CHEFS:/app/data/in/NIMH-CHEFS ml-model

FROM ubuntu:latest

WORKDIR /app

ARG DEBIAN_FRONTEND=noninteractive
# install python
RUN apt-get update && apt-get install -y python3 python3-dev python3-pip \
    virtualenv libssl-dev libpq-dev git build-essential libfontconfig1 libfontconfig1-dev
RUN pip3 install setuptools pip --upgrade --force-reinstall

RUN pip3 install SimpleITK

COPY convert.py /app/convert.py
COPY find-lungs.ws /app/find-lungs.ws
COPY lung-mask.png /app/lung-mask.png
COPY tn_lung-mask.jpg /app/tn_lung-mask.jpg
COPY start.py /app/start.py
COPY listen.py /app/listen.py
RUN mkdir /app/common
COPY common/* /app/common/

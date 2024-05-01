# Root image
FROM debian:latest

# Python environment
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update && apt-get -y upgrade && apt-get -y install python3 python3-venv pip

# Quart
ENV APP_NAME=app
ENV FOLDER_VENV=/opt/quart/$APP_NAME
RUN mkdir -p $FOLDER_VENV
WORKDIR $FOLDER_VENV
RUN [ -d .venv ] || python3 -m venv .venv && .venv/bin/pip install --no-cache-dir quart quart-cors

# Code
COPY app/* ./
COPY keys/* ./

# RUN from venv
CMD [ ".venv/bin/python3", "main.py"]

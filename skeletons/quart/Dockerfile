# Root image
FROM debian:latest

# Python environment
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get -y update && apt-get -y upgrade && apt-get -y install python3 python3-venv pip

# Quart venv
ENV APP_NAME=skeleton
ENV FOLDER_VENV=/opt/quart/$APP_NAME
RUN mkdir -p $FOLDER_VENV
RUN [ -d $FOLDER_VENV/.venv ] \
        || python3 -m venv $FOLDER_VENV/.venv \
        && $FOLDER_VENV/.venv/bin/pip install --no-cache-dir quart quart-cors
WORKDIR $FOLDER_VENV
COPY entrypoint.bash /opt/quart/$APP_NAME


# RUN from venv
ENTRYPOINT [ "/opt/quart/skeleton/entrypoint.bash"]

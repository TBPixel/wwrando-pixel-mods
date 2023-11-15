FROM devkitpro/devkitppc:latest

WORKDIR /app


RUN apt update && apt install -y software-properties-common

RUN apt upgrade -y

# RUN apt install -y wget build-essential libncursesw5-dev libssl-dev libsqlite3-dev tk-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev zlib1g-dev

# CMD ["/bin/sh"]

# RUN python --version

# RUN python -m pip install requirements.txt

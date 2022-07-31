FROM debian:11.3
RUN apt update \
 && apt install -y \
    default-jdk \
 && rm -rf /var/lib/apt/lists/*
EXPOSE 80

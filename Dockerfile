FROM debian:11.3
RUN apt update \
 && apt install -y \
    default-jdk \
    wget \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /opt
COPY apache-tomcat-*.tar.gz tomcat/
RUN tar xpvf tomcat/apache-tomcat-*.tar.gz -C tomcat/ --strip-components=1
EXPOSE 80

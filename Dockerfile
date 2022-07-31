FROM debian:11.3
RUN mkdir /opt/tomcat
RUN apt update \
 && apt install -y \
    default-jdk \
    wget \
 && rm -rf /var/lib/apt/lists/*
COPY apache-tomcat-*.tar.gz /opt/tomcat \
 && tar xpvf /opt/tomcat/apache-tomcat-*.tar.gz -C /opt/tomcat --strip-components=1
EXPOSE 80

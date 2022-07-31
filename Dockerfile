FROM debian:11.3
RUN mkdir /opt/tomcat10
RUN apt update \
 && apt install -y \
    default-jdk \
    wget \
 && rm -rf /var/lib/apt/lists/* \
RUN wget -P /opt/tomcat10 https://downloads.apache.org/tomcat/tomcat-10/v10.0.23/bin/apache-tomcat-10.0.23.tar.gz  \
 && tar xpvf apache-tomcat-10.0.23.tar.gz -C /opt/tomcat --strip-components=1
EXPOSE 80

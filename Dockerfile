FROM debian:11.3
RUN apt update \
 && apt install -y \
    default-jdk \
    wget \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /opt
COPY apache-tomcat-*.tar.gz tomcat/
RUN tar xpvf tomcat/apache-tomcat-*.tar.gz -C tomcat/ --strip-components=1 \
 && rm -f tomcat/apache-tomcat-*.tar.gz
ENV JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
ENV JAVA_OPTS=-Djava.security.egd=file:///dev/urandom
ENV CATALINA_PID=/opt/tomcat/temp/tomcat.pid
ENV CATALINA_OPTS="-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
CMD tomcat/bin/startup.sh run && tail -f /opt/tomcat/logs/catalina.out
EXPOSE 8080

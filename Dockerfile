FROM debian:11.3
RUN apt update \
 && apt install -y \
    default-jdk \
    wget \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /opt
RUN useradd -m -U -d tomcat -s /bin/false tomcat
COPY apache-tomcat-*.tar.gz tomcat/
RUN tar xpvf tomcat/apache-tomcat-*.tar.gz -C tomcat/ --strip-components=1 \
 && rm -f tomcat/apache-tomcat-*.tar.gz
RUN chown tomcat:tomcat tomcat/ -R \
 && chmod u+x tomcat/bin -R
ENV JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
ENV JAVA_OPTS=-Djava.security.egd=file:///dev/urandom
ENV CATALINA_PID=/opt/tomcat/temp/tomcat.pid
ENV CATALINA_OPTS="-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
COPY tomcat-users.xml tomcat/conf/tomcat-users.xml
CMD tomcat/bin/startup.sh run && tail -f /opt/tomcat/logs/catalina.out
EXPOSE 8080

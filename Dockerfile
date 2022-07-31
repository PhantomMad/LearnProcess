FROM debian:11.3
RUN apt update \
 && apt install -y \
    default-jdk \
    git \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /opt
COPY apache-tomcat-*.tar.gz tomcat/
COPY tomcat-users.xml tomcat/
COPY apache-maven-*-bin.tar.gz maven/
COPY start.sh .
RUN chmod +x start.sh
ENV JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
ENV JAVA_OPTS=-Djava.security.egd=file:///dev/urandom
ENV CATALINA_PID=/opt/tomcat/temp/tomcat.pid
ENV CATALINA_OPTS="-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
ENV M2_HOME=/opt/maven
ENV MAVEN_HOME=/opt/maven
ENV PATH=${M2_HOME}/bin:${PATH}
CMD ["/opt/start.sh"]
EXPOSE 8080

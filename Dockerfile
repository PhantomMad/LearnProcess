FROM debian:11.3
RUN apt update \
 && apt install -y \
    default-jdk \
    git \
 && rm -rf /var/lib/apt/lists/*
WORKDIR /opt
COPY apache-tomcat-*.tar.gz tomcat/
COPY apache-maven-*-bin.tar.gz maven/
RUN tar xpvf tomcat/apache-tomcat-*.tar.gz -C tomcat/ --strip-components=1 \
 && rm -f tomcat/apache-tomcat-*.tar.gz \
 && tar xpvf maven/apache-maven-*-bin.tar.gz -C maven/ --strip-components=1 \
 && rm -f maven/apache-maven-*-bin.tar.gz
RUN mkdir git/ \
 && git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git git/
 && cd git/ \
 && mvn package \
 && cd ${WORKDIR}
ENV JAVA_HOME=/usr/lib/jvm/java-1.11.0-openjdk-amd64
ENV JAVA_OPTS=-Djava.security.egd=file:///dev/urandom
ENV CATALINA_PID=/opt/tomcat/temp/tomcat.pid
ENV CATALINA_OPTS="-Xms512M -Xmx1024M -server -XX:+UseParallelGC"
ENV M2_HOME=/opt/maven
ENV MAVEN_HOME=/opt/maven
ENV PATH=${M2_HOME}/bin:${PATH}
COPY tomcat-users.xml tomcat/conf/tomcat-users.xml
CMD  tomcat/bin/startup.sh run && tail -f /opt/tomcat/logs/catalina.out
EXPOSE 8080

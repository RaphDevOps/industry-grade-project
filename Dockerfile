FROM tomcat:9.0-jdk11-openjdk-slim as builder

RUN rm -rf /usr/local/tomcat/webapps/*

COPY /tmp/jenkinsdir/workspace/Industry-grade-project2/target/ABCtechnologies-1.0.war

RUN chown -R tomcat:root /usr/local/tomcat && \
    chmod -R 775 /usr/local/tomcat

ENV JAVA_OPTS="-Dfile.encoding=UTF-8 -Xms512m -Xmx1024m"

EXPOSE 8080

CMD ["catalina.sh", "run"]

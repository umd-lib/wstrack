FROM maven:3.6.1-jdk-7-slim as build

WORKDIR /app
ADD docker/m2-settings.xml /root/.m2/settings.xml

COPY ./pom.xml /app
COPY ./client/pom.xml /app/client/pom.xml
COPY ./server/pom.xml /app/server/pom.xml

RUN mvn dependency:go-offline -B

COPY . /app

RUN mvn -DskipTests install

FROM docker.lib.umd.edu/tomcat7:jdk7-umd-1.0
ENV TZ=America/New_York

RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    rm -rf /usr/local/tomcat/webapps/*

COPY ./docker/context.xml /usr/local/tomcat/conf/
COPY --from=build /app/server/target/wstrack-server*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080 8009

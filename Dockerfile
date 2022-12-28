FROM openjdk:11-jre
VOLUME /tmp
ADD target/insead-demo-1.0.0.jar inseaddemo.jar
ENTRYPOINT ["java","-jar","/inseaddemo.jar"]

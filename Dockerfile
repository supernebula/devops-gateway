FROM 192.168.2.40/base-image/eclipse-temurin:17.0.12_7-jdk-alpine
COPY entrypoint.sh /home/entrypoint.sh
COPY stop-java.sh /home/stop-java.sh
RUN chmod +x /home/*.sh
COPY  $WORKSPACE/{Pserver}/{appname}/target/*.jar   /home/app.jar
ENTRYPOINT ["sh","/home/entrypoint.sh"]

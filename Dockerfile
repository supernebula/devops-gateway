FROM 192.168.2.40/base-image/jdk:17-jdk-alpine
COPY entrypoint.sh /home/entrypoint.sh
COPY stop-java.sh /home/stop-java.sh
RUN chmod +x /home/*.sh
COPY  $WORKSPACE/{Pserver}/{appname}/target/*.jar   /home/app.jar
ENTRYPOINT ["sh","/home/entrypoint.sh"]

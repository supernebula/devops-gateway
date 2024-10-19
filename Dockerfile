#FROM 192.168.0.215:30004/base-image/jdk:openjdk-8-sec
FROM 192.168.0.215:30004/base-image/jdk:oracle-jdk-8u161
COPY entrypoint.sh /home/entrypoint.sh
COPY stop-java.sh /home/stop-java.sh
RUN chmod +x /home/*.sh
COPY  $WORKSPACE/{Pserver}/{appname}/target/*.jar   /home/app.jar
ENTRYPOINT ["sh","/home/entrypoint.sh"]

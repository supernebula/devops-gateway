#!/bin/bash
set -x
exec java $JAVA_OPTS -jar /home/app.jar -Dspring.config.location=/home/config/application.yml
#exec java $JAVA_OPTS -jar /home/app.jar

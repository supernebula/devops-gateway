#!/bin/bash
set -x
exec java $JAVA_OPTS -jar /home/app.jar --spring.config.location=/home/config/bootstrap.properties
#exec java $JAVA_OPTS -jar /home/app.jar

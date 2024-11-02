#!/bin/bash
set -x
exec java $JAVA_OPTS $JAVA_TOOL_OPTIONS -jar /home/app.jar --spring.config.location=/home/config/application.yml
#exec java $JAVA_OPTS -jar /home/app.jar

#!/bin/bash
#pkill java
curl --location --request PUT http://$POD_IP:$PORT/actuator/shutdown/discovery/client

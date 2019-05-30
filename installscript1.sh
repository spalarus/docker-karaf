#!/bin/bash

sleep 7
/opt/karaf/bin/client -r 11  "shell:sleep 1;"
sleep 3
/opt/karaf/bin/client -r 7 -l 2 -b < /opt/karaf/bin/initcommands

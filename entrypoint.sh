#!/bin/bash

if [ -f /opt/karaf/firstboot ]
then
    bash /opt/karaf/bin/initkaraf
    rm /opt/karaf/bin/initkaraf
fi

/opt/karaf/bin/checkvoletc

unset INIT_SCRIPT_USER
unset INIT_SCRIPT_PWD
unset KARAF_INIT_COMMANDS


exec "$@"

#!/bin/bash

if [ "${OSGI_IMPLEMENTATION}" = "FELIX" ]
then
    sed -i 's/^\(karaf\.framework\s*=\s*\).*$/\1\felix/' /opt/karaf/etc/config.properties
fi

if [ "${OSGI_IMPLEMENTATION}" = "EQUINOX" ]
then
    sed -i 's/^\(karaf\.framework\s*=\s*\).*$/\1\equinox/' /opt/karaf/etc/config.properties
fi

if [ -f /var/opt/firstboot ]
then
    bash /opt/karaf/bin/initkaraf
fi


exec "$@"

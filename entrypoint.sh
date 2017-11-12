#!/bin/bash

if [ "${JDK_IMPLEMENTATION}" = "OPENJDK" ]
then
    sudo /bin/switch_jdk_impl.sh openjdk
fi

if [ "${JDK_IMPLEMENTATION}" = "ORACLEJDK" ]
then
    sudo /bin/switch_jdk_impl.sh oraclejdk
fi

if [ "${OSGI_IMPLEMENTATION}" = "FELIX" ]
then
    sed -i 's/^\(karaf\.framework\s*=\s*\).*$/\1\felix/' /opt/karaf/etc/config.properties
fi

if [ "${OSGI_IMPLEMENTATION}" = "EQUINOX" ]
then
    sed -i 's/^\(karaf\.framework\s*=\s*\).*$/\1\equinox/' /opt/karaf/etc/config.properties
fi


exec "$@"

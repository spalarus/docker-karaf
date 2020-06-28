FROM spalarus/karaf-base:latest

MAINTAINER spalarus <s.palarus@googlemail.com>


ARG KARAF_VERSION=4.2.9

WORKDIR ${KARAF_HOME}
USER karaf

RUN wget http://www-us.apache.org/dist/karaf/${KARAF_VERSION}/apache-karaf-${KARAF_VERSION}.tar.gz && \
    tar --strip-components=1 -C /opt/karaf -xzf apache-karaf-${KARAF_VERSION}.tar.gz && \
    /tmp/installer.sh apache-karaf-${KARAF_VERSION}.tar.gz && \
    rm /tmp/karaf.valid

EXPOSE 1099 8101 8181 44444

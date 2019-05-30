FROM centos:7

MAINTAINER spalarus <s.palarus@googlemail.com>

ARG KARAF_VERSION=4.2.5
ENV KARAF_HOME=/opt/karaf
ENV KARAF_BASE=/opt/karaf

ADD ./entrypoint.sh /entrypoint.sh
ADD ./initkaraf /opt/karaf/bin/initkaraf

RUN yum update -y && \
    yum install -y wget curl zip unzip vim sudo && \
    yum install -y java-11-openjdk && \
    groupadd -r karaf -g 1001 && \
    useradd -u 1001 -r -g karaf -m -d /opt/karaf -s /sbin/nologin -c "Karaf user" karaf && \
    chmod 755 /opt/karaf && \
    wget http://www-us.apache.org/dist/karaf/${KARAF_VERSION}/apache-karaf-${KARAF_VERSION}.tar.gz && \
    tar --strip-components=1 -C /opt/karaf -xzf apache-karaf-${KARAF_VERSION}.tar.gz && \
    rm apache-karaf-${KARAF_VERSION}.tar.gz && \
    chmod u+x /entrypoint.sh && \
    chmod u+x /opt/karaf/bin/initkaraf && \
    chown -R karaf /opt/karaf && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    touch /var/opt/firstboot

USER karaf
WORKDIR ${KARAF_HOME}

ENV HOME=/opt/karaf
ENV JAVA_HOME=/etc/alternatives/jre_11_openjdk
ENV JRE_HOME=/etc/alternatives/jre_11_openjdk
ENV JAVA_OPTS=
ENV OSGI_IMPLEMENTATION=KEEP
ENV FETCH_CUSTOM_URL=NONE
ENV KARAF_INIT_COMMANDS=NONE
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

VOLUME ["/opt/karaf/deploy","/opt/karaf/etc","/opt/karaf/data"]
EXPOSE 1099 8101 8181 44444
ENTRYPOINT ["/entrypoint.sh"]

# Define default command.
CMD ["/opt/karaf/bin/karaf"] 


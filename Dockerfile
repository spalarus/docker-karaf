FROM spalarus/centos-jdk-hybrid:8

MAINTAINER spalarus <s.palarus@gmail.com>

ENV KARAF_VERSION=4.1.3
ENV KARAF_HOME=/opt/karaf

RUN groupadd -r karaf -g 1000 && useradd -u 1000 -r -g karaf -m -d /opt/karaf -s /sbin/nologin \ 
    -c "Karaf user" karaf && chmod 755 /opt/karaf

RUN yum update -y && \
yum install -y openssh-clients && \
yum install -y sudo && \
yum clean all && \
rm -rf /var/cache/yum

RUN wget http://www-us.apache.org/dist/karaf/${KARAF_VERSION}/apache-karaf-${KARAF_VERSION}.tar.gz && \
    tar --strip-components=1 -C /opt/karaf -xzf apache-karaf-${KARAF_VERSION}.tar.gz && \
    rm apache-karaf-${KARAF_VERSION}.tar.gz 

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh && \
    echo 'Defaults    env_keep += "JAVA_VERSION_MAJOR JAVA_VERSION_MINOR"' > /etc/sudoers.d/karaf && \
    echo 'Defaults    env_keep += "RHEL_OPENJDK_PKG_NAME RHEL_OPENJDK_VERSION RHEL_OPENJDK_RELEASE"' >> /etc/sudoers.d/karaf && \
    echo "karaf ALL=(ALL) NOPASSWD:  /bin/switch_jdk_impl.sh" >> /etc/sudoers.d/karaf && \
    chown -R karaf /opt/karaf

USER karaf
WORKDIR ${KARAF_HOME}
ENV OSGI_IMPLEMENTATION=

VOLUME ["/opt/karaf/deploy","/opt/karaf/etc","/opt/karaf/data"]
EXPOSE 1099 8101 8181 44444
ENTRYPOINT ["/entrypoint.sh"]

# Define default command.
CMD ["/opt/karaf/bin/karaf"] 

# todo defaut userpasswd / installationsscript

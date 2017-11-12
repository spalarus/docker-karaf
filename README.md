### karaf
Docker image for [Karaf](http://karaf.apache.org/) based on [CentOS](https://www.centos.org/). 

**Using the image, you accept the [Oracle Binary Code License Agreement](http://www.oracle.com/technetwork/java/javase/terms/license/index.html) for Java SE!!!**

## Usage

run in foreground example:

```shell
docker run \
    --rm -it \
    -v /mydeploy:/opt/karaf/deploy \
    -e JAVA_OPTS="-Xms1024m -Xmx2048m" \
    -e JDK_IMPLEMENTATION=ORACLEJDK \
    -e OSGI_IMPLEMENTATION=EQUINOX \
    -p 8181:8181 \
    spalarus/karaf
```
## Volumes

* /opt/karaf/deploy (karaf hot deploy directory)
* /opt/karaf/data (karaf data directory)
* /opt/karaf/etc (karaf configuration directory)

## Exposed Ports

* 1099 (rmi registry)
* 8101 (ssh)
* 8181 (jetty)
* 44444 (rmi server)

## Switches

* JDK_IMPLEMENTATION: OPENJDK (Default) / ORACLEJDK
* OSGI_IMPLEMENTATION: FELIX (Default) / EQUINOX

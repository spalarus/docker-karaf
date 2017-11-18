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

## Installation / Configuration on first start

Following command creates a karaf-container with feature scr and webconsole. A client in background invokesthe command from VAR *KARAF_INIT_COMMANDS* some seconds after container **starts the first time**.

```shell
docker run --rm -it \
    -e KARAF_INIT_COMMANDS="feature:install scr; feature:install webconsole;" 
    spalarus/karaf
```

To execute complex karaf shell scripts by a background karaf client **on first start**, you should mount this script to */opt/karaf/etc/initcommands* .

```shell
docker run --rm -it \
    -v /this/file/is/a/karafshellscript:/opt/karaf/etc/initcommands
    spalarus/karaf
```
The script does not continue, if one of karaf shell script commands failed.

### Configure properties

Properties in file ${KARAF_BASE}/etc/custom.properties  will override the default values given in config.properties.

```shell
docker run --rm -it \
    -v /my/custom.properties:/opt/karaf/etc/custom.properties
    spalarus/karaf
```

### Configure cfg-files

With [karaf config-commands](http://karaf.apache.org/manual/latest/#__code_config_code_commands) in */karaf/etc/initcommands* it is possible to configure all cfg files **on first start**. 

Docker image for [Karaf](http://karaf.apache.org/) based on [CentOS](https://www.centos.org/) and [OpenJDK 11](https://openjdk.java.net/). 

## Source Repository

@see on [GitHub](https://github.com/spalarus/docker-karaf)

## Usage

run in foreground example:

```shell
docker run \
    --rm -it \
    -v /mydeploy:/opt/karaf/deploy \
    -e JAVA_OPTS="-Xms1024m -Xmx2048m" \
    -e OSGI_IMPLEMENTATION=EQUINOX \
    -p 8181:8181 \
    spalarus/karaf \
    /opt/karaf/bin/karaf
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

## Switch for container selection

* OSGI_IMPLEMENTATION: FELIX (Default) / EQUINOX

## Service installation / configuration

Following command creates a karaf-container with feature scr and webconsole. A client in background invokes the command from VAR *KARAF_INIT_COMMANDS* - this takes some seconds.

```shell
docker run -d --name karaffe \
    -e KARAF_INIT_COMMANDS="feature:install scr; feature:install webconsole;" \
    spalarus/karaf
```

To execute more complex karaf shell-scripts initially, you should mount this script to */opt/karaf/etc/initcommands* .

```shell
docker run -d --name karaffe \
    -v /this/file/is/a/karafshellscript:/opt/karaf/etc/initcommands \
    spalarus/karaf
```
The script does not continue, if one of karaf shell script commands failed.

## Connect to shell of running karaf container (named karaffe)

```shell
docker exec -it karaffe /opt/karaf/bin/client
```

### Configure properties

Properties in file ${KARAF_BASE}/etc/custom.properties  will override the default values given in config.properties.

```shell
docker run -d --name karaffe \
    -v /my/custom.properties:/opt/karaf/etc/custom.properties \
    spalarus/karaf
```

### Configure cfg-files

With [karaf config-commands](http://karaf.apache.org/manual/latest/#__code_config_code_commands) in */karaf/etc/initcommands* it is possible to configure all cfg files **on first start**. 

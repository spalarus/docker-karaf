Docker image for [Karaf](http://karaf.apache.org/) based on [CentOS](https://www.centos.org/) and [OpenJDK 11](https://openjdk.java.net/). 

## Source Repository

@see on [GitHub](https://github.com/spalarus/docker-karaf)

## Usage

run in foreground example:

```shell
docker run --rm -it spalarus/karaf /opt/karaf/bin/karaf
```

## Exposed Ports

* 1099 (rmi registry)
* 8101 (ssh)
* 8181 (jetty)
* 44444 (rmi server)

## Feature installation while container creation - delivered by VAR

Following command creates a karaf-container with feature scr and webconsole. A client in background invokes the commands from variable *KARAF_INIT_COMMANDS* - this takes some seconds. The installation process starts 10 seconds after container creation.

```shell
docker run --rm -it -e KARAF_INIT_COMMANDS="feature:install scr; feature:install webconsole;" spalarus/karaf /opt/karaf/bin/karaf
```

## Volume /opt/karaf/vol

* ./etc (persistent storage for configuration files)
* ./deploy (karaf deployment storage)
* ./log  (directory for log files)
* ./tmp (directory for tmp files)
* ./bin (directory for initcommands-file)

```shell
docker run --rm -it -v /home/basti/karvol:/opt/karaf/vol spalarus/karaf /opt/karaf/bin/karaf
```
## Feature installation while container creation - delivered in file

The karaf commands for feature installation can provided in file  *<VOL>/bin/initcommands*. The installation process starts 10 seconds after container creation.

```shell
echo "feature:install scr; feature:install webconsole;" > /home/basti/karvol/bin/initcommands
docker run --rm -it -v /home/basti/karvol:/opt/karaf/vol spalarus/karaf /opt/karaf/bin/karaf
```
The script does not continue, if one of karaf shell script commands failed.


### Backround Karaf Container

docker run -d --name karaffe -v /home/basti/karvol:/opt/karaf/vol spalarus/karaf 

## Connect to shell of running karaf container (named karaffe)

```shell
docker exec -it karaffe /opt/karaf/bin/client
```

### Persistent configuration files

Configuration files can move to volume. Updates in such files survive container recreation, if volume directory is mounted to host.

To persist user.properties use following command:
```shell
docker exec -it karaffe /opt/karaf/bin/touchvoletc users.properties
```

It is possible to provide configuration files in *<VOL>/etc/* manually. A container recreation or restart checks this directory and links the newly provided configuration files to karaf/etc-directory. To invoke this check in running karaf container on demand, please use following command:

```shell
docker exec -it karaffe /opt/karaf/bin/checkvoletc
```

## FAQ

* On SELinux secured systems (RHEL/CentOS) mount volume with Z-Option (docker run -d --name karaffe -v /home/basti/karvol:/opt/karaf/vol**:Z** spalarus/karaf)
* On docker systems with CAP_SETUID-capability-issues this container can started as root user (docker run ... **-u root** ... spalarus/karaf ) 

Centos 6.5 LAMP ZendFramework 2
================================

Docker Image including CentOS-6, Apache 2.2, PHP 5.6, ZendFramework2 Skeleton Application

## Reference
See [Centos php56 README](https://github.com/stefanorg/centos-php56/blob/master/README.md)

## Quick Example

Run up a container named ```zf2.app-1.1.1``` from the docker image ```stefanorg/lamp-zf2``` on port 8080 of your docker host.

```
$ docker run -d \
  --name zf2.app-1.1.1 \
  -p 8080:80 \
  --env SERVICE_UNIT_APP_GROUP=app-1 \
  --env SERVICE_UNIT_LOCAL_ID=1 \
  --env SERVICE_UNIT_INSTANCE=1 \
  --env APACHE_SERVER_NAME=app-1.local \
  --env APACHE_SERVER_ALIAS=app-1 \
  --env DATE_TIMEZONE=UTC \
  -v /var/services-data/zf2/app-1:/var/www/app \
  stefanorg/lamp-zf2:latest
```

Now point your browser to ```http://<docker-host>:8080``` where "```<docker-host>```" is the host name of your docker server and, if all went well, you should see the "ZF2 Skeleton Application" page.

![ZF2 Skeleton Application](https://raw.github.com/stefanorg/lamp-zf2/master/images/zf2-skeleton.png)

### DocumentRoot Data Directory

In the previous example Docker run commands we mapped the Docker host directory ```/var/services-data/zf2/app-1``` to ```/var/www/app``` in the Docker container, where ```/var/services-data/``` is the directory used to store persistent files and the subdirectory is used by an individual app's named container(s), ```zf2.app-1.1.1```, in the previous examples.

On first run, the bootstrap script, ([/etc/apache-bootstrap](https://github.com/stefanorg/lamp-zf2/blob/master/etc/apache-bootstrap)), will check if the DocumentRoot directory is empty and, if so, will poplate it with the example app scripts and VirtualHost configuration files. If you place your own app in this directory it will not be overwritten but you must ensure to include at least a vhost.conf file and, if enabling SSL a vhost-ssl.conf file too.
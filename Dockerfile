FROM centos:7
MAINTAINER Percona Development <info@percona.com>

RUN yum install -y https://github.com/sysown/proxysql/releases/download/v1.2.0g/proxysql-1.2.0-1-centos7.x86_64.rpm

ADD proxysql.cnf /etc/proxysql.cnf

COPY proxysql-entry.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

VOLUME /var/lib/proxysql

EXPOSE 3306 6032
ONBUILD RUN yum update -y

CMD [""]

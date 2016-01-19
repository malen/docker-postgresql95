FROM malen/docker-centos72:latest

MAINTAINER malen malen.ma@gmail.com

RUN yum -y update; yum clean all
RUN yum -y install sudo epel-release; yum clean all

RUN yum -y install http://yum.postgresql.org/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-2.noarch.rpm
RUN yum -y install postgresql95-server; yum clean all

#Sudo requires a tty. fix that.
RUN sed -i 's/.*requiretty$/#Defaults requiretty/' /etc/sudoers

#Add shell to docker, and then run it.
ADD ./postgresql95-setup /usr/bin/postgresql-setup
#ADD ./start_postgres.sh /start_postgres.sh
#ADD ./postgresql.conf /var/lib/pgsql/data/postgresql.conf

RUN chmod +x /usr/bin/postgresql-setup
#RUN chmod +x /start_postgres.sh
#RUN chown -v postgres.postgres /var/lib/pgsql/data/postgresql.conf

RUN /usr/bin/postgresql-setup initdb

RUN echo "host  all all 0.0.0.0/0" >> /var/lib/pgsql/data/pg_hba.conf

VOLUME ["/var/lib/pgsql"]
EXPOSE 5432
#CMD ["/bin/bash", "/start_postgres.sh"]

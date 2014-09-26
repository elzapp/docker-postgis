FROM ubuntu
RUN apt-get update
RUN apt-get -y install postgresql postgresql-contrib postgis postgresql-9.3-postgis-2.1
COPY start.sh /root/start.sh
COPY setup-pgsql.sh /var/lib/postgresql/setup-pgsql.sh
RUN chmod a+x /var/lib/postgresql/setup-pgsql.sh /root/start.sh
RUN su postgres -c /var/lib/postgresql/setup-pgsql.sh
RUN echo "host all all 172.17.42.1/16 trust" > /etc/postgresql/9.3/main/pg_hba.conf
RUN sed -i "s/^#listen_addresses =.*/listen_addresses = '*'/" /etc/postgresql/9.3/main/postgresql.conf
CMD ["/bin/bash","/root/start.sh"]
EXPOSE 5432

#!/bin/bash
set -v
/usr/lib/postgresql/9.3/bin/postgres --config-file=/etc/postgresql/9.3/main/postgresql.conf&
PID=$!
sleep 1
echo "UPDATE pg_database SET datistemplate = FALSE WHERE datname = 'template1';"|psql
echo "DROP DATABASE template1;"|psql
echo "CREATE DATABASE template1 WITH TEMPLATE = template0 ENCODING = 'UNICODE';"|psql
echo "UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template1';"|psql
echo "VACUUM FREEZE;"|psql template1

createuser gisuser
createdb --encoding=UTF8 --owner=gisuser gis


psql -d gis -f /usr/share/postgresql/9.3/contrib/postgis-2.1/postgis.sql
psql -d gis -f /usr/share/postgresql/9.3/contrib/postgis-2.1/spatial_ref_sys.sql
psql -d gis -f /usr/share/postgresql/9.3/contrib/postgis-2.1/postgis_comments.sql
psql -d gis -c "GRANT SELECT ON spatial_ref_sys TO PUBLIC;"
psql -d gis -c "GRANT ALL ON geometry_columns TO gisuser;"

kill $PID

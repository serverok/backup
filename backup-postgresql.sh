#!/bin/bash
# Author: ServerOk
# Web: https://serverok.in/backup
# For postgresql database authentication, use ~/.pgpass file.
# refer https://www.postgresql.org/docs/9.3/libpq-pgpass.html
# Here is an example .pgpass file
# root@root1090:~# cat .pgpass
# 127.0.0.1:5432:tropicalmountains:odoofox:Z2bLevYRuLtnY
# root@root1090:~# 
# @daily /usr/serverok/backup-postgresql.sh > /dev/null 2>&1

PGSQL_USER="odoofox"
PGSQL_DATABASE="tropicalmountains"
EMAIL_TO="admin@serverok.in"

if [ ! -d "/backup-postgresql/" ]
then
    echo "PostgreSQL backup failed"
fi

pg_dump -U $PGSQL_USER -h 127.0.0.1 --port=5432 -w -F p $PGSQL_DATABASE > /backup-postgresql/$PGSQL_DATABASE.sql

if [ $? -ne 0 ]; then
    echo "database backup failed - `hostname` - `date`" | mail -s 'PostgreSQL Backup failed' $EMAIL_TO
fi

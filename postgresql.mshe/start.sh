#!/bin/bash

echo "setting pg_hba.conf"
cp /docker-entrypoint-initdb.d/pg_hba.conf /var/lib/postgresql/data/pg_hba.conf


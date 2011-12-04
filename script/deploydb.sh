#!/bin/sh
psql -f data/schema/schema.sql $1
sh script/deploy_postgis.sh $1
psql -f data/schema/map.sql $1


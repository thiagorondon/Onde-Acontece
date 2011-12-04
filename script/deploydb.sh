#!/bin/sh
psql -f data/schema/map.sql $1
psql -f data/schema/schema.sql $1


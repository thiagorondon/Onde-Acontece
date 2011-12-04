#!/bin/sh
createlang -d $1 plpgsql
psql -d $1 -f $(pg_config --sharedir)/contrib/postgis-1.5/postgis.sql 
psql -d $1 -f $(pg_config --sharedir)/contrib/postgis-1.5/spatial_ref_sys.sql
 
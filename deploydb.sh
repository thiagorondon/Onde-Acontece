#!/bin/sh

sh script/deploydb.sh ondeacontece
sh script/populatedb.sh 
psql -d ondeacontece -f data/analise/municipios.sql 
psql -d ondeacontece -f data/analise/ocorrencias.sql 
psql -d ondeacontece -f data/analise/ocorrencias_municipio.sql
psql -d ondeacontece -f data/analise/municipio_censo.sql

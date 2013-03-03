#!/bin/sh

sh script/deploydb.sh ondeacontece
sh script/populatedb.sh
psql -d ondeacontece -f data/analise/municipios.sql
psql -d ondeacontece -f data/analise/ocorrencias.sql
psql -d ondeacontece -f data/analise/ocorrencias_municipio.sql
psql -d ondeacontece -f data/analise/municipio_censo.sql
psql -d ondeacontece -f data/analise/municipio_ibge_to_ssprs.sql
psql -d ondeacontece -f data/analise/rate_por_municipio_por_ano.sql

insert into municipio_censo select mun.id, r.descricao, r.valor, r.unidade from municipios mun join raw_ibge_censo r on r.cidade = mun.nome group by mun.id, r.descricao, r.valor, r.unidade;

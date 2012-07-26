-- gerar lista de municipios
insert into municipios (nome, estado_id, the_geom) select nome_municipio, (select gid from state where uf = 'RS'), the_geom from map where map.sigla = 'RS';

-- gerar mapeamento normalizador de nome de município
insert into municipio_maps (nome, municipio_id) select raw.municipio, m.id  from map join raw_indicadores_ssprs_municipioss raw on upper(translate(map.nome_municipio, 'áâãäåāăąÁÂÃÄÅĀĂĄèééêëēĕėęěĒĔĖĘĚìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇ', 'aaaaaaaaaaaaaaaeeeeeeeeeeeeeeeiiiiiiiiiiiiiiiiooooooooooooooouuuuuuuuuuuuuuuucc')) = raw.municipio join municipios m on m.nome = map.nome_municipio join raw_ibge_censo ric on ric.cidade = map.nome_municipio where ano = 2002 and map.sigla = 'RS';


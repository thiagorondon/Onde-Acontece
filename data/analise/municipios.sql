-- gerar lista de municipios
insert into municipios (nome, estado_id) select nome_municipio, (select gid from state where uf = 'RS') from map where map.sigla = 'RS';

-- gerar mapeamento normalizador de nome de município
insert into municipio_maps (nome, municipio_id) select raw.municipio, m.id  from map join raw_indicadores_ssprs_municipioss raw on upper(translate(map.nome_municipio, 'áâãäåāăąÁÂÃÄÅĀĂĄèééêëēĕėęěĒĔĖĘĚìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇ', 'aaaaaaaaaaaaaaaeeeeeeeeeeeeeeeiiiiiiiiiiiiiiiiooooooooooooooouuuuuuuuuuuuuuuucc')) = raw.municipio join municipios m on m.nome = map.nome_municipio where ano = 2002 and map.sigla = 'RS';


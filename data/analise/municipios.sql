insert into municipios (nome, estado_id) select nome_municipio, (select gid from state where uf = 'RS') from map where map.sigla = 'RS';

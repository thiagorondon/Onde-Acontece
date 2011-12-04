for my $tipo (
  qw(homicidio
  furtos_veiculo
  furtos
  roubos
  latrocionio
  roubo_veiculo
  extorsao
  extorsao_sequesto
  estelionato
  delitos_corrupcao
  posse_entorpecente
  delitos_municoes
  trafico_entorpecente)
  )
{

  for my $ano ( 2002 .. 2011 ) {
    print qq{insert into ocorrencia_municipios (ocorrencia_id, municipio_id, quant, ano) select (select id from ocorrencias where tipo = '$tipo'), m.id, raw.$tipo, $ano  from map join raw_indicadores_ssprs_municipioss raw on upper(translate(map.nome_municipio, 'áâãäåāăąÁÂÃÄÅĀĂĄèééêëēĕėęěĒĔĖĘĚìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇ', 'aaaaaaaaaaaaaaaeeeeeeeeeeeeeeeiiiiiiiiiiiiiiiiooooooooooooooouuuuuuuuuuuuuuuucc')) = raw.municipio join municipios m on m.nome = map.nome_municipio where ano = $ano and map.sigla = 'RS';\n};
  }
}

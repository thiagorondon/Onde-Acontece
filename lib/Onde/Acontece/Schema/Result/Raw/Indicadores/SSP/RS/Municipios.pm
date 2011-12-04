package Onde::Acontece::Schema::Result::Raw::Indicadores::SSP::RS::Municipios;

use DBIx::Class::Candy -autotable => v1;

column municipio => { data_type => 'varchar', size => 255, is_nullable => 0 };
column $_ => { data_type => 'int', is_nullable => 0 } for qw(
  homicidio
  furtos_veiculo
  furtos
  roubos
  latrocionio
  roubo_veiculo
  extorsao
  extorsao_sequesto
  estelionato
  delitos_corrupcao
  posse
  entorpecente
  delitos_municoes
  trafico_entorpecente
);

column ano => {
  data_type => 'int',
  is_nullable => 0
};

1;

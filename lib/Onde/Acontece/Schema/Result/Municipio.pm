package Onde::Acontece::Schema::Result::Municipio;

use DBIx::Class::Candy -autotable => v1;

primary_column id => {
  data_type         => 'int',
  is_auto_increment => 1,
};

column nome => {
  data_type   => 'varchar',
  is_nullable => 0,
  size        => 255
};

column estado_id => {
  data_type   => 'int',
  is_nullable => 0,
};

unique_constraint [qw(nome estado_id)];

belongs_to estado => 'Onde::Acontece::Schema::Result::State' =>
  { 'foreign.gid' => 'self.estado_id' };

has_many ocorrencias_municipio =>
  'Onde::Acontece::Schema::Result::OcorrenciaMunicipio' =>
  { 'foreign.municipio_id' => 'self.id' };

has_many municipio_censo => 'Onde::Acontece::Schema::Result::MunicipioCenso' =>
  { 'foreign.municipio_id' => 'self.id' };

many_to_many ocorrencias => ocorrencias_municipio => 'ocorrencia';

1;


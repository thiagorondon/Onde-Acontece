package Onde::Acontece::Schema::Result::MunicipioMap;

=head1 DESCRIÇÃO

Essa tabela é um mapeamento de normalização para os nomes de municípios.

Ex.: JEQUIÉ => 'Jequié', JEQUIE => 'Jequié'

A nomenclatura oficial usada para os municípios será a nomenclatura do IBGE

=cut

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

column municipio_id => {
  data_type   => 'int',
  is_nullable => 0
};

belongs_to municipio => 'Onde::Acontece::Schema::Result::Municipio' =>
  { 'foreign.id' => 'self.municipio_id' };

1;

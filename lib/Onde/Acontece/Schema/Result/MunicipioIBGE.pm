
package Onde::Acontece::Schema::Result::MunicipioIBGE;

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

column valor => {
    data_type   => 'varchar',
    size        => 255,
    is_nullable => 0
};

has_many
  seguranca_ocorrencias =>
  'Onde::Acontece::Schema::Result::SegurancaOcorrencia',
  { 'foreign.municipio_id' => 'self.id' };

1;


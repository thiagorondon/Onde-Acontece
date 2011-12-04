
package Onde::Acontece::Schema::Result::SegurancaOcorrencia;

use DBIx::Class::Candy -autotable => v1;

primary_column id => {
    data_type         => 'int',
    is_auto_increment => 1,
};

column municipio_id => {
    data_type   => 'int',
    is_nullable => 0,
    size        => 11
};

column periodo => {
    data_type   => 'int',
    is_nullable => 0,
    size        => 4
};

# ENUM ?
column tipo => {
    data_type   => 'varchar',
    size        => 255,
    is_nullable => 0
};

column ocorrencias => {
    data_type => 'int',
    size      => 11,
    default   => 0
};

has_one
  municipio => 'Onde::Acontece::Schema::Result::Municipio',
  { 'foreign.id' => 'self.municipio_id' };

1;


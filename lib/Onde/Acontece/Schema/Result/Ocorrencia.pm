package Onde::Acontece::Schema::Result::Ocorrencia;
use warnings;
use strict;

use DBIx::Class::Candy -autotable => v1;

primary_column id => {
  data_type         => 'int',
  is_auto_increment => 1,
};

column tipo => {
  data_type   => 'varchar',
  is_nullable => 0,
  size        => 255
};

column nome => {
  data_type   => 'text',
  is_nullable => 1,
};


1;

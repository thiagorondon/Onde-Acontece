package Onde::Acontece::Schema::Result::Estado;

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

column sigla => {
  data_type => 'char',
  size      => 2
};

1;

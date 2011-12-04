package Onde::Acontece::Schema::Result::OcorrenciaMunicipio;
use warnings;
use strict;

use DBIx::Class::Candy -autotable => v1;

column ocorrencia_id => {
  data_type   => 'int',
  is_nullable => 0
};

column municipio_id => {
  data_type   => 'int',
  is_nullable => 0
};

column quant => {
  data_type   => 'int',
  is_nullable => 0
};

belongs_to municipio => 'Onde::Acontece::Schema::Result::Municipio' =>
  { 'foreign.id' => 'self.municipio_id' };

belongs_to ocorrencia => 'Onde::Acontece::Schema::Result::Ocorrencia' =>
  { 'foreign.id' => 'self.ocorrencia_id' };

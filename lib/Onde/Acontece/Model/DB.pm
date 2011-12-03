package Onde::Acontece::Model::DB;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Model::DBIC::Schema' }

__PACKAGE__->config(
  schema_class => 'Onde::Acontece::Schema'
);

__PACKAGE__->meta->make_immutable;
1;

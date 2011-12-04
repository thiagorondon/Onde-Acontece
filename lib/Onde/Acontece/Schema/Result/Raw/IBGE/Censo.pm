use utf8;
package Onde::Acontece::Schema::Result::Raw::IBGE::Censo;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Onde::Acontece::Schema::Result::RawIbgeCenso

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<raw_ibge_censo>

=cut

__PACKAGE__->table("raw_ibge_censo");

=head1 ACCESSORS

=head2 cidade

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 descricao

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 unidade

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 valor

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "cidade",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "descricao",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "unidade",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "valor",
  { data_type => "integer", is_nullable => 0 },
);

1;

use utf8;
package Onde::Acontece::Schema::Result::MunicipioCenso;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Onde::Acontece::Schema::Result::MunicipioCenso

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<municipio_censo>

=cut

__PACKAGE__->table("municipio_censo");

=head1 ACCESSORS

=head2 municipio_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 descricao

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 valor

  data_type: 'double precision'
  is_nullable: 1

=head2 unidade

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "municipio_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "descricao",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "valor",
  { data_type => "double precision", is_nullable => 1 },
  "unidade",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 RELATIONS

=head2 municipio

Type: belongs_to

Related object: L<Onde::Acontece::Schema::Result::Municipio>

=cut

__PACKAGE__->belongs_to(
  "municipio",
  "Onde::Acontece::Schema::Result::Municipio",
  { id => "municipio_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07011 @ 2011-12-04 12:22:07
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:dqVfw4r4EiG0MOWJo9qNzg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

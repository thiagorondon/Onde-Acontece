use utf8;
package Onde::Acontece::Schema::Result::Map;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Onde::Acontece::Schema::Result::Map

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<map>

=cut

__PACKAGE__->table("map");

=head1 ACCESSORS

=head2 gid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'map_gid_seq'

=head2 geocodig_m

  data_type: 'numeric'
  is_nullable: 1
  size: [10,0]

=head2 uf

  data_type: 'text'
  is_nullable: 1

=head2 sigla

  data_type: 'text'
  is_nullable: 1

=head2 nome_municipio

  data_type: 'text'
  is_nullable: 1

=head2 regiao

  data_type: 'text'
  is_nullable: 1

=head2 mesorregiao

  data_type: 'text'
  is_nullable: 1

=head2 nome_mesoregiao

  data_type: 'text'
  is_nullable: 1

=head2 microrregiao

  data_type: 'text'
  is_nullable: 1

=head2 nome_microrregiao

  data_type: 'text'
  is_nullable: 1

=head2 the_geom

  data_type: 'geometry'
  is_nullable: 1

=head2 state_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "gid",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "map_gid_seq",
  },
  "geocodig_m",
  { data_type => "numeric", is_nullable => 1, size => [10, 0] },
  "uf",
  { data_type => "text", is_nullable => 1 },
  "sigla",
  { data_type => "text", is_nullable => 1 },
  "nome_municipio",
  { data_type => "text", is_nullable => 1 },
  "regiao",
  { data_type => "text", is_nullable => 1 },
  "mesorregiao",
  { data_type => "text", is_nullable => 1 },
  "nome_mesoregiao",
  { data_type => "text", is_nullable => 1 },
  "microrregiao",
  { data_type => "text", is_nullable => 1 },
  "nome_microrregiao",
  { data_type => "text", is_nullable => 1 },
  "the_geom",
  { data_type => "geometry", is_nullable => 1 },
  "state_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</gid>

=back

=cut

__PACKAGE__->set_primary_key("gid");

=head1 RELATIONS

=head2 state

Type: belongs_to

Related object: L<Onde::Acontece::Schema::Result::State>

=cut

__PACKAGE__->belongs_to(
  "state",
  "Onde::Acontece::Schema::Result::State",
  { gid => "state_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2011-12-03 23:20:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:4hy4CI85QZaNiHzc9St9vQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

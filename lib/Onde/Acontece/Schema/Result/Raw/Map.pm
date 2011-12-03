use utf8;

package Onde::Acontece::Schema::Result::Raw::Map;

=head1 NAME

Onde::Acontece::Schema::Result::MapCountry

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<map_country>

=cut

__PACKAGE__->table("map");

=head1 ACCESSORS

=head2 gid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'map_country_gid_seq'

=head2 geocodig_m

  data_type: 'numeric'
  is_nullable: 1
  size: [10,0]

=head2 uf

  data_type: 'varchar'
  is_nullable: 1
  size: 254

=head2 sigla

  data_type: 'varchar'
  is_nullable: 1
  size: 254

=head2 nome_municipio

  data_type: 'varchar'
  is_nullable: 1
  size: 254

=head2 regiao

  data_type: 'varchar'
  is_nullable: 1
  size: 254

=head2 mesorregiao

  data_type: 'varchar'
  is_nullable: 1
  size: 254

=head2 nome_mesoregiao

  data_type: 'varchar'
  is_nullable: 1
  size: 254

=head2 microrregiao

  data_type: 'varchar'
  is_nullable: 1
  size: 254

=head2 nome_microrregiao

  data_type: 'varchar'
  is_nullable: 1
  size: 254

=head2 the_geom

  data_type: 'geometry'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "gid",
  { data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "map_country_gid_seq",
  },
  "geocodig_m",
  { data_type => "numeric", is_nullable => 1, size => [ 10, 0 ] },
  "uf",
  { data_type => "varchar", is_nullable => 1, size => 254 },
  "sigla",
  { data_type => "varchar", is_nullable => 1, size => 254 },
  "nome_municipio",
  { data_type => "varchar", is_nullable => 1, size => 254 },
  "regiao",
  { data_type => "varchar", is_nullable => 1, size => 254 },
  "mesorregiao",
  { data_type => "varchar", is_nullable => 1, size => 254 },
  "nome_mesoregiao",
  { data_type => "varchar", is_nullable => 1, size => 254 },
  "microrregiao",
  { data_type => "varchar", is_nullable => 1, size => 254 },
  "nome_microrregiao",
  { data_type => "varchar", is_nullable => 1, size => 254 },
  "the_geom",
  { data_type => "geometry", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</gid>

=back

=cut

__PACKAGE__->set_primary_key("gid");

__PACKAGE__->belongs_to(
  municipio => 'Onde::Acontece::Schema::Result::Municipio' =>
    { 'foreign.id' => 'self.municipio_id' } );

1;

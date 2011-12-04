use utf8;
package Onde::Acontece::Schema::Result::State;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Onde::Acontece::Schema::Result::State

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<state>

=cut

__PACKAGE__->table("state");

=head1 ACCESSORS

=head2 gid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'state_gid_seq'

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 the_geom

  data_type: 'geometry'
  is_nullable: 1

=head2 uf

  data_type: 'text'
  is_nullable: 1

=head2 country_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "gid",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "state_gid_seq",
  },
  "name",
  { data_type => "text", is_nullable => 1 },
#  "the_geom",
#  { data_type => "geometry", is_nullable => 1 },
  "uf",
  { data_type => "text", is_nullable => 1 },
  "country_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</gid>

=back

=cut

__PACKAGE__->set_primary_key("gid");

=head1 RELATIONS

=head2 country

Type: belongs_to

Related object: L<Onde::Acontece::Schema::Result::Country>

=cut

__PACKAGE__->belongs_to(
  "country",
  "Onde::Acontece::Schema::Result::Country",
  { gid => "country_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);

=head2 maps

Type: has_many

Related object: L<Onde::Acontece::Schema::Result::Map>

=cut

__PACKAGE__->has_many(
  "maps",
  "Onde::Acontece::Schema::Result::Map",
  { "foreign.state_id" => "self.gid" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2011-12-03 23:20:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:t9zIXrzU3DbKF0JQEt9zYg


# You can replace this text with custom code or comments, and it will be preserved on regeneration

__PACKAGE__->has_many(
  municipios => 'Onde::Acontece::Schema::Result::Municipio'
     => { 'foreign.estado_id' => 'self.gid' });

1;

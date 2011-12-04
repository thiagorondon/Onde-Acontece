use utf8;
package Onde::Acontece::Schema::Result::Country;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Onde::Acontece::Schema::Result::Country

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<country>

=cut

__PACKAGE__->table("country");

=head1 ACCESSORS

=head2 gid

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0
  sequence: 'country_gid_seq'

=head2 name

  data_type: 'text'
  is_nullable: 1

=head2 the_geom

  data_type: 'geometry'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "gid",
  {
    data_type         => "integer",
    is_auto_increment => 1,
    is_nullable       => 0,
    sequence          => "country_gid_seq",
  },
  "name",
  { data_type => "text", is_nullable => 1 },
  "the_geom",
  { data_type => "geometry", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</gid>

=back

=cut

__PACKAGE__->set_primary_key("gid");

=head1 RELATIONS

=head2 states

Type: has_many

Related object: L<Onde::Acontece::Schema::Result::State>

=cut

__PACKAGE__->has_many(
  "states",
  "Onde::Acontece::Schema::Result::State",
  { "foreign.country_id" => "self.gid" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07014 @ 2011-12-03 23:20:53
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:f7Ms7Wv3CJy/Ddh3onUP4Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

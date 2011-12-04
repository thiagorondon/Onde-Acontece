package Onde::Acontece::Schema::ResultSet::State;

use Moose;
use namespace::autoclean;

extends 'DBIx::Class::ResultSet';

sub with_geojson {
  shift->search_rs( {},
    { '+select' => [ \q{ST_AsGeoJSON(me.the_geom)} ], '+as' => [qw(geojson)] }
  );
}

sub as_hashref {
  my $self = shift;
  $self->result_class('DBIx::Class::ResultClass::HashRefInflator');
  return $self;
}

1;

package Onde::Acontece::Schema::ResultSet::Map;

use Moose;
use namespace::autoclean;

extends 'DBIx::Class::ResultSet';

sub with_geojson {
  shift->search_rs(
    {},
    {
      select => [qw(nome_municipio)],
      '+select' => [ \q{ST_AsgeoJSON((ST_Dump(the_geom)).geom)} ],
      '+as'     => [qw(geojson)],
      group_by  => [qw(nome_municipio sigla  the_geom)]
    }
  );
}

sub as_hashref {
  my $self = shift;
  $self->result_class('DBIx::Class::ResultClass::HashRefInflator');
  return $self;
}

1;

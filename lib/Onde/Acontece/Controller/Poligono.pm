package Onde::Acontece::Controller::Poligono;
use Moose;
use namespace::autoclean;
use JSON qw(decode_json);
BEGIN { extends 'Catalyst::Controller::REST'; }

__PACKAGE__->config( default => 'application/json', );

sub base : Chained('/base') PathPart('poligono') CaptureArgs(0) {
  my ( $self, $c ) = @_;
}

sub estado : Chained('base') : PathPart('') : CaptureArgs(1) {
  my ( $self, $c, $uf ) = @_;
  $c->stash->{estado} = $c->model('DB::Map')->search( { sigla => $uf } );
}


sub estado_poligono : Chained('estado') : PathPart('') : Args(0) {
  my ( $self, $c ) = @_;
  my @polygons = $c->stash->{estado}->with_geojson->as_hashref->all;

  $c->stash->{estado} = $c->stash->{estado}->next;
  $self->status_ok(
    $c,
    entity => {
      type     => 'FeatureCollection',
      features => [
        map {
          +{
            type       => 'Feature',
            id         => 1,
            geometry   => decode_json $_->{geojson},
            properties => { name => $_->{nome_municipio} }
            }
          } @polygons
      ]
    }
  );
}

sub cidade_poligono : Chained('estado') : PathPart('') : Args(1) {
  my ( $self, $c, $city ) = @_;
  my $polygon =
    $c->stash->{estado}->next->maps->search( { nome_municipio => $city } )
    ->with_geojson->as_hashref->single;

  $self->status_ok(
    $c,
    entity => {
      type     => 'FeatureCollection',
      features => [
        {
          type       => 'Feature',
          id         => 1,
          geometry   => decode_json $polygon->{geojson},
          properties => { name => $polygon->{nome_municipio} }
        }
      ]
    }
  );

}

__PACKAGE__->meta->make_immutable;

1;

package Onde::Acontece::Controller::Poligono;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::REST'; }

__PACKAGE__->config(
  default => 'application/json',
);

sub base : Chained('/base') PathPart('poligono') CaptureArgs(0) {
  my ( $self, $c ) = @_;
}

sub estado : Chained('base') : PathPart('') : CaptureArgs(1) {
  my ( $self, $c, $uf ) = @_;
  $c->stash->{estado} = $c->model('DB::State')->search_rs( { uf => $uf } );
}

sub estado_poligono : Chained('estado') : PathPart('') : Args(0) {
  my ( $self, $c ) = @_;
  my $polygon = $c->stash->{estado}->as_hashref->with_geojson->all;
  $c->stash->{estado} = $c->stash->{estado}->next;
  $self->status_ok( $c, entity => { polygon => $polygon } );
}


sub cidade_poligono : Chained('estado') : PathPart('') : Args(1) {
  my ( $self, $c, $city ) = @_;
  my $polygon =
    $c->stash->{estado}->next->maps->search( { nome_municipio => $city } )
    ->with_geojson->as_hashref->single;
  $self->status_ok( $c, entity => { polygon => $polygon } );

}

__PACKAGE__->meta->make_immutable;

1;

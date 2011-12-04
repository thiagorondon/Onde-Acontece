package Onde::Acontece::Controller::Topico::Seguranca::Estado::Municipio;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub base : Chained('/topico/seguranca/estado/object') PathPart('') CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub object :Chained('base') :PathPart('') :CaptureArgs(1) {
  my($self, $c) = @_;
  $c->stash->{municipio} = $c->stash->{estado};
}

sub view :Chained('object') :PathPart('') :Args(0) {
  my($self, $c) = @_;
}


__PACKAGE__->meta->make_immutable;

1;

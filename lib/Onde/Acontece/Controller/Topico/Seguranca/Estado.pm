package Onde::Acontece::Controller::Topico::Seguranca::Estado;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub base : Chained('/topico/seguranca/base') PathPart('') CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub object :Chained('base') :PathPart('') :CaptureArgs(1) {
  my($self, $c, $uf) = @_;
  $c->stash->{estado} = $uf;
}

sub view :Chained('object') :PathPart('') :Args(0) {
  my($self, $c) = @_;
}


__PACKAGE__->meta->make_immutable;

1;

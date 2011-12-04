package Onde::Acontece::Controller::Topico;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub base : Chained('/base') PathPart('') CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub end :Action {
  my($self, $c) = @_;
  $c->forward('View::Topico');
}

__PACKAGE__->meta->make_immutable;

1;

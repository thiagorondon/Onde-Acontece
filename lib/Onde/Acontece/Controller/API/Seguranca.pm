package Onde::Acontece::Controller::API::Seguranca;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub base : Chained('/api/base') PathPart('seguranca') CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

__PACKAGE__->meta->make_immutable;

1;

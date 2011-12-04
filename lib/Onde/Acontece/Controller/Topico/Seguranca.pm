package Onde::Acontece::Controller::Topico::Seguranca;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub base : Chained('/topico/base') PathPart('seguranca') CaptureArgs(0) {
    my ( $self, $c ) = @_;
}

sub view: Chained('base') PathPart('') Args(0){
	my ( $self, $c ) = @_;
	
}

__PACKAGE__->meta->make_immutable;

1;

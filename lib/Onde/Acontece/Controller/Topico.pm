package Onde::Acontece::Controller::Topico;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub base : Chained('/base') PathPart('') CaptureArgs(1) {
    my ( $self, $c, $topico ) = @_;
    $c->stash->{topico} = $topico;
}

sub visao_geral : Chained('base') PathPart('') Args(0) {
}

sub estado_objeto : Chained('base') PathPart('') CaptureArgs(1) {
    my ( $self, $c, $uf ) = @_;
    $c->stash->{uf} = $uf;
}

sub estado : Chained('estado_objeto') PathPart('') Args(0) {
}

sub municipio_objeto : Chained('estado_objeto') PathPart('') CaptureArgs(1) {
    my ( $self, $c, $municipio ) = @_;
    $c->stash->{municipio} = $municipio;
}

sub municipio : Chained('municipio_objeto') PathPart('') Args(0) {
}

__PACKAGE__->meta->make_immutable;

1;

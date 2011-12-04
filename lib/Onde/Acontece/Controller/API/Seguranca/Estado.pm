package Onde::Acontece::Controller::API::Seguranca::Estado;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::REST'; }

sub base : Chained('/api/seguranca/base') PathPart('') CaptureArgs(0) {
  my ( $self, $c ) = @_;
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
  my ( $self, $c, $uf ) = @_;
  $c->stash->{estado} = $c->model('DB::State')->search( { 'me.uf' => $uf } )
    or $c->detach('/error_404');
}

sub view : Chained('object') : PathPart('') : Args(0) ActionClass('REST') {
  my ( $self, $c ) = @_;
}

sub view_GET {
  my ( $self, $c ) = @_;
  my $state = $c->stash->{estado}->search(
    { },
    { prefetch => { municipios => 'ocorrencias_municipio' },
      order_by     => [qw(ocorrencias_municipio.ano)],
      result_class => 'DBIx::Class::ResultClass::HashRefInflator'
    }
  );

  $self->status_ok( $c => entity => [ $state->all ] );
}

__PACKAGE__->meta->make_immutable;

1;

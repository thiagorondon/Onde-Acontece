package Onde::Acontece::Controller::Topico::Seguranca::Estado::Municipio;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

sub base : Chained('/topico/seguranca/estado/object') PathPart('')
  CaptureArgs(0) {
  my ( $self, $c ) = @_;
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
  my ( $self, $c, $nome ) = @_;
  $c->stash->{municipio} = $c->stash->{estado};
  $c->stash->{object} =
    $c->stash->{estado}->related_resultset('municipios')
    ->search( { nome => $nome } )->single;
}

sub view : Chained('object') : PathPart('') : Args(0) {
  my ( $self, $c ) = @_;
  my $m = $c->stash->{estado}->related_resultset('municipios')->search(
    {
      'municipios.nome' => $c->stash->{object}->nome,
      tipo              => { -not => undef }
    },
    {
      select => [
        qw(municipios.nome ocorrencia.tipo ocorrencias_municipio.ano ocorrencias_municipio.quant)
      ],
      as   => [qw(nome tipo ano quant)],
      join => { ocorrencias_municipio => 'ocorrencia' },
      order_by =>
        [qw(ocorrencias_municipio.ano ocorrencia.tipo municipios.nome )],
    }
  );
  my %mun;
  for my $r ( $m->all ) {
    push @{ $mun{ $r->get_column('nome') }{ $r->get_column('tipo') } },
      [ $r->get_column('ano'), $r->get_column('quant') ];
  }

  $c->stash->{mun} = \%mun;
}

__PACKAGE__->meta->make_immutable;

1;

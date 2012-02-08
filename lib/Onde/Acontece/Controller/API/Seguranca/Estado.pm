package Onde::Acontece::Controller::API::Seguranca::Estado;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::REST'; }
use JSON;
use Devel::Peek;

sub base : Chained('/api/seguranca/base') PathPart('') CaptureArgs(0) {
  my ( $self, $c ) = @_;
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
  my ( $self, $c, $uf ) = @_;
  $c->stash->{estado} = $c->stash->{object} =
       $c->model('DB::State')->search( { 'me.uf' => $uf } )
    or $c->detach('/error_404');
}

sub view : Chained('object') : PathPart('') : Args(0) ActionClass('REST') {
  my ( $self, $c ) = @_;
}

sub view_GET {
  my ( $self, $c ) = @_;
  my $o_id  = $c->req->query_parameters->{o_id};
  my $ano   = $c->req->query_parameters->{ano};
  my $state = $c->stash->{estado}->related_resultset('municipios')->search(
    { 'ocorrencia.id'             => $o_id,
      'ocorrencias_municipio.ano' => $ano,
      'municipio_censo.descricao' => 'População residente '
    },
    { '+select' => [
        \'st_asgeojson(municipios.the_geom)',
        \'CASE WHEN (municipio_censo.valor > 0)
          THEN ocorrencias_municipio.quant/municipio_censo.valor * 100
          ELSE 0
          END'
      ],
      '+as' => [ 'geojson', 'quant' ],
      prefetch =>
        [ { 'ocorrencias_municipio' => 'ocorrencia' }, 'municipio_censo' ],
      order_by     => [qw(ocorrencias_municipio.ano)],
      result_class => 'DBIx::Class::ResultClass::HashRefInflator'
    }
  );

  #  $self->status_ok($c => entity => [$state->all]);

  $self->status_ok(
    $c,
    entity => {
      type     => 'FeatureCollection',
      features => [
        map {
          +{type       => 'Feature',
            id         => $_->{ocorrencias_municipio}[0]{municipio_id},
            geometry   => decode_json( $_->{geojson} ),
            properties => {
              name  => $_->{nome},
              quant => $_->{quant}
            }
            }
          } $state->all
      ]
    }
  );

}

sub municipio_info : Chained('object') : PathPart('') : Arg(1) {
  my ( $self, $c, $nome ) = @_;
  my $m = $c->stash->{object}->related_resultset('municipios')->search(
    { tipo              => { -not => undef },
      'ocorrencias_municipio.ano' => { '<=' => ($c->req->params->{until} || 2010 ) },
      'municipios.nome' => $nome
    },
    { select => [
        qw(municipios.nome ocorrencia.tipo ocorrencia.nome ocorrencias_municipio.ano ocorrencias_municipio.quant)
      ],
      as =>
        [qw(nome ocorrencia.tipo ocorrencia.nome_oco ano ocorrencia.quant)],
      join => { ocorrencias_municipio => 'ocorrencia' },
      order_by =>
        [qw(ocorrencias_municipio.ano ocorrencia.tipo municipios.nome )],
      result_class => 'DBIx::Class::ResultClass::HashRefInflator'
    }
  );

  my %mun;
  for my $r ( $m->all ) {

    $mun{ $r->{ocorrencia}{tipo} }{label} ||= $r->{ocorrencia}{nome_oco};

    push @{ $mun{ $r->{ocorrencia}{tipo} }{data} },
      [ $r->{ano}, $r->{ocorrencia}{quant} ];
  }

  # warn Devel::Peek::Dump(($m->all)[0]->{ocorrencia}{nome_oco});

  $self->status_ok( $c, entity => { ocorrencias => \%mun } );

}
__PACKAGE__->meta->make_immutable;

1;

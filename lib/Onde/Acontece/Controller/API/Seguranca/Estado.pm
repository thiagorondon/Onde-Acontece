package Onde::Acontece::Controller::API::Seguranca::Estado;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::REST'; }
use JSON;

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
    { 'ocorrencia.id' => $o_id, 'ocorrencias_municipio.ano' => $ano },
    {
      '+select'    => [ \'st_asgeojson(municipios.the_geom)' ],
      '+as'        => ['geojson'],
      prefetch     => [ { 'ocorrencias_municipio' => 'ocorrencia' } ],
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
          +{
            type       => 'Feature',
            id         => $_->{ocorrencias_municipio}[0]{municipio_id},
            geometry   => decode_json( $_->{geojson} ),
            properties => {
              name  => $_->{nome},
              quant => $_->{ocorrencias_municipio}[0]{quant}
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
    {
      tipo                        => { -not => undef },
      'municipios.nome'           => $nome,
      'ocorrencias_municipio.ano' => $c->req->params->{ano}
    },
    {
      select => [
        qw(municipios.nome ocorrencia.tipo ocorrencias_municipio.ano ocorrencias_municipio.quant)
      ],
      as   => [qw(nome ocorrencia.tipo ano ocorrencia.quant)],
     join => { ocorrencias_municipio => 'ocorrencia' },
      order_by =>
        [qw(ocorrencias_municipio.ano ocorrencia.tipo municipios.nome )],
      result_class => 'DBIx::Class::ResultClass::HashRefInflator'
    }
  );
  my %mun;
  # for my $r ( $m->all ) {
  #   push @{ $mun{ $r->{nome} }{ $r->{tipo} } }, [ $r->{ano}, $r->{quant} ];
  # }

  $self->status_ok( $c, entity => { municipio => [$m->all] } );

}
__PACKAGE__->meta->make_immutable;

1;

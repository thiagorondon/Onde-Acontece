package Onde::Acontece::Controller::API::Seguranca::Estado::Ano;
use Moose;
BEGIN { extends 'Catalyst::Controller::REST' }

sub base : Chained('/') PathPart('seguranca/estado/anual') CaptureArgs(0) {
  my ( $self, $c ) = @_;
  $c->stash->{collection} = $c->model('DB::MunicipioRateAno');
}

sub root : Chained('base') Args(0) PathPart('') :ActionClass('REST') { }

sub root_GET {
  my ( $self, $c ) = @_;

  my $col = $c->stash->{collection};

  my $uf = $c->req->query_parameters->{uf};

  #  $c->model('DB::State')->search( { 'me.uf' => $uf } )->count
  #    or $c->detach('/error404');
  my $ano = $c->req->query_parameters->{ano};
  my $oc  = $c->req->query_parameters->{oc};

  $c->detach('/error404')
    unless !( $oc =~ /^(municipio|ano)$/ )
    and $col->result_source->has_column($oc);

  my $rows = $c->stash->{collection}->search_rs(
    {},
    { select => [ 'municipio', $oc, "rate_$oc" ],
      result_class => 'DBIx::Class::ResultClass::HashRefInflator'
    }
  );
  my $count = $rows->count;
  my $table =
    [ map { [ @{$_}{ 'municipio', $oc, "rate_$oc" } ] } $rows->all ];
  my $data = {
    aaData               => $table,
    iTotalRecords        => $count,
    iTotalDisplayRecords => $count,
    sEcho                => 0
  };
  $self->status_ok( $c, entity => $data );
}

1;

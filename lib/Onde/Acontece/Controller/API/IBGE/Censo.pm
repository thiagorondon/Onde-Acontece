package Onde::Acontece::Controller::API::IBGE::Censo;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller::REST'; }
use JSON;

sub base : Chained('/api/ibge/base') PathPart('censo') CaptureArgs(0) {
  my ( $self, $c ) = @_;
}

sub object : Chained('base') : PathPart('') : CaptureArgs(1) {
  my ( $self, $c, $cidade ) = @_;
  $c->stash->{object} =
       $c->model('DB::Raw::IBGE::Censo')->search( { 'me.cidade' => $cidade },
        { result_class => 'DBIx::Class::ResultClass::HashRefInflator' } )
    or $c->detach('/error_404');
}

sub view : Chained('object') : PathPart('') : Args(0) ActionClass('REST') {
  my ( $self, $c ) = @_;
}

sub view_GET {
  my ( $self, $c ) = @_;
  if($c->req->query_parameters->{download}) {
    my $filename = $c->stash->{object}->search({})->first->{cidade};
    for($c->req->content_type || $c->req->params->{'content-type'}) {
      /json/ and $filename .= '.json' or
      /xml/ and $filename .= '.xml' or
      /ya?ml/ and $filename .= '.yml'
    }
    $c->res->header('Content-Disposition', qq[attachment; filename="$filename"]);
  }
  $self->status_ok(
    $c,
    entity => {
      type     => 'FeatureCollection',
      features => [
        map {
          +{type       => 'Feature',
            properties => {
              descricao  => $_->{descricao},
              unidade    => $_->{unidade},
              valor      => $_->{valor}
            }
            }
          } $c->stash->{object}->all
      ]
    }
  );

}

__PACKAGE__->meta->make_immutable;

1;

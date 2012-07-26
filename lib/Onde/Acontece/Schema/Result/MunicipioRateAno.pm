use utf8;
package Onde::Acontece::Schema::Result::MunicipioRateAno;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Onde::Acontece::Schema::Result::MunicipioRateAno

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<municipio_rate_ano>

=cut

__PACKAGE__->table("municipio_rate_ano");

=head1 ACCESSORS

=head2 municipio

  data_type: 'text'
  is_nullable: 0

=head2 homicidio

  data_type: 'text'
  is_nullable: 0

=head2 furtos_veiculo

  data_type: 'text'
  is_nullable: 0

=head2 furtos

  data_type: 'text'
  is_nullable: 0

=head2 roubos

  data_type: 'text'
  is_nullable: 0

=head2 latrocionio

  data_type: 'text'
  is_nullable: 0

=head2 roubo_veiculo

  data_type: 'text'
  is_nullable: 0

=head2 extorsao

  data_type: 'text'
  is_nullable: 0

=head2 extorsao_sequesto

  data_type: 'text'
  is_nullable: 0

=head2 estelionato

  data_type: 'text'
  is_nullable: 0

=head2 delitos_corrupcao

  data_type: 'text'
  is_nullable: 0

=head2 posse_entorpecente

  data_type: 'text'
  is_nullable: 0

=head2 delitos_municoes

  data_type: 'text'
  is_nullable: 0

=head2 trafico_entorpecente

  data_type: 'text'
  is_nullable: 0

=head2 populacao

  data_type: 'integer'
  is_nullable: 1

=head2 rate_homicidio

  data_type: 'double precision'
  is_nullable: 0

=head2 rate_furtos_veiculo

  data_type: 'double precision'
  is_nullable: 0

=head2 rate_furtos

  data_type: 'double precision'
  is_nullable: 0

=head2 rate_roubos

  data_type: 'double precision'
  is_nullable: 0

=head2 rate_latrocionio

  data_type: 'double precision'
  is_nullable: 0

=head2 rate_roubo_veiculo

  data_type: 'double precision'
  is_nullable: 0

=head2 rate_extorsao

  data_type: 'double precision'
  is_nullable: 0

=head2 rate_extorsao_sequesto

  data_type: 'double precision'
  is_nullable: 0

=head2 rate_estelionato

  data_type: 'double precision'
  is_nullable: 0

=head2 rate_delitos_corrupcao

  data_type: 'double precision'
  is_nullable: 0

=head2 rate_posse_entorpecente

  data_type: 'double precision'
  is_nullable: 0

=head2 rate_delitos_municoes

  data_type: 'double precision'
  is_nullable: 0

=head2 rate_trafico_entorpecente

  data_type: 'double precision'
  is_nullable: 0

=head2 ano

  data_type: 'integer'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "municipio",
  { data_type => "text", is_nullable => 0 },
  "homicidio",
  { data_type => "text", is_nullable => 0 },
  "furtos_veiculo",
  { data_type => "text", is_nullable => 0 },
  "furtos",
  { data_type => "text", is_nullable => 0 },
  "roubos",
  { data_type => "text", is_nullable => 0 },
  "latrocionio",
  { data_type => "text", is_nullable => 0 },
  "roubo_veiculo",
  { data_type => "text", is_nullable => 0 },
  "extorsao",
  { data_type => "text", is_nullable => 0 },
  "extorsao_sequesto",
  { data_type => "text", is_nullable => 0 },
  "estelionato",
  { data_type => "text", is_nullable => 0 },
  "delitos_corrupcao",
  { data_type => "text", is_nullable => 0 },
  "posse_entorpecente",
  { data_type => "text", is_nullable => 0 },
  "delitos_municoes",
  { data_type => "text", is_nullable => 0 },
  "trafico_entorpecente",
  { data_type => "text", is_nullable => 0 },
  "populacao",
  { data_type => "integer", is_nullable => 1 },
  "rate_homicidio",
  { data_type => "double precision", is_nullable => 0 },
  "rate_furtos_veiculo",
  { data_type => "double precision", is_nullable => 0 },
  "rate_furtos",
  { data_type => "double precision", is_nullable => 0 },
  "rate_roubos",
  { data_type => "double precision", is_nullable => 0 },
  "rate_latrocionio",
  { data_type => "double precision", is_nullable => 0 },
  "rate_roubo_veiculo",
  { data_type => "double precision", is_nullable => 0 },
  "rate_extorsao",
  { data_type => "double precision", is_nullable => 0 },
  "rate_extorsao_sequesto",
  { data_type => "double precision", is_nullable => 0 },
  "rate_estelionato",
  { data_type => "double precision", is_nullable => 0 },
  "rate_delitos_corrupcao",
  { data_type => "double precision", is_nullable => 0 },
  "rate_posse_entorpecente",
  { data_type => "double precision", is_nullable => 0 },
  "rate_delitos_municoes",
  { data_type => "double precision", is_nullable => 0 },
  "rate_trafico_entorpecente",
  { data_type => "double precision", is_nullable => 0 },
  "ano",
  { data_type => "integer", is_nullable => 1 },
);

=head1 UNIQUE CONSTRAINTS

=head2 C<municipio_rate_ano_municipio_ano_idx>

=over 4

=item * L</municipio>

=item * L</ano>

=back

=cut

__PACKAGE__->add_unique_constraint("municipio_rate_ano_municipio_ano_idx", ["municipio", "ano"]);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-07-26 16:31:29
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:S8emW3n+tofinVgBEUStZQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;

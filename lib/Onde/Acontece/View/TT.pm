package Onde::Acontece::View::TT;

use strict;
use warnings;

use base 'Catalyst::View::TT';

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
);

=head1 NAME

Onde::Acontece::View::TT - TT View for Onde::Acontece

=head1 DESCRIPTION

TT View for Onde::Acontece.

=head1 SEE ALSO

L<Onde::Acontece>

=head1 AUTHOR

Thiago Rondon

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;

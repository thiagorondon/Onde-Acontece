use strict;
use warnings;
use lib qw/lib/;
use Onde::Acontece;

my $app = Onde::Acontece->apply_default_middlewares(Onde::Acontece->psgi_app);
$app;


use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Onde::Acontece';

ok( request('/poligono/RS')->is_success, 'Request should succeed' );
ok( request('/poligono/RS/Feliz')->is_success, 'Request should succeed' );

done_testing();

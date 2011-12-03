use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Onde::Acontece';
use Onde::Acontece::Controller::Topico;

ok( request('/topico')->is_success, 'Request should succeed' );
done_testing();

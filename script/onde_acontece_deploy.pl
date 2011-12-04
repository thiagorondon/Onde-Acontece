#!/usr/bin/perl

use FindBin qw($Bin);
use lib "$Bin/../lib";
use Onde::Acontece::Schema;

my $schema = Onde::Acontece::Schema->connect('dbi:SQLite:dbname=tmp/dbtest.db');

$schema->deploy;


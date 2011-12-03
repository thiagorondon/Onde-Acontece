#!perl

use strict;
use WWW::Mechanize;

open my $fh_city, "<cidades.txt";

my $i=0;

use LWP::Simple qw/getprint getstore/;

while( my $line_city = <$fh_city> ) {

    chomp $line_city;
    my ($nm_city, $id_city) = split /\|/, $line_city;
    
    my $url =
        "http://www.ibge.gov.br/cidadesat/xtras/csv.php?tabela=sintese&codmun=${id_city}&nomemun=${nm_city}";

    getstore( $url, "data/$nm_city.csv" );
    
    $i++; print STDOUT $i, " - $id_city\n";
}



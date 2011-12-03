#!perl

use strict;
use Text::CSV_XS;
use Data::Printer;

my @fh_out;
my @csv = glob('./data/*');

my $_csv = Text::CSV_XS->new ( { binary => 1 } );

open my $FH_OUT, '>:encoding(ISO-8859-1)', 'cidades_full.csv';
print $FH_OUT "Cidade;Descricao;Unidade;Valor\n";

for my $csv_city (@csv) {
    
    open my $FH, "<:encoding(ISO-8859-1)", $csv_city or die "${csv_city}: $!";

    my $header = 0;

    $csv_city =~ s/\.\/data\///g;
    while(my $row = $_csv->getline($FH)) {

	if ($header == 0 && $row->[0] !~ /Descri..o,Valor,Unidade/) { $header = 1; next };
	next if $header == 0 || $row->[0] =~ /Fonte:IBGE/ || $row->[0] !~ /[a-z]{3}/i;

        print $FH_OUT "${csv_city};$row->[0];$row->[2];$row->[1]\n";
	print STDOUT "$csv_city, $row->[0]\n";

    }

}


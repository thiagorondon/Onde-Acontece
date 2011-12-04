#!perl

use strict;
use Encode;
use Text::CSV_XS;
use Data::Printer;

my @fh_out;
my @csv = glob('./data/*');

my $_csv = Text::CSV_XS->new ( { binary => 1 } );

open my $FH_OUT, '>:utf8', 'cidades_full.csv';
print $FH_OUT "Cidade;Descricao;Unidade;Valor\n";

for my $csv_city (@csv) {
    
    open my $FH, "<:encoding(ISO-8859-1)", $csv_city or die "${csv_city}: $!";

    my $header = 0;

    $csv_city =~ s/\.\/data\///g;
    $csv_city = decode_utf8( $csv_city );

    while(my $row = $_csv->getline($FH)) {

        my $desc = $row->[0];
        my $val  = $row->[1];
        my $unid = $row->[2];

	if ($header == 0 && $desc =~ /^Descri..o$/ ) { $header = 1; next }
	next if $header == 0 || $desc =~ /Fonte:IBGE/ || $desc !~ /[a-z]{3}/i;

        print $FH_OUT "${csv_city};$desc;$unid;$val\n";
	print STDOUT "$csv_city, $row->[0]\n";

    }

}


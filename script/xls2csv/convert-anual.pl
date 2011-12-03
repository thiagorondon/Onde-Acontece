#!/usr/bin/perl -w

use strict;
use Spreadsheet::ParseExcel;

my $parser   = Spreadsheet::ParseExcel->new();
my $workbook = $parser->parse($ARGV[0]);

if ( !defined $workbook ) {
	die $parser->error(), ".\n";
}

my %expected_header = (
	indicador => qr /\bindicadores\b/io,
	homicidio  => qr /\bhomic.dio\b/io,
	furtos_veiculo => qr /\bfurtos\sde\sve.culo\*$/io,
	furtos => qr /\bfurtos\s*$/io,
	roubos => qr /\broubos\b/io,
	latrocionio => qr /\blatroc.nio\b/io,
	roubo_veiculo => qr /\broubo.+ve\b/io,
	extorsao => qr /\bextors.o\b/io,
);

# apenas para exibir
my $reg_num        = 0;
use DDP;
for my $worksheet ( $workbook->worksheets() ) {
	
    my $name = $worksheet->get_name();
	next unless $name =~ /indicadores/i;

	my ( $row_min, $row_max ) = $worksheet->row_range();
	my ( $col_min, $col_max ) = $worksheet->col_range();

	my $header_map     = {};
	my $header_found   = 0;

	for my $row ( $row_min .. $row_max ) {

		if (!$header_found){
			for my $col ( $col_min .. $col_max ) {
				my $cell = $worksheet->get_cell( $row, $col );
				next unless $cell;
p %expected_header;
				foreach my $header_name (keys %expected_header){
					if ($cell->value() =~ $expected_header{$header_name}){
						$header_found++;
						# mais informações poderia ser salvas, como por exemplo
						# qual é o valor que está escrito e bateu com a regexpr

						$header_map->{$header_name} = $col;
p $header_map;
					}
				}
			}
		}else{
			my $registro = {};

			foreach my $header_name (keys %$header_map){
				my $col = $header_map->{$header_name};

				my $cell = $worksheet->get_cell( $row, $col );
				next unless $cell;

				my $value = $cell->value();

				# aqui é uma regra que você escolhe, pois as vezes o valor da célula pode ser nulo
				next unless $value;

				$registro->{$header_name} = $value;
			}

			# se existe alguma chave, algum conteudo foi encontrado
			if (keys %$registro){
				$reg_num++;
				print "row $row, registro $reg_num\n";
				print "$_ = $registro->{$_}\n" for keys %$registro;
				print "------------------\n";
				last;
			}

			print "$reg_num\n";

			
		}

	}

}
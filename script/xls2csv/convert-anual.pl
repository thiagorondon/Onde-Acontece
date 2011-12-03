#!/usr/bin/perl -w

use strict;
use Spreadsheet::ParseExcel;
use utf8;

use Text::CSV;
my $parser   = Spreadsheet::ParseExcel->new();
my $workbook = $parser->parse($ARGV[0]);

if ( !defined $workbook ) {
	die $parser->error(), ".\n";
}
=pod
MUNICÍPIOS  / INDICADORES
Homicídio
Furtos
Furto de veículo
Roubos
Latrocínio
Roubo de veículo
Extorsão
Extorsão mediante sequestro
Estelionato
Delitos relac. à corrupção
Delitos relac. a armas e munições
Entorp. Posse
Entorp. Tráfico
=cut
my %expected_header = (
	indicador => qr /MUNIC.PIOS\s+\/\s+INDICADORES/io,
	homicidio  => qr /homic.dio/io,
	furtos_veiculo => qr /Furto de veículo\s*$/io,
	furtos => qr /\bfurtos\s*$/io,
	roubos => qr /\broubos\b/io,
	latrocionio => qr /Latrocínio/io,
	roubo_veiculo => qr /\broubo.+ve\b/io,
	extorsao => qr /Extorsão$/io,
	extorsao_sequesto => qr /extors.o mediante sequestro/io,
	estelionato => qr /estelionato/io,
	delitos_corrupcao => qr /Delitos relac. à corrupção/io,
	delitos_municoes     => qr /Delitos relac. a armas e munições/io,
	posse_entorpecente   => qr /entorp\. posse/io,
	trafico_entorpecente => qr /entorp\. tr.fico/io,
);

my $csv = Text::CSV->new ( { binary => 1 } )  # should set binary attribute.
				or die "Cannot use CSV: ".Text::CSV->error_diag ();

my $out_file = $ARGV[0];
$out_file =~ s/xls/csv/g;

open my $fh, ">:encoding(utf8)", $out_file or die "$out_file: $!";

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

				foreach my $header_name (keys %expected_header){
					if ($cell->value() =~ $expected_header{$header_name}){
						$header_found++;
						# mais informações poderia ser salvas, como por exemplo
						# qual é o valor que está escrito e bateu com a regexpr

						$header_map->{$header_name} = $col;
						$header_map->{$header_name} = $col + 1 if ($header_name eq 'indicador'); # mais 1 porque o indicadores está mesclado
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
				next unless defined $value;
				$value =~ s/\,//g;

				next if ($header_name eq 'indicador' && $value =~ $expected_header{indicador} );

				$registro->{$header_name} = $value;
			}

			# se existe alguma chave, algum conteudo foi encontrado
			if (keys %$registro > 3){
				$reg_num++;
				#print "row $row, registro $reg_num\n";
				#print "$_ = $registro->{$_}\n" for keys %$registro;
				#print "------------------\n";
				my $item = [];
				push(@$item, $registro->{$_}) for keys %$registro;
				$csv->print ($fh, $item);
			}

		}

	}

}
close $fh or die "$out_file: $!";

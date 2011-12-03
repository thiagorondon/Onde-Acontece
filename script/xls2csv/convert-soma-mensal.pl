#!/usr/bin/perl -w

use strict;
use Spreadsheet::ParseExcel;
use utf8;
use File::Basename;


use Text::CSV;
my $parser   = Spreadsheet::ParseExcel->new();
=pod
Municípios
Homicidio
Furtos
Furto de veículo
Roubos
Latrocínio
Roubo de veículo
Extorsão
Extorsão mediante sequestro
Estelionato
Delitos relacionados à corrupçao
Delitos relacionados a armas e muniçoes
Entorpecentes - Posse
Entorpecentes - Tráfico
=cut
my %expected_header = (
	municipio => qr /MUNIC.PIOS/io,
	homicidio  => qr /homic.dio/io,
	furtos_veiculo => qr /Furto de veículo\s*$/io,
	furtos => qr /\bfurtos\s*$/io,
	roubos => qr /\broubos\b/io,
	latrocionio => qr /Latrocínio/io,
	roubo_veiculo => qr /\broubo.+ve\b/io,
	extorsao => qr /Extorsão$/io,
	extorsao_sequesto => qr /extors.o mediante sequestro/io,
	estelionato => qr /estelionato/io,
	delitos_corrupcao => qr /Delitos relacionados à corrupçao/io,
	delitos_municoes     => qr /Delitos relacionados a armas e muniçoes/io,
	posse_entorpecente   => qr /entorp.+ posse/io,
	trafico_entorpecente => qr /entorp.+ tr.fico/io,
);
my @ordem_colunas = qw /municipio homicidio furtos_veiculo furtos roubos latrocionio roubo_veiculo
extorsao extorsao_sequesto estelionato delitos_corrupcao posse_entorpecente delitos_municoes trafico_entorpecente ano/;

my $csv = Text::CSV->new ( { binary => 1,eol => $/  } )  # should set binary attribute.
				or die "Cannot use CSV: ".Text::CSV->error_diag ();

my($ano) = $ARGV[0] =~ /_(\d{4})__/;

my $out_file = "../../data-transform/xls2csv/ano-$ano.csv";
use DDP;
print "parsing $ARGV[0]\n";

# apenas para exibir
my $reg_num        = 0;

my $workbook = $parser->parse($ARGV[0]);

if ( !defined $workbook ) {
	die $parser->error(), ".\n";
}

my $data = {
	# <municipio> => {
	# 		<column> => $sum
	# }
};
for my $worksheet ( $workbook->worksheets() ) {

    my $name = $worksheet->get_name();
print "working on $name\n";

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
						
					}
				}
			}
		}else{
			my $registro = {};
			my $abort = 0;
			foreach my $header_name (keys %$header_map){
				my $col = $header_map->{$header_name};

				my $cell = $worksheet->get_cell( $row, $col );
				next unless $cell;

				my $value = $cell->value();

				# aqui é uma regra que você escolhe, pois as vezes o valor da célula pode ser nulo
				next unless defined $value;
				$value =~ s/\,//g;

				if (($header_name eq 'delitos_corrupcao' && $value =~ $expected_header{delitos_corrupcao}) ||
						($value =~ /RS/ && $header_name eq 'municipio' )
					){
					$abort = 1; last;
				}
				$registro->{$header_name} = $value;
			}
			next if $abort;

			# se existe alguma chave, algum conteudo foi encontrado
			if (keys %$registro > 3){
				$reg_num++;

				next unless $registro->{municipio};
				
				$registro->{municipio} = uc $registro->{municipio};

				for (@ordem_colunas ){
					next if $_ eq 'municipio';
					next unless $registro->{$_};
					next if $registro->{$_} && $registro->{$_} !~ /^[0-9]+$/o;
					$data->{$registro->{municipio}}{$_} ||= 0;
					$data->{$registro->{municipio}}{$_} += $registro->{$_};
					
				}
				$data->{$registro->{municipio}}{ano} = $ano;
			}
		}
	}

}

open my $fh, ">:encoding(utf8)", $out_file or die "$out_file: $!";
$csv->print ($fh, \@ordem_colunas);
print "writing on $out_file\n";

foreach my $municipio(sort keys %$data){

	my $item = $data->{$municipio};

	my $csvarr = [];
	$item->{municipio} = $municipio;
	foreach (@ordem_colunas ){
		$item->{$_} ||= 0;
		push(@$csvarr, $item->{$_});
	}
	$csv->print ($fh, $csvarr);

}

close $fh or die "$out_file: $!";
print "done!\n";

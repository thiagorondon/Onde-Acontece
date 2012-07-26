use warnings;
use strict;
use String::TT qw(tt);

my $delitos = [
  qw(homicidio
    furtos_veiculo
    furtos
    roubos
    latrocionio
    roubo_veiculo
    extorsao
    extorsao_sequesto
    estelionato
    delitos_corrupcao
    posse_entorpecente
    delitos_municoes
    trafico_entorpecente)
];
my $proporcao = 100000;
my $sqltt = <<SQL;
DROP TABLE IF EXISTS municipio_rate_ano;
CREATE TABLE municipio_rate_ano (
  municipio TEXT NOT NULL,
  [%- FOREACH delito IN delitos -%]
    [% delito -%] TEXT NOT NULL,
  [%- END -%]
  populacao INT,
  [%- FOREACH delito IN delitos -%]
    rate_[% delito -%] FLOAT NOT NULL,
  [%- END -%]
  ano INT
);
CREATE UNIQUE INDEX ON municipio_rate_ano (municipio, ano);
CREATE INDEX ON municipio_rate_ano (ano);
INSERT INTO municipio_rate_ano (
municipio,
   [%- FOREACH delito IN delitos -%]
     [% delito -%],
   [%- END -%]
populacao,
   [%- FOREACH delito IN delitos -%]
     rate_[% delito -%],
   [%- END -%]
ano )
SELECT mits.nome_ibge,
       [%- FOREACH delito IN delitos -%]
         rism.[% delito -%],
       [%- END -%]
       ric.valor as populacao,
       [%- FOREACH delito IN delitos -%]
         (rism.[% delito %]/ric.valor) * [% proporcao -%]
           AS rate_[% delito -%],
       [%- END %]
       rism.ano
 FROM municipio_ibge_to_ssprs mits
 JOIN raw_indicadores_ssprs_municipioss rism
   ON rism.municipio = mits.nome_ssprs
 JOIN raw_ibge_censo ric
   ON ric.cidade = mits.nome_ibge
WHERE ric.descricao ~ 'População residente\\s+\$'
GROUP BY mits.nome_ibge,
      [%- FOREACH delito IN delitos -%]
        rism.[% delito %],
      [%- END -%]
      rism.ano,
      rism.homicidio,
      ric.valor
ORDER BY
      [%- FOREACH delito IN delitos -%]
        rate_[% delito %],
      [%- END -%]
      mits.nome_ibge, rism.ano;
SQL
print( tt $sqltt );

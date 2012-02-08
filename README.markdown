
Onde Acontece ?
===============

http://www.ondeacontece.com.br/

Este projeto foi desenvolvido durante o evento "Desarrolando America" pela comunidade "São Paulo Perl Mongers" e Opendata-BR".

Descrição da Idéia
------------------

Estimular a divulgação de dados sobre segurança pública dos estados, município e do país para permitir a comparação entre regiões através da análise de índices de ocorrência de crimes. Demonstrar esses dados na forma de mapas e gráficos irá permitir que a sociedade tire conclusões e encontre soluções para o problema da segurança. Esse jornalismo de dados deverá pressionar o estado a divulgar mais informação sobre segurança e a população a endereçar os problemas.

Prevemos a criação de 3 telas, uma para a visualização geral de regiões, outra com o detalhamento de regiões específicas e uma para demonstrar o "ranking" das regiões nos diversos tipos de ocorrências.

Fontes de Dados
---------------

Utilizamos os dados provenientes do IBGE (Instituto Brasileiro de Geografia e Estatística) contendo os polígonos dos mapas e informações de georeferenciamento, além dos dados do censo. Os dados do IBGE serão cruzados com dados fornecidos pela SSP (Secretaria de Segurança Pública) do estado do Rio Grande do Sul contendo as ocorrências relatadas nos call centers de Porto Alegre e dados gerais de ocorrências nas cidades do interior do estado. A princípio, apenas os dados do Rio Grande do Sul estarão disponíveis, mas acreditamos que quando a aplicação estiver funcionando, outros estados serão pressionados a divulgar seus dados também.

 * http://www.ibge.gov.br/cidadesat/link.php?uf=rs
 * http://www.ssp.rs.gov.br/
 * ftp://geoftp.ibge.gov.br/mapas/malhas_digitais/
 * http://mapicons.nicolasmollet.com/

INSTALAÇÃO RÁPIDA
-----------------

Esta instalação é baseada no Debian. O primeiro passo é:

* Instalar o postgreSQL.
* Instalar o PostGIS.
* Criar permissões para o usuário 'ondeacontece' local.
* Criar um banco de dados 'ondeacontece' com permissão para o usuário 'ondeacontece'.

Feito isto, basta executar os comandos abaixo.

    $ echo "deb ftp://ftp.br.debian.org/debian/ squeeze main contrib non-free" >> /etc/apt/sources.list
    $ apt-get update
    $ apt-get install curl build-essential git-core
    $ useradd ondeacontece -m 
    $ su - ondeacontece
    $ curl -kL http://install.perlbrew.pl | bash
    $ source ~/perl5/perlbrew/etc/bashrc
    $ perlbrew install perl-5.12.2
    $ perlbrew switch perl-5.12.2
    $ perlbrew install-cpanm
    $ cpanm Dist::Zilla
    $ git clone git://github.com/maluco/Onde-Acontece.git
    $ cd Onde-Acontece
    $ dzil listdeps | cpanm
    $ ./deploydb.sh

EXECUTAR
--------

Para testar o aplicativo, basta executar:

    $ scripts/onde_acontece.server.pl

TODO
----

* Linkar os dados do CENSO no site, para criar métricas.
* Definir icones que serão utilizadas para esta métrica.
* Resolver o problema de enconding e do nome do tipo do crime.
* Melhorar a navegabilidade e o entedimento, adicionar um texto explicado de como utilizar o site, e o que pode ser retirado dele.
* Oferecer um mecanismo de download do site atual, em JSON, TXT ou CSV.
* Adicionar/Revisar libs que estão faltando no dist.ini (eg. XML::Simple)






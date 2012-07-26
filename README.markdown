
Onde Acontece ?
===============

http://www.ondeacontece.com.br/

Este projeto foi desenvolvido durante o evento "Desarrolando America" pela comunidade "São Paulo Perl Mongers" e "Opendata-BR".

Durante o FISL13 foi implementado o sistema de rank baseado na cidade e tipo de crime, além de ser apresentando uma maneira simples do projeto ser reutilizado baseado em uma documentação e uma distribuição no próprio site de um pacote .tar.gz.

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
 * http://www.acessoainformacao.rs.gov.br.

Tecnologias utilizadas
----------------------

Perl
----

Perl é uma linguagem de programação com mais de 25 anos de desenvolvimento,
portável para mais de 100 plataformas diferentes( de dispositivos portáteis a
mainframes). É uma linguagem multi-paradigma e suporta orientação a objetos,
programação funcional e procedural. Com mais de 21,000 módulos extensivamente
testados e disponíveis em sua biblioteca on-line, o CPAN.

Perl inclui suporte a poderosas ferramentas de manipulação de texto, imagens,
integração com banco de dados e desenvolvimento web. Os módulos desenvolvidos
em perl são projetados para permitir e encorajar o reuso, o que facilita o
nivelamento da lógica de negócio através de diversas plataformas, sejam elas
aplicações web, scripts e todo tipo de componentes de integração. Um exemplo
são as bibliotecas de interação com bancos de dados, que provêem a integração
com quase todas os bancos de dados existentes junto com uma camada de
abstração que possibilita a troca de banco de dados sem a necessidade de
reescrever código.

Postgis
-------

PostGIS é uma extensão que adiciona ao PostgrSQL suporte a objetos geográficos
e operações geoespaciais. É possível, por exemplo, determinar operações e
medidas como distância, área, perímetro com base nos dados geoespaciais
disponíveis.


Instalação rápida
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

Executar
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






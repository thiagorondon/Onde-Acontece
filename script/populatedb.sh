for i in data-transform/xls2csv/ano-*.csv; do psql -c "COPY raw_indicadores_ssprs_municipioss (municipio,homicidio,furtos_veiculo,furtos,roubos,latrocionio,roubo_veiculo,extorsao,extorsao_sequesto,estelionato,delitos_corrupcao,posse_entorpecente,delitos_municoes,trafico_entorpecente,ano) FROM '$PWD/$i' CSV DELIMITER ',' HEADER" ondeacontece; done

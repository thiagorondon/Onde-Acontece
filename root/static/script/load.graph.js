$(function () {

	var mun_ativo = $('select[name=municipio]').val();
	if (mun_ativo == '') mun_ativo = 'Porto Alegre';
	$.getJSON('/api/seguranca/RS/' + mun_ativo, { ano: $('select[name=ano]').val() }, function(d){
		
		var datasets = d.ocorrencias;
		var i = 0;
		$.each(datasets, function(key, val) {
			val.color = i;
			++i;
		});
		
		var data = [];
		
		for (var k in datasets){
			data.push(datasets[k]);
		}
		console.log(data);
		$.plot($("#lines"), data, {
			yaxis: { min: 0 },
		   xaxis: { tickDecimals: 0 }
		});
			
	});

});

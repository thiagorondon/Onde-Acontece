$(function () {

	$.getJSON('/api/seguranca/RS/'+$('input[name=municipio]').val(), { ano: $('input[name=ano]').val() }, function(d){
		
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

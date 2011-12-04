$(function () {

	$.getJSON('/api/seguranca/RS/Porto Alegre', { ano: 2002}, function(d){
		
		var datasets = d.ocorrencias;
console.log(datasets);
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

	var data = [
		{ label: "Series1",  data: [[1,10]]},
		{ label: "Series2",  data: [[1,60]]},
		{ label: "Series3",  data: [[1,90]]},
		{ label: "Series4",  data: [[1,70]]}
	];

	$.plot($("#pie"), data,
		{
		series: {
			pie: {
				show: true
			}
		}
	});



});

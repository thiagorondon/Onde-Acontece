$(function(){
	function CurrencyFormatted(amount)
	{
		amount = new String(amount);  // cast string
		var delimiter = "."; // replace comma if desired
		var a = amount.split('.',2)
		var d = a[1];
		var i = parseInt(a[0]);
		if(isNaN(i)) { return ''; }
		var minus = '';
		if(i < 0) { minus = '-'; }
		i = Math.abs(i);
		var n = new String(i);
		var a = [];
		while(n.length > 3)
		{
			var nn = n.substr(n.length-3);
			a.unshift(nn);
			n = n.substr(0,n.length-3);
		}
		if(n.length > 0) { a.unshift(n); }
		n = a.join(delimiter);
		if(!d || d.length < 1) { amount = n; }
		else { amount = n + ',' + d; }
		amount = minus + amount;
		return amount;
	}
	var _types = [
		{
			"regexp": new RegExp('^PIB'),
			"icon": '/static/images/pib.png'
		},
		{
			"regexp": new RegExp('^Popula..o.residente.$'),
			"icon": '/static/images/grupo-0.png'
		},
		{
			"regexp": new RegExp('unidade territorial'),
			"icon": '/static/images/grupo-0.png'
		},
		{
			"regexp": new RegExp('^Eleitorado'),
			"icon": '/static/images/grupo-0.png'
		}
	],
	$indices = $('#indicadores'),
	_censo,
	_gettext = function(feature){
		feature.properties.valor_str = (feature.properties.unidade == 'Reais'? 'R$ ': '') + CurrencyFormatted(feature.properties.valor);
		return feature.properties.descricao + ': ' + feature.properties.valor_str + ' ' + feature.properties.unidade;
	},
	show_censo = function(){
		var $list = $('<ul></ul>');
		for(var iFeat in _censo.features){
			var feature = _censo.features[iFeat], type;
			
			var $li = $('<li></li>');
			
			$li.text(_gettext(feature));
			
			$list.append($li);
		}
		return $list;
	},
	indices_reload = function(){
		// var year = $('select[name=ano] option:selected').val();
		var municipio = $('select[name=municipio] option:selected').val();
		if (municipio == '') municipio = 'Porto Alegre';

		$indices.html('Carregando...');
		
		var api_url = window.location.protocol + '//' + window.location.host + '/api/ibge/censo/' + encodeURI(municipio);
		
		$.get(api_url, {"content-type": 'application/json'}, function(obj){
			_censo = obj;
			
			$indices.html('');
			for(var iFeat in obj.features){
				var feature = obj.features[iFeat], type;
				for(var itype in _types){
					type = _types[itype];

					
					if ( type.regexp.test(feature.properties.descricao) == true ){
						
						var $el = $('<p></p>');
						$el.text(_gettext(feature));

						if (type.icon){
							$el.prepend('<img src="' + type.icon + '"/>');
						}
						$indices.append($el);
					}
				}
			}
			var $button = $('<button class="btn">Mostrar todos os dados</button>').click(
				function(){
					var $div = $('div.censo:first', $indices);
					if ($div[0]){
						$div.toggle();
					}else{
						$div = $('<div style="margin-top: 1em;" class="censo"></div>');
						$div.append(show_censo());
						
						$indices.append($div);
					}
					
					
				}
			);
			$indices.append($button);
			$indices.append('<p style="float:right"><small>Dados do censo 2010</small></p>');
		});
		
	};
	

	indices_reload();
	
});

/*
<p><img src="/static/images/grupo.png"/>3 homicísdios por 1000 habitantes (total: 10000 habitantes)</p>
<p><img src="/static/images/grupo-0.png"/>nenhum homicídio registrado (total: 10000 habitantes)</p>
<p><img src="/static/images/territorio.png"/>3 homicídios por 1000 km² (total: 10000 km²)</p>
<p><img src="/static/images/territorio-0.png"/>nenhum homicídio km² (total: 10000 km²)</p>
*/
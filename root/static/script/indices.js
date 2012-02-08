$(function(){
	var _types = [
		{
			"regexp": new RegExp('^PIB'),
			"icon": '/static/images/pib.png'
		}
	],
	$indices = $('#indicadores'),
	_censo,
	show_censo = function(){
		var $list = $('<ul></ul>');
		for(var iFeat in _censo.features){
			var feature = _censo.features[iFeat], type;
			
			var $li = $('<li></li>');
			feature.properties.valor_str = (feature.properties.unidade == 'Reais'? 'R$ ': '') + feature.properties.valor;
			
			$li.text(feature.properties.descricao + ' ' + feature.properties.valor_str + ' ' + feature.properties.unidade);
			
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
						feature.properties.valor_str = (feature.properties.unidade == 'Reais'? 'R$ ': '') + feature.properties.valor;
						
						$el.text(feature.properties.descricao + ' ' + feature.properties.valor_str + ' ' + feature.properties.unidade);

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
						$div = $('<div class="censo"></div>');
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
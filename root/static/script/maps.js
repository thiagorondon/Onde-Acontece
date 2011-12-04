(function() {
  var data; // loaded asynchronously
  var path = d3.geo.path();
  var proj = d3.geo.equirectangular().scale(20000).translate([3200, -1500]);
  path.projection(proj);
  var region = d3.select("#chart").append("svg:svg").attr("id", "region").attr("class", "Reds").attr('width', '450px').attr('height', '400px');

  // $('svg path').live('hover', function(e){
  //   $(e.target).tipsy('show');
  // });
  //  d3.json("/poligono" + window.location.pathname.replace(/\/.*?\//, '/'), function(json) {
  d3.json("/api/seguranca/RS?o_id=1&ano=2011&content-type=application/json", function(json) {
    region.selectAll("path").data(json.features).enter().append("svg:path").attr("d", path).attr('class', quantize).attr('original-title', function(d) {
      $(this).tipsy({
        gravity: $.fn.tipsy.autoNS
      });
      return d.properties.name + ': ' + d.properties.quant;
    });

  });
  $('path').live('click', function(e) {
    console.log($(e.target));
  });
  function fetch(type_id, year) {
    d3.json("/api/seguranca/RS?o_id=$$type&ano=$$year&content-type=application/json".replace('$$year', year).replace('$$type', type_id), function(json) {
      $('#chart svg').remove();
      var region = d3.select("#chart").append("svg:svg").attr("id", "region").attr("class", "Reds").attr('width', '450px').attr('height', '400px');

      region.selectAll("path").data(json.features).enter().append("svg:path").attr("d", path).attr('class', quantize).attr('original-title', function(d) {
        $(this).tipsy({
          gravity: $.fn.tipsy.autoNS
        });
        return d.properties.name + ': ' + d.properties.quant;
      });

    });

  }
   var year    = $('select[name=ano] option:selected').val();
   var type_id = $('select[name=ocorrencia] option:selected').val();

   fetch(type_id, year);

  function quantize(d) {
    return "q" + Math.max(1, ((d.properties.quant % 42)));
  }
})();
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
  // d3.json("/api/seguranca/RS?o_id=1&ano=2011&content-type=application/json", function(json) {
  //   region.selectAll("path").data(json.features).enter().append("svg:path").attr("d", path).attr('class', quantize).attr('original-title', function(d) {
  //     $(this).tipsy({
  //       gravity: $.fn.tipsy.autoNS
  //     });
  //     return d.properties.name + ': ' + d.properties.quant;
  //   });
  // });
  $('path').live('click', function(e) {
    console.log($(e.target));
  });
  function fetch(type_id, year) {
    region.append("svg:text").attr("text-anchor", "middle").attr("x", 220)
      .attr("y", 150).text('Carregando mapa, aguarde...');

    d3.json("/api/seguranca/RS?o_id=$$type&ano=$$year&content-type=application/json".replace('$$year', year).replace('$$type', type_id), function(json) {
      $('#chart svg').remove();

      var region = d3.select("#chart").append("svg:svg").attr("id", "region").attr("class", "Reds").attr('width', '450px').attr('height', '400px');
      region.selectAll("path").data(json.features).enter().append("svg:path").attr("d", path).attr('fill', quantize).attr('original-title', function(d) {
        return d.properties.name + ': ' + (d.properties.quant + '').slice(0, 5);
      }).classed('current', function(d) {
        return d.properties.name == $('select[name=municipio] option:selected').val();
      }).on("mouseover", function(d, i) {
        d3.select(this).transition().duration(300).style("fill", "#00f1f1");
      }).on("mouseout", function(d, i) {
        d3.select(this).transition().duration(300).style("fill", quantize);
      });;
      $('path').qtip({
        content: {
          attr: 'original-title'
        },
        position: {
          target: 'mouse'
        }
      });
    });

  }

  var year = $('select[name=ano] option:selected').val();
  var type_id = $('select[name=ocorrencia] option:selected').val();

  fetch(type_id, year);
  var lowest = '#F8DBCD';
  var highest = '#C43C35';
  var changeColor = d3.interpolateRgb(lowest, highest);
  function quantize(d) {
    var x = d.properties.quant;
    if (x == 0) return lowest;
    if (x > 1.0) return highest;
    return changeColor(x / Math.sqrt(x));
  }
})();
(function() {
  var data; // loaded asynchronously
  var path = d3.geo.path();
  var proj = d3.geo.equirectangular().scale(20000).translate([3200, -1500]);
  path.projection(proj);
  var region = d3.select("#chart").append("svg:svg").attr("id", "region").attr("class", "Reds").attr('width', '450px').attr('height', '400px');

  $('path').live('click', function(e) {
    console.log($(e.target));
  });
  function fetch(type_id, year) {
    d3.json("/api/seguranca/RS?o_id=$$type&ano=$$year&content-type=application/json".replace('$$year', year).replace('$$type', type_id), function(json) {
      $('#chart svg').remove();
      var region = d3.select("#chart").append("svg:svg").attr("id", "region").attr("class", "Reds").attr('width', '450px').attr('height', '400px');
      region.selectAll("path").data(json.features).enter().append("svg:path").attr("d", path).attr('fill', quantize).attr('original-title', function(d) {
        return d.properties.name + ': ' + (d.properties.quant + '').slice(0, 5);
      }).on("mouseover", function(d, i) {
        d3.select(this).transition().duration(300).style("fill", "#00f1f1");
      }).on("mouseout", function(d, i) {
        d3.select(this).transition().duration(300).style("fill", quantize);
      }).on('click', function(d, i) {
        window.location = '?' + $.param({
          ano: $('select[name=ano] option:selected').val(),
          ocorrencia: $('select[name=ocorrencia] option:selected').val(),
          municipio: d.properties.name
        });
      }).classed('current', function(d) {
        return d.properties.name == $('select[name=municipio] option:selected').val();
      });
      $('path').qtip({
        content: {
          attr: 'original-title'
        },
        position: {
          adjust: {
            mouse: true
          },
          target: 'mouse',
          at: 'top right',
          my: 'bottom left',
          adjust: {
            x: 5,
            y: -5
          }
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
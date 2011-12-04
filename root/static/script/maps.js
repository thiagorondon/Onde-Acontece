(function() {
  var data; // loaded asynchronously
  var path = d3.geo.path();
  path.projection(d3.geo.equirectangular().scale(24000).translate([4000, -1800]));
  var region = d3.select("#chart").append("svg:svg").attr("id", "region").attr("class", "Blues");

  // $('svg path').live('hover', function(e){
  //   $(e.target).tipsy('show');
  // });
  d3.json("/poligono" + window.location.pathname.replace(/\/.*?\//, '/'), function(json) {
            region.selectAll("path").data(json.features).enter().append("svg:path").attr("d", path).attr('class', quantize).attr('original-title', function(d) {
      $(this).parent().tipsy();
      return d.properties.name;
      });

  });
  function quantize(d) {
    return "q" + Math.min(8, ~~ ((d.properties.name.length * 9) / 12)) + "-9";
  }
})();
(function() {
  var data; // loaded asynchronously
  var path = d3.geo.path();
  path.projection(d3.geo.equirectangular().scale(4000).translate([1200, 100]));
  margin = 25;
  width = window.innerWidth - margin;
  height = window.innerHeight - margin;
  var region = d3.select("#chart").append("svg:svg").attr("height", height - 5 * margin).attr("transform", "translate(" + margin + "," + 3 * margin + ")").attr("id", "counties").attr("class", "Blues");
  d3.json("/poligono" + window.location.pathname.replace(/\/.*?\//, '/'), function(json) {
   region.selectAll("path").data(json.features).enter().append("svg:path").attr("d", path);
  });
})();
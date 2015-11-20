var width = 1000,
    height = 700,
    radius = 15;

var color = d3.scale.category20c();

var force = d3.layout.force()
    .charge(-1000)
    .linkDistance(200)
    .size([width, height]);

var svg = d3.select("#graph").append("svg")
    .attr("width", width)
    .attr("height", height);

d3.json("Assets/grn.json", function(error, graph)
{
  if (error) throw error;

  force
      .nodes(graph.nodes)
      .links(graph.links)
      .start();

  // Adding the arrow to the edge
  // Solution - http://stackoverflow.com/q/28050434/2650427
  svg
    .append("defs").selectAll("marker")
    .data(["end"])
    .enter().append("marker")
    .attr("id", String)
    .attr("viewBox", "0 -5 10 10")
    .attr("refX", 15)
    .attr("refY", 0.0)
    .attr("markerWidth", 10)
    .attr("markerHeight", 6)
    .attr("orient", "auto")
    .attr("markerUnits", "userSpaceOnUse")
    .append("path")
    .attr("d", "M0,-5 L10,0 L0,5");

  var link = svg.selectAll(".link")
      .data(graph.links)
      .enter().append("line")
      .attr("class", "link")
      .style("stroke-width", function(d) { return Math.sqrt(2); })
      .attr("marker-end", "url(#end)"); // adds the arrow

  // To add the text on the circle the following answer helped:
  // http://stackoverflow.com/a/24433484/2650427
  var node = svg.selectAll(".node")
      .data(graph.nodes)
      .enter().append("g")
      .attr("class", "node")
      .call(force.drag);

  node.append("circle")
      .attr("r", radius)
      .style("fill", function(d) { return color(d.name); });

  node.append("text")
      .style("text-anchor", "middle")
      .attr("font-size", "12px")
      .attr("dy", ".30em")
      .text(function(d) {  return d.name;  });

  force.on("tick", function()
  {
    link.attr("x1", function(d) { return d.source.x; })
        .attr("y1", function(d) { return d.source.y; })
        .attr("x2", function(d) { return d.target.x; })
        .attr("y2", function(d) { return d.target.y; });

    node.attr("cx", function(d) { return d.x; })
        .attr("cy", function(d) { return d.y; })
        .attr("transform", function(d) { return "translate(" + [d.x-10, d.y+4] + ")"; });
  });
});
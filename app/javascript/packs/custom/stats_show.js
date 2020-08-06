if (document.getElementById("graph-d3-project") !== null) {
  let project_id = document.getElementById('project_id').value;
  ajax('dataProject', { m_id: project_id }, 'project', draw)
}
if (document.getElementById("graph-d3-user") !== null) {
  ajax('dataUser', {}, 'user', draw)
}
if (document.getElementById("graph-d3-team") !== null) {
  let team_id = document.getElementById('team_id').value;
  ajax('dataTeam', { m_id: team_id }, 'team', draw)
}
if (document.getElementById("graph-d3-lineChart") !== null) {
  ajax('dataUser/hoursIntervalTime', { interval: 'day' }, '', lineChart)
  document.getElementById("change_interval").addEventListener(
    'change',
    () => {
      document.getElementById("graph-d3-lineChart").innerHTML = '';
      let intervalTime = document.getElementById("change_interval").value
      ajax('dataUser/hoursIntervalTime', { interval: intervalTime }, '', lineChart)
    }
  )
}
if (document.getElementById("graph-d3-pieChart") !== null) {
  ajax('dataTracks', {}, '', pieChart)
}

function ajax(url, params, nameModel, functionGraph){
  $.ajax({
    type: "GET",
    contentType: "application/json; charset=utf-8",
    url: '/me/' + url,
    dataType: 'json',
    data: params,
    success: function (json) {
      functionGraph(json, nameModel);
    },
    error: function (result) {
      error(result);
    }
  })
}

function draw(data, nameModel){
  var margin = {top: 40, right: 20, bottom: 30, left: 40},
  width = 800 - margin.left - margin.right,
  height = 528 - margin.top - margin.bottom;

  var formatPercent = d3.format("0");
  var x = d3.scale.ordinal()
  .rangeRoundBands([0, width], .1);

  var y = d3.scale.linear()
  .range([height, 0]);

  var xAxis = d3.svg.axis()
  .scale(x)
  .orient("bottom");

  var yAxis = d3.svg.axis()
  .scale(y)
  .orient("left")
  .tickFormat(formatPercent);

  var tip = d3.tip()
  .attr('class', 'd3-tip')
  .offset([-10, 0])
  .html(function(d) { return "<strong> time: </strong> <span style='color:green'>" + d.time + " min </span>"; })

  var svg = d3.select(`#graph-d3-${nameModel}`).append("svg")
  .attr("width", width + margin.left + margin.right)
  .attr("height", height + margin.top + margin.bottom)
  .append("g")
  .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

  svg.call(tip);

  d3.select(`#graph-d3-${nameModel}`)
  x.domain(data.map(function(d) { return d.name; }));
  y.domain([0, d3.max(data, function(d) { return d.time; })]);

  svg.append("g")
    .attr("class", "x axis")
    .attr("transform", "translate(0," + height + ")")
    .call(xAxis);
  svg.append("g")
    .attr("class", "y axis")
    .call(yAxis)
    .append("text")
    .attr("transform", "rotate(-90)")
    .attr("y", 6)
    .attr("dy", ".71em")
    .style("text-anchor", "end")
    .text("time");
  svg.selectAll(".bar")
    .data(data)
    .enter().append("rect")
    .attr("class", "bar")
    .attr("x", function(d) { return x(d.name); })
    .attr("width", x.rangeBand())
    .attr("y", function(d) { return y(d.time); })
    .attr("height", function(d) { return height - y(d.time); })
    .on('mouseover', tip.show)
    .on('mouseout', tip.hide)
};

const radio = (item) => {
  value = item.time == 0 ?  0 :  3.5
  return value
}

function lineChart(data, a) {
  var margin = {top: 40, right: 20, bottom: 30, left: 40},
  width = 960 - margin.left - margin.right,
  height = 500 - margin.top - margin.bottom;

  var parseDate = d3.time.format("%d-%b-%y").parse;

  var x = d3.time.scale().range([0, width]);
  var y = d3.scale.linear().range([height, 0]);

  var xAxis = d3.svg.axis().scale(x)
  .orient("bottom").ticks(5);

  var yAxis = d3.svg.axis().scale(y)
  .orient("left").ticks(5);

  var valueline = d3.svg.line()
  .x(function(d) { return x(d.date); })
  .y(function(d) { return y(d.time); });

  var svg = d3.select("#graph-d3-lineChart")
    .append("svg")
    .attr("width", width + margin.left + margin.right)
    .attr("height", height + margin.top + margin.bottom)
    .append("g")
    .attr("transform",
          "translate(" + margin.left + "," + margin.top + ")");

  data.forEach(function(d) {
    d.date = new Date(d.date);
    d.time = +d.time;

    x.domain(d3.extent(data, function(d) { return d.date; }));
    y.domain([0, d3.max(data, function(d) { return d.time; })]);

    svg.append("path")
      .attr("class", "line")
      .attr("d", valueline(data));

    svg.selectAll("dot")
      .data(data)
      .enter().append("circle")
      .attr("r", (d) => radio(d))
      .attr("cx", d =>  x(d.date))
      .attr("cy", d =>  y(d.time));

    svg.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height + ")")
      .call(xAxis);

    svg.append("g")
      .attr("class", "y axis")
      .call(yAxis);
  });
}

function pieChart(data, a) {
  var w = 800;
  var h = 528;
  var r = h/2;
  var aColor = [
      '#008000',
      '#37435D',
      '#AD0404'
  ]

  var vis = d3.select('#graph-d3-pieChart')
  .append("svg:svg").data([data])
  .attr("width", w)
  .attr("height", h)
  .append("svg:g")
  .attr("transform", "translate(" + r + "," + r + ")");

  var pie = d3.layout.pie().value(function(d) { return d.value; });

  // Declare an arc generator function
  var arc = d3.svg.arc().outerRadius(r);

  // Select paths, use arc generator to draw
  var arcs = vis.selectAll("g.slice").data(pie).enter().append("svg:g").attr("class", "slice");
  arcs.append("svg:path")
    .attr("fill", function(d, i){return aColor[i];})
    .attr("d", function (d) {return arc(d);})
  ;

  // Add the text
  arcs.append("svg:text")
    .attr("transform", function(d){
      d.innerRadius = 100; /* Distance of label to the center*/
      d.outerRadius = r;
      return "translate(" + arc.centroid(d) + ")";}
    )
    .attr("text-anchor", "middle")
    .text( function(d, i) { return showItem(data[i]); });
}

function showItem(item) {
  return `${item.status.charAt(0).toUpperCase() + item.status.slice(1)} ${item.value}`.replace("_", " ");
}

document.onreadystatechange = () => { 
  if (document.readyState === 'complete') {
    if (document.getElementById("graph-d3-project") !== null) {
      let project_id = document.getElementById('project_id').value;  
      $.ajax({
          type: "GET",
          contentType: "application/json; charset=utf-8",
          url: '/me/dataProject',
          dataType: 'json',
          data: { project_id: project_id },
          success: function (dataProject) {
            draw(dataProject);
          },
          error: function (result) {
            error();
          }
        });
  
        function error(){
          console.log(error);
        }
  
        function draw(dataProject) {

            var margin = {top: 40, right: 20, bottom: 30, left: 40},
            width = 960 - margin.left - margin.right,
            height = 500 - margin.top - margin.bottom;
            
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
            .html(function(d) {
              return "<strong> min: </strong> <span style='color:green'>" + d.hour + " min </span>";
            })
          
            var svg = d3.select("body").append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
            .append("g")
            .attr("transform", "translate(" + margin.left + "," + margin.top + ")");
          
            svg.call(tip);
          
            d3.select("#graph-d3-project")
            x.domain(dataProject.map(function(d) { return d.user; }));
            y.domain([0, d3.max(dataProject, function(d) { return d.hour; })]);
          
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
            .text("min");
          
            svg.selectAll(".bar")
            .data(dataProject)
            .enter().append("rect")
            .attr("class", "bar")
            .attr("x", function(d) { return x(d.user); })
            .attr("width", x.rangeBand())
            .attr("y", function(d) { return y(d.hour); })
            .attr("height", function(d) { return height - y(d.hour); })
            .on('mouseover', tip.show)
            .on('mouseout', tip.hide)
        };    
      }
    }

    else if (document.getElementById("graph-d3-user") !== null) {
      $.ajax({
        type: "GET",
        contentType: "application/json; charset=utf-8",
        url: '/me/dataUser',
        dataType: 'json',
        success: function (dataUser) {
          draw(dataUser);
        },
        error: function (result) {
          error();
        }
      });

      function error(){
        console.log(error);
      }

      function draw(dataUser) {
        if (dataUser.length !== 0){
          var margin = {top: 40, right: 20, bottom: 30, left: 40},
          width = 960 - margin.left - margin.right,
          height = 500 - margin.top - margin.bottom;
          
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
          .html(function(d) {
            return "<strong> min: </strong> <span style='color:green'>" + d.hour + " min </span>";
          })

          var svg = d3.select("body").append("svg")
          .attr("width", width + margin.left + margin.right)
          .attr("height", height + margin.top + margin.bottom)
          .append("g")
          .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

          svg.call(tip);

          d3.select("#graph-d3-user")
          x.domain(dataUser.map(function(d) { return d.task; }));
          y.domain([0, d3.max(dataUser, function(d) { return d.hour; })]);

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
          .text("min");

          svg.selectAll(".bar")
          .data(dataUser)
          .enter().append("rect")
          .attr("class", "bar")
          .attr("x", function(d) { return x(d.task); })
          .attr("width", x.rangeBand())
          .attr("y", function(d) { return y(d.hour); })
          .attr("height", function(d) { return height - y(d.hour); })
          .on('mouseover', tip.show)
          .on('mouseout', tip.hide)
        }
      };    
    }
  }
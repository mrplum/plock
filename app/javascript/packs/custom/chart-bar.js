// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';

function number_format(number, decimals, dec_point, thousands_sep) {
  // *     example: number_format(1234.56, 2, ',', ' ');
  // *     return: '1 234,56'
  number = (number + '').replace(',', '').replace(' ', '');
  var n = !isFinite(+number) ? 0 : +number,
    prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
    sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
    dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
    s = '',
    toFixedFix = function(n, prec) {
      var k = Math.pow(10, prec);
      return '' + Math.round(n * k) / k;
    };
  // Fix for IE parseFloat(0.55).toFixed(0) = 0;
  s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
  if (s[0].length > 3) {
    s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
  }
  if ((s[1] || '').length < prec) {
    s[1] = s[1] || '';
    s[1] += new Array(prec - s[1].length + 1).join('0');
  }
  return s.join(dec);
}

var ctx2 = document.getElementById("myBarChartTeam");
if (ctx2 !== null) {
  let team_id = document.getElementById('team_id').value;
  $.ajax({
    type: "GET",
    contentType: "application/json; charset=utf-8",
    url: '/me/dataTeam/hoursToProjects',
    dataType: 'json',
    data: { m_id: team_id },
    success: function (json) {
      functionGraph(json, ctx2);
    },
    error: function (result) {
      error(result);
    }
  })
}

var ctx = document.getElementById("myBarChart");
if (ctx !== null) {
  $.ajax({
    type: "GET",
    contentType: "application/json; charset=utf-8",
    url: '/me/dataUser/hoursInTracks',
    dataType: 'json',
    data: {},
    success: function (json) {
      functionGraph(json, ctx);
    },
    error: function (result) {
      error(result);
    }
  })
}

function functionGraph(data, ctx){
  var dataLabels = [];
  var dataTime = [];
  var dataMax = 0;
  for (var i = 0; i < data.length; i++) {
    dataLabels.push(data[i].name)
    dataTime.push(data[i].time)
    if (data[i].time > dataMax){
      dataMax = data[i].time
    }
  }

  var myBarChart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: dataLabels,
      datasets: [{
        label: "time",
        backgroundColor: "#4e73df",
        hoverBackgroundColor: "#2e59d9",
        borderColor: "#4e73df",
        data: dataTime,
      }],
    },
    options: {
      maintainAspectRatio: false,
      layout: {
        padding: {
          left: 10,
          right: 25,
          top: 25,
          bottom: 0
        }
      },
      scales: {
        xAxes: [{
          time: {
            unit: 'minute'
          },
          gridLines: {
            display: false,
            drawBorder: false
          },
          ticks: {
            display: false
          },
        }],
        yAxes: [{
          ticks: {
            min: 0,
            max: dataMax,
            maxTicksLimit: 5,
            padding: 10,
            callback: function(value, index, values) {
              return number_format(value) + ' hs';
            }
          },
          gridLines: {
            color: "rgb(234, 236, 244)",
            zeroLineColor: "rgb(234, 236, 244)",
            drawBorder: false,
            borderDash: [2],
            zeroLineBorderDash: [2]
          }
        }],
      },
      legend: {
        display: false
      },
      tooltips: {
        titleMarginBottom: 10,
        titleFontColor: '#6e707e',
        titleFontSize: 14,
        backgroundColor: "rgb(255,255,255)",
        bodyFontColor: "#858796",
        borderColor: '#dddfeb',
        borderWidth: 1,
        xPadding: 15,
        yPadding: 15,
        displayColors: false,
        caretPadding: 10,
        callbacks: {
          label: function(tooltipItem, chart) {
            var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
            return datasetLabel + ': ' + number_format(tooltipItem.yLabel,2);
          }
        }
      },
    }
  });
}

// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';

var ctx = document.getElementById("myPieChart");
if (ctx !== null) {
  $.ajax({
    type: "GET",
    contentType: "application/json; charset=utf-8",
    url: '/me/dataTracks',
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
  console.log(data)
  var dataLabels = [];
  var dataValue = [];
  for (var i = 0; i < data.length; i++) {
    dataLabels.push(data[i].status)
    dataValue.push(data[i].value)
  }

  var myPieChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
      labels: dataLabels,
      datasets: [{
        data: dataValue,
        backgroundColor: ['#e74a3b', '#f6c23e', '#1cc88a'],
        hoverBackgroundColor: ['#cf4235', '#ddae37', '#17a673'],
        hoverBorderColor: "rgba(234, 236, 244, 1)",
      }],
    },
    options: {
      maintainAspectRatio: false,
      tooltips: {
        backgroundColor: "rgb(255,255,255)",
        bodyFontColor: "#858796",
        borderColor: '#dddfeb',
        borderWidth: 1,
        xPadding: 15,
        yPadding: 15,
        displayColors: false,
        caretPadding: 10,
      },
      legend: {
        display: false
      },
      cutoutPercentage: 80,
    },
  });
}
import { ajax } from "../ajax";

// Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#858796';

var ctx4 = document.getElementById("myPieChart");
if (ctx4 !== null) {
  ajax("GET", "/me/dataTracks", { }, functionGraph, ctx4);
}

function functionGraph(data, ctx){
  var myPieChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
      labels: ['unstarted', 'in progress', 'finished'],
      datasets: [{
        data: dataValue(data),
        backgroundColor: ['#4e73df', '#36b9cc', '#1cc88a'],
        hoverBackgroundColor: ['#2e59d9', '#2c9faf', '#17a673'],
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

function dataValue(data){
  var dataValue = [];
  if (data.length == 1){
    if (data[0].status == 'unstarted'){
      dataValue[0] = data[0].value;
      dataValue[1] = 0;
      dataValue[2] = 0;
    }
    else if (data[0].status == 'in_progress'){
      dataValue[0] = 0;
      dataValue[1] = data[0].value;
      dataValue[2] = 0;
    }
    else if (data[0].status == 'finished'){
      dataValue[0] = 0;
      dataValue[1] = 0;
      dataValue[2] = data[0].value;
    }
  }
  else if (data.length == 2){
    if (data[0].status == 'unstarted' && data[1].status == 'in_progress'){
      dataValue[0] = data[0].value;
      dataValue[1] = data[1].value;
      dataValue[2] = 0;
    }
    else if (data[0].status == 'in_progress' && data[1].status == 'finished'){
      dataValue[0] = 0;
      dataValue[1] = data[0].value;
      dataValue[2] = data[1].value;
    }
    else if (data[0].status == 'unstarted' && data[1].status == 'finished'){
      dataValue[0] = data[0].value;
      dataValue[1] = 0;
      dataValue[2] = data[1].value;
    }
  }
  else {
    if (data[0].status == 'unstarted' && data[1].status == 'in_progress' && data[2].status == 'finished'){
      dataValue[0] = data[0].value;
      dataValue[1] = data[1].value;
      dataValue[2] = data[2].value;
    }
  }
  return dataValue;
}
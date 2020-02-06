import React from 'react';
import {
  ActivityIndicator,
  View
} from 'react-native';
import {
  BarChart
} from "react-native-chart-kit";

const BarChartComponent = (props) => {
  
  const barChartConfig = {
    backgroundGradientFrom: "#1E2923",
    backgroundGradientFromOpacity: 0,
    backgroundGradientToOpacity: 0.5,
    color: (opacity = 1) => `rgba(0,0,0, ${opacity})`,
    labelColor: (opacity = 1) => `rgba(255, 255, 255, ${opacity})`,
    barPercentage: 0.9
  };

  if (props.chartData.length) {
    const keys = props.chartData.map( object => object[0])
    const minutes = props.chartData.map( object => object[1])
    return (
      <View>
        {props.chartData && 
          <BarChart
            data={
              {
                labels: keys,
                datasets: [
                  {
                    data: minutes
                  }
                ]
              }
            }
            yAxisSuffix = ''
            width = { props.screenWidth }
            height = { 350 }
            chartConfig = { barChartConfig }
            verticalLabelRotation = { 0 }
          />
        }
      </View>
    );
  }

  return( 
    <View style= { props.styleHorizontal }>
      <ActivityIndicator size="large" color="#0000ff" />
    </View>
  );
}

export default BarChartComponent;

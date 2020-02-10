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
    backgroundGradientFromOpacity: 0,
    backgroundGradientToOpacity: 0.9,
    fillShadowGradientOpacity: 10,
    color: () => `rgba(61, 105, 6, 1)`,
    labelColor: (opacity = 1) => `rgba(255, 255, 255, ${opacity})`,
    barPercentage: 0.9,
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
            fromZero = { true }
            segments = { 10 } 
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

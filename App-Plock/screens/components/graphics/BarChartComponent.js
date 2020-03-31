import React from 'react';
import {
  ActivityIndicator,
  View,
  ScrollView
} from 'react-native';
import {
  BarChart
} from "react-native-chart-kit";
import {
  Svg
} from 'react-native-svg'

const BarChartComponent = (props) => {
  
  const barChartConfig = {
    backgroundGradientFromOpacity: 0,
    backgroundGradientToOpacity: 0.9,
    fillShadowGradientOpacity: 10,
    color: () => `rgba(65, 204, 30, 1)`,
    labelColor: () => `rgba(255, 255, 255, 1)`,
    barPercentage: 0.9
  };

  if (props.chartData.length) {
    const keys = props.chartData.map( object => object[0] )
    const minutes = props.chartData.map( object => object[1] )
    return (
      <View>
        {props.chartData &&
          <ScrollView horizontal = {true}>
            <Svg width = { props.calculateWidth } height = { props.screenHeight - 20 }>
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
                width = { props.calculateWidth }
                height = { 400 }
                chartConfig = { barChartConfig }
                verticalLabelRotation = { 0 }
              />
            </Svg>
          </ScrollView>
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

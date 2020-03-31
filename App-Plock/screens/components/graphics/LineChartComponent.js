import React from 'react'
import {
  ActivityIndicator,
  View,
  ScrollView
} from 'react-native'
import {
  LineChart
} from "react-native-chart-kit"
import {
  Svg
} from 'react-native-svg'

const LineChartComponent = (props) => {
  
  const chartConfig = {
    backgroundGradientFromOpacity: 0,
    backgroundGradientToOpacity: 0.9,
    color: () =>`rgba(26, 255, 146, 1)`,
    labelColor: () => `rgba(255, 255, 255, 1)`,
    barPercentage: 0.9
  };

  if (props.chartData.length) {

    const keys = props.chartData.map( object => object.key_as_string )
    const minutes = props.chartData.map( object => object.time_worked.value )
    const dataGraph = {
      labels: keys,
      datasets: [
        {
          data: minutes
        }
      ],
    };
  
    return (
      <View>
        {props.chartData && 
          <ScrollView horizontal = {true}>
            <Svg width = { props.calculateWidth } height = { props.screenHeight - 20 }>
              <LineChart
                data = { dataGraph }
                fromZero = { true }
                segments = { 10 } 
                width = { props.calculateWidth }
                height = { 550 }
                chartConfig = { chartConfig }
                verticalLabelRotation = { 90 }
                bezier
              />
            </Svg>
          </ScrollView>
        }
      </View>
    );
  }

  return( 
    <View style = { props.styleHorizontal }>
      <ActivityIndicator size="large" color="#0000ff" />
    </View>
  );
}

export default LineChartComponent;

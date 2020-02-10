import React from 'react';
import {
  ActivityIndicator,
  View
} from 'react-native';
import {
  PieChart
} from 'react-native-chart-kit';

const PieChartComponent = (props) => {

  const pieChartConfig = {
    color: (opacity = 1) => `rgba(255, 255, 255, ${opacity})`,
    labelColor: (opacity = 1) => `rgba(255, 255, 255, ${opacity})`
  }

  const searchStatus = (key) => {
    return (
      props.chartData.filter( obj => obj[0] === key )
    );
  }

  const setUnstarted = () => {
    let result = searchStatus('unstarted')
    var ret = 0;
    if (result.length) {
      ret = result[0][1]
    }
    return ret
  }

  const setFinished = () => {
    let result = searchStatus('finished')
    var ret = 0;
    if (result.length) {
      ret = result[0][1]
    }
    return ret
  }

  const setInprogress = () => {
    let result = searchStatus('in_progress')
    var ret = 0;
    if (result.length) {
      ret = result[0][1]
    }
    return ret
  }

  if (props.chartData.length) {
    var data = [
      {
        name: 'FINISHED',
        cant: setFinished(),
        color: '#008000',
        legendFontSize: 16
      },
      {
        name: 'IN PROGESS',
        cant: setInprogress(),
        color: '#37435D',
        legendFontSize: 16
      },
      {
        name: 'UNSTARTED',
        cant: setUnstarted(),
        color: '#AD0404',
        legendFontSize: 16
      }
    ];
    return (
      <View>
        {props.chartData && 
          <PieChart
            data = { data }
            width = { props.screenWidth }
            height = { 235 }
            chartConfig = { pieChartConfig }
            accessor = 'cant'
            backgroundColor = 'transparent'
            paddingLeft = '15'
            absolute
          />
        }
      </View>
    );
  }
  return( 
    <View style={ props.styleHorizontal }>
      <ActivityIndicator size = 'large' color = '#37435D' />
    </View>
  );
}

export default PieChartComponent;

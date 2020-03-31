import React, { useState, useEffect } from 'react'
import {
  StyleSheet,
  View,
  Dimensions,
  Image,
  ScrollView
} from 'react-native'
import {
  ButtonGroup,
  Button,
  Text
} from 'react-native-elements'
import clientApollo from '../../../util/clientApollo'
import gql from 'graphql-tag'
import BarChartComponent from '../../components/graphics/BarChartComponent'
import PieChartComponent from '../../components/graphics/PieChartComponent'
import LineChartComponent from '../../components/graphics/LineChartComponent'

const screenWidth = Dimensions.get('window').width
const screenHeight = Dimensions.get('window').height

const StatsUserScreen = () => {

  const client = clientApollo()

  const [typeStats, setTypeStats] = useState()
  const [dataStatus, setDataStatus] = useState([]);
  const [dataProjects, setDataProjects] = useState([]);
  const [dataTimeInterval, setDataTimeInterval] = useState([]);
  const [flag, setFlag] = useState(true);

  useEffect(() => {
    client
    .query({
      query: gql`
        {
          statsByStatus
        }`
      })
    .then((response) => JSON.parse(JSON.stringify(response)))
    .then((response) => {
      setDataStatus(response.data.statsByStatus)
    })
    client
    .query({
      query: gql`
        {
          statsByProjects
        }`
    })
    .then((response) => JSON.parse(JSON.stringify(response)))
    .then((response) => {
      setDataProjects(response.data.statsByProjects)
    });
  }, [flag]);

  const handleChange = (type) => {
    setTypeStats(type)
  }

  const requestData = (type) => {
    client
    .query({
      query: gql`
      query queryByInteval($interval: String!){
        statsByTimeInterval(interval: $interval)
      }`,
      variables: {
        interval: type
      }
    })
    .then((response) => JSON.parse(JSON.stringify(response)))
    .then((response) => {
      setDataTimeInterval(response.data.statsByTimeInterval)
    });
  }

  const component1 = () => {
    return(
      <Button 
        title = 'STATUS'
        titleStyle = { styles.titleStyle }
        type = 'clear'
        onPress = {() => handleChange('status')}
      />
    )
  }

  const component2 = () => {
    return (
      <Button
        title = 'PROJECTS'
        titleStyle = { styles.titleStyle }
        type = 'clear'
        onPress = {() => handleChange('projects')}
      />
    )
  }

  const component3 = () => {
    return (
      <Button
        title = 'TIME INTERVAL'
        titleStyle = { styles.titleStyle }
        type = 'clear'
        onPress = {() => handleChange('time_interval')}
      />
    )
  }

  const buttons = [{ element: component1 }, { element: component2 }, { element: component3 }]

  const componentTime1 = () => {
    return(
      <Button 
        title = 'DAY'
        titleStyle = { styles.titleStyle }
        type = 'clear'
        onPress = {() => requestData('day')}
      />
    )
  }

  const componentTime2 = () => {
    return (
      <Button
        title = 'WEEK'
        titleStyle = { styles.titleStyle }
        type = 'clear'
        onPress = {() => requestData('week')}
      />
    )
  }

  const componentTime3 = () => {
    return (
      <Button
        title = 'MONTH'
        titleStyle = { styles.titleStyle }
        type = 'clear'
        onPress = {() => requestData('month')}
      />
    )
  }

  const componentTime4 = () => {
    return (
      <Button
        title = 'YEAR'
        titleStyle = { styles.titleStyle }
        type = 'clear'
        onPress = {() => requestData('year')}
      />
    )
  }

  const buttons1 = [{ element: componentTime1 }, { element: componentTime2 }, { element: componentTime3 }, { element: componentTime4 }]

  const calculateWidth = (data) => {
    let value =  data.length <= 10 ? screenWidth : screenWidth + (data.length * 15)
    return value
  }

  const renderGraphs = () => {
    if (typeStats === 'status') {
      return (
        <View style={ { marginTop: 70 } }>
          <Text style = { styles.text }></Text>
          <PieChartComponent
            chartData = { dataStatus }
            screenWidth = { screenWidth }
            styleHorizontal = { styles.horizontal }
          />
        </View>
      );
    }
    if (typeStats === 'projects') {
      return (
        <View style={ { marginTop: 40 } }>
          <Text style = { styles.text }>Minutes worked per project</Text>
          <BarChartComponent
            chartData = { dataProjects }
            screenWidth = { screenWidth }
            screenHeight = { screenHeight }
            calculateWidth = { calculateWidth(dataProjects) }
            styleHorizontal = { styles.horizontal }
          />
        </View>
      );
    }
    if (typeStats === 'time_interval') {
      return (
        <View>
            <View style={ { marginTop: 29 } }>
              <ButtonGroup
                buttons = { buttons1 }
                containerStyle={styles.buttonGroup1}
                />
            </View>
            <View style={ { marginTop:45 } }>
              <LineChartComponent
                chartData = { dataTimeInterval }
                screenWidth = { screenWidth }
                screenHeight = { screenHeight }
                calculateWidth = { calculateWidth(dataTimeInterval) }
                styleHorizontal = { styles.horizontal }
              />
            </View>
        </View>
      );
    }
  }
  return(
    <View style={styles.container}>
      <ScrollView>
        <ButtonGroup
          buttons = { buttons }
          containerStyle = { styles.buttonGroup }
        />
        {!typeStats &&
          <View style={ { marginTop: 70 } }>
            <View style={styles.separatorLine}></View>
            <Text style = {styles.text}> Select the type of statistics you want to see </Text>
            <Text style = {styles.text}> * Press on the text </Text>
            <Image
              source={ require('../../../assets/images/stats.png') }
              style={styles.image}
            />
          </View>
        }
        <View style={ { marginTop: 50 } }>
          { renderGraphs() }
        </View>
      </ScrollView>
    </View>
  );
}

export default StatsUserScreen

StatsUserScreen.navigationOptions = {
  title: 'Statistics',
  headerTintColor: '#fff',
  headerStyle: {
    backgroundColor: '#808080',
  }
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    backgroundColor: '#808080'
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
  horizontal: {
    flexDirection: 'row',
    justifyContent: 'space-around',
    padding: 30
  },
  buttonGroup: {
    position: 'absolute',
    backgroundColor: '#37435D',
    top: 0,
    left: 0,
    right: 0,
    height: 70,
    borderRadius: 5
  },
  buttonGroup1: {
    position: 'absolute',
    backgroundColor: '#8b0000',
    top: 0,
    left: 0,
    right: 0,
    height: 35
  },
  text: {
		alignItems: 'center',
		fontSize: 16,
    fontWeight: 'bold',
    color: '#000000'
  },
  image: {
    width: screenWidth,
    height: screenHeight-250
  },
  separatorLine :{
		height: 40
  },
  titleStyle: {
    color: 'white'
  }
});

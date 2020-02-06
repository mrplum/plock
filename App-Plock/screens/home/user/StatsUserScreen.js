import React, { useState, useEffect } from 'react'
import {
  StyleSheet,
  View,
  Dimensions,
  Image
} from 'react-native'
import {
  ButtonGroup,
  Text
} from 'react-native-elements'
import clientApollo from '../../../util/clientApollo'
import gql from 'graphql-tag'
import BarChartComponent from '../../components/graphics/BarChartComponent'
import PieChartComponent from '../../components/graphics/PieChartComponent'

const screenWidth = Dimensions.get('window').width
const screenHeight = Dimensions.get('window').height

const StatsUserScreen = () => {

  const client = clientApollo()


  const [typeStats, setTypeStats] = useState()
  const [dataStatus, setDataStatus] = useState([]);
  const [dataProjects, setDataProjects] = useState([]);
  const [dataDays, setDataDays] = useState([]);
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
          statsByDay
        }`
    })
    .then((response) => JSON.parse(JSON.stringify(response)))
    .then((response) => {
      setDataDays(response.data.statsByDay)
    });
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

  const component1 = () => <Text style = { styles.textButtonGroup } onPress = {() => handleChange('status')}>STATUS</Text>
  const component2 = () => <Text style = { styles.textButtonGroup } onPress = {() => handleChange('projects')}>PROJECTS</Text>
  const component3 = () => <Text style = { styles.textButtonGroup } onPress = {() => handleChange('days')}>DAYS</Text>
  const buttons = [{ element: component1 }, { element: component2 }, { element: component3 }]

  const renderGraphs = () => {
    if (typeStats === 'status') {
      return (
        <View>
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
        <View>
          <Text style = { styles.text }>Minutes worked per project</Text>
          <BarChartComponent
            chartData = { dataProjects }
            screenWidth = { screenWidth }
            styleHorizontal = { styles.horizontal }
          />
        </View>
      );
    }
    if (typeStats === 'days') {
      return (
        <View>
          <Text style = { styles.text }>Minutes worked per day</Text>
          <BarChartComponent
            chartData = { dataDays }
            screenWidth = { screenWidth }
            styleHorizontal = { styles.horizontal }
          />
        </View>
      );
    }
  }
  return(
    <View style={styles.container}>
      <ButtonGroup
        buttons = { buttons }
        containerStyle={styles.buttonGroup}
      />
      {!typeStats &&
        <View>
          <View style={styles.separatorLine}></View>
          <Text style = {styles.text}> Select the type of statistics you want to see </Text>
          <Text style = {styles.text}> * Press on the text </Text>
          <Image
            source={ require('../../../assets/images/stats.png') }
            style={styles.image}
          />
        </View>
      }
      { renderGraphs() }
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
    borderRadius: 12
  },
  textButtonGroup: {
		alignItems: 'center',
		fontSize: 22,
    fontWeight: 'bold',
    color: 'white'
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
	}
});

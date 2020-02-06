import React, { useState, useEffect } from 'react'
import {
  StyleSheet,
  View,
  Dimensions
} from 'react-native'
import {
  ButtonGroup,
  Text
} from 'react-native-elements'
import { API_HOST } from 'react-native-dotenv'
import gql from 'graphql-tag'
import { AsyncStorage } from 'react-native'
import ApolloClient from 'apollo-client'
import { setContext } from 'apollo-link-context'
import { createHttpLink } from 'apollo-link-http'
import { InMemoryCache } from 'apollo-cache-inmemory'
import BarChartComponent from '../graphics/BarChartComponent'
import PieChartComponent from '../graphics/PieChartComponent'

const httpLink = createHttpLink({
  uri: API_HOST,
});

const authLink = setContext(async (_, { headers }) => {
  // get the authentication token from local storage if it exists
  const userToken = await AsyncStorage.getItem('userToken');
  // return the headers to the context so httpLink can read them
  return {
    headers: {
      ...headers,
      Authorization: userToken ? `Bearer ${userToken}` : '',
    },
  };
});

const client = new ApolloClient({
  link: authLink.concat(httpLink),
  cache: new InMemoryCache(),
});

const StatsUserScreen = () => {

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

  const screenWidth = Dimensions.get('window').width

  const handleChange = (type) => {
    setTypeStats(type)
  }

  const component1 = () => <Text onPress = {() => handleChange('status')}>Status</Text>
  const component2 = () => <Text onPress = {() => handleChange('projects')}>Projects</Text>
  const component3 = () => <Text onPress = {() => handleChange('days')}>Days</Text>
  const buttons = [{ element: component1 }, { element: component2 }, { element: component3 }]

  const renderGraphs = () => {
    if (typeStats === 'status') {
      return (
        <PieChartComponent
          chartData = { dataStatus }
          screenWidth = { screenWidth }
          styleHorizontal = { styles.horizontal }
        />
      );
    }
    if (typeStats === 'projects') {
      return (
        <BarChartComponent
          chartData = { dataProjects }
          screenWidth = { screenWidth }
          styleHorizontal = { styles.horizontal }
        />
      );
    }
    if (typeStats === 'days') {
      return (
        <BarChartComponent
          chartData = { dataDays }
          screenWidth = { screenWidth }
          styleHorizontal = { styles.horizontal }
        />
      );
    }
  }
  return(
    <View style={styles.container}>
      <ButtonGroup
        buttons = { buttons }
        containerStyle={styles.buttonGroup}
      />
      {renderGraphs()}
    </View>
  );
}

StatsUserScreen.navigationOptions = {
  title: 'Statistics',
  headerTintColor: '#fff',
  headerStyle: {
    backgroundColor: '#808080',
  }
};

export default StatsUserScreen;

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
    top: 0,
    left: 0,
    right: 0,
    height: 70
  }
});

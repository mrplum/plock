import React from 'react';
import { createHttpLink } from 'apollo-link-http';
import { setContext } from 'apollo-link-context';
import { AsyncStorage, Text, View, TouchableHighlight } from 'react-native';
import ApolloClient from 'apollo-client';
import { InMemoryCache } from 'apollo-cache-inmemory';
import gql from 'graphql-tag';

import { Stopwatch } from 'react-native-stopwatch-timer';

const { useState } = React;

const httpLink = createHttpLink({
  uri: 'http://192.168.0.126:3300/graphql'
});

const authLink = setContext(async (_, { headers }) => {
  // get the authentication token from local storage if it exists
  const userToken = await AsyncStorage.getItem('userToken');
  // return the headers to the context so httpLink can read them
  return {
    headers: {
      ...headers,
      Authorization: userToken ? `Bearer ${userToken}` : ''
    }
  };
});

const client = new ApolloClient({
  link: authLink.concat(httpLink),
  cache: new InMemoryCache()
});
//  importing library to use Stopwatch and Timer
const TimerTrack = props => {
  const [idInterval, setIdInterval] = useState(0);
  const [isStopwatchStart, setStopwatchStart] = useState(false);
  const [resetStopwatch, setResetStopwatch] = useState(false);

  const resetStopwatchFunction = () => {
    setStopwatchStart(false);
    setResetStopwatch(true);
  };

  const startStopStopWatch = id => {
    setStopwatchStart(!isStopwatchStart);
    setResetStopwatch(false);

    if (!isStopwatchStart) {
      client
        .mutate({
          mutation: gql`
            mutation trackSetIntervalStart($track_id: ID!) {
              intervalStart(trackId: $track_id) {
                id
                track {
                  name
                }
                createdAt
                updatedAt
              }
            }
          `,
          variables: {
            track_id: id
          }
        })
        .then(result => JSON.parse(JSON.stringify(result)))
        .then(result => {
          setIdInterval(result.data.intervalStart.id);
        });
    } else {
      client
        .mutate({
          mutation: gql`
            mutation trackSetIntervalEnd($id: Int!) {
              intervalEnd(id: $id) {
                id
                createdAt
                updatedAt
                track {
                  name
                }
              }
            }
          `,
          variables: {
            id: idInterval
          }
        })
        .then(result => console.log(result));
    }
<<<<<<< HEAD
  };

  return (
    <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
      <View
        style={{
          flex: 1,
          marginTop: 32,
          alignItems: 'center',
          justifyContent: 'center'
        }}
      >
        <Stopwatch
          laps
          msecs
          start={isStopwatchStart}
          // To start
          reset={resetStopwatch}
          // To reset
          options={options}
          // options for the styling
        />
        <TouchableHighlight
          onPress={() =>
            startStopStopWatch(props.navigation.getParam('id', 'nada'))
          }
        >
          <Text style={{ fontSize: 20, marginTop: 10 }}>
            {isStopwatchStart ? 'STOP' : 'START'}
          </Text>
        </TouchableHighlight>
        <TouchableHighlight onPress={resetStopwatchFunction}>
          <Text style={{ fontSize: 20, marginTop: 10 }}>RESET</Text>
        </TouchableHighlight>
      </View>
    </View>
  );
};
=======
  }
  resetStopwatchFunction = () => {
    setStopwatchStart(false);
    setResetStopwatch(true);
  }

    return (
      <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
        <View
          style={{
            flex: 1,
            marginTop: 32,
            alignItems: 'center',
            justifyContent: 'center',
          }}>
          <Stopwatch
            laps
            msecs

            start={isStopwatchStart}
            //To start
            reset={resetStopwatch}
            //To reset
            options={options}
            //options for the styling
          />
          <TouchableHighlight onPress={() => startStopStopWatch(props.navigation.getParam('id','nada'))}>
            <Text style={{ fontSize: 20, marginTop: 10 }}>
              {isStopwatchStart ? 'STOP' : 'START'}
            </Text>
          </TouchableHighlight>
          <TouchableHighlight onPress={resetStopwatchFunction}>

            <Text style={{ fontSize: 20, marginTop: 10 }}>RESET</Text>
          </TouchableHighlight>
        </View>

      </View>
    );


}

const handleTimerComplete = () => alert('Custom Completion Function');
>>>>>>> 51dceaa824ed403cec4497599f79483f8f0a1ed3


export default TimerTrack;

<<<<<<< HEAD
/* eslint no-use-before-define: ["error", { "variables": false }] */
=======
>>>>>>> 51dceaa824ed403cec4497599f79483f8f0a1ed3

const options = {
  container: {
    backgroundColor: '#FF0000',
    padding: 5,
    borderRadius: 5,
    width: 200,
    alignItems: 'center'
  },
  text: {
    fontSize: 25,
    color: '#FFF',
    marginLeft: 7
  }
};

import React from 'react';
import {
  Image,
  Platform,
  ScrollView,
  StyleSheet,
  Button,
} from 'react-native';
import { API_HOST } from 'react-native-dotenv';
import { createHttpLink } from 'apollo-link-http';
import { setContext } from 'apollo-link-context';
import { AsyncStorage, Text, View, TouchableHighlight } from 'react-native';
import ApolloClient from 'apollo-client';
import { InMemoryCache } from 'apollo-cache-inmemory';
import gql from 'graphql-tag';

import { Stopwatch } from 'react-native-stopwatch-timer';

const { useState } = React;

const httpLink = createHttpLink({
  uri: API_HOST
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

    if (isStopwatchStart) {
      client
        .mutate({
          mutation: gql`
            mutation intervalDestroy($id: Int!) {
              intervalDestroy(id: $id) {
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
        }).then(result => JSON.parse(JSON.stringify(result)))
          .then(result => {
            console.log(result);
        });
    }

  };

  const startStopStopWatch = async id => {
    setStopwatchStart(!isStopwatchStart);
    setResetStopwatch(false);

    const userId = await AsyncStorage.getItem('userId');

    if (!isStopwatchStart) {
      const Datetime = new Date();
    const f = Datetime.toString();
      client
        .mutate({
          mutation: gql`
            mutation trackSetIntervalStart($track_id: ID!, $user_id: ID!, $start_at: String! ) {
              intervalStart(trackId: $track_id, userId: $user_id, startAt: $start_at) {
                id
                track {
                  name
                }
              }
            }
          `,
          variables: {
            track_id: id,
            user_id: userId,
            start_at: f,
            
          }
        })
        .then(result => JSON.parse(JSON.stringify(result)))
        .then(result => {
          setIdInterval(result.data.intervalStart.id);
        });
    } else {
    const Datetime = new Date();
    const fecha = Datetime.toString();
      client
        .mutate({
          mutation: gql`
            mutation trackSetIntervalEnd($id: Int!, $end_at: String!) {
              intervalEnd(id: $id, endAt: $end_at) {
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
            id: idInterval,
            end_at: fecha
          }
        })
        .then(result => console.log(result));
    }
  };
  const choose = props.navigation.getParam('track', 'nothing');
  const id = choose.id;

  return (
    <View style={styles.container}>
      <View
        style={{
          flex: 1,
          marginTop: 32,
          alignItems: 'center',
          justifyContent: 'center'
        }}
      >
        <Text style={styles.welcomeContainer}>
          Description of the track: {choose.description}
        </Text>
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
            startStopStopWatch(id)
          }
        >
          <Text style={styles.welcome}>
            {isStopwatchStart ? 'STOP' : 'START'}
          </Text>
        </TouchableHighlight>
        <TouchableHighlight onPress={resetStopwatchFunction}>
          <Text style={styles.welcome}>RESET</Text>
        </TouchableHighlight>
      </View>
    </View>
  );
};

export default TimerTrack;

TimerTrack.navigationOptions = {
  title: 'TrackTimer',
  headerStyle: {
      backgroundColor: '#808080',
     },headerTintColor: '#fff',

};

/* eslint no-use-before-define: ["error", { "variables": false }] */

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#808080'
  },
  contentContainer: {
    paddingTop: 30
  },
  welcomeContainer: {
    textAlign: 'center',
    fontSize: 20,
    color: 'white',
  },
  welcomeImage: {
    width: 251,
    height: 251,
    marginTop: 35,
    resizeMode: 'contain',
    marginLeft: 0
  },
  welcome: {
    fontSize: 25,
    textAlign: 'center',
    color: 'white',
    marginTop: 15
  },
  getStartedContainer: {
    alignItems: 'center',
    marginHorizontal: 50
  },
  homeScreenFilename: {
    marginVertical: 7
  },
  codeHighlightText: {
    color: 'rgba(96,100,109, 0.8)'
  },
  codeHighlightContainer: {
    backgroundColor: 'rgba(0,0,0,0.05)',
    borderRadius: 3,
    paddingHorizontal: 4
  },
  getStartedText: {
    fontSize: 17,
    color: 'rgba(96,100,109, 1)',
    lineHeight: 24,
    textAlign: 'center'
  },
  tabBarInfoContainer: {
    position: 'absolute',
    bottom: 0,
    left: 0,
    right: 0,
    ...Platform.select({
      ios: {
        shadowColor: 'black',
        shadowOffset: { height: -3 },
        shadowOpacity: 0.1,
        shadowRadius: 3
      },
      android: {
        elevation: 20
      }
    }),
    alignItems: 'center',
    backgroundColor: '#fbfbfb',
    paddingVertical: 20
  },
  tabBarInfoText: {
    fontSize: 17,
    color: 'rgba(96,100,109, 1)',
    textAlign: 'center'
  },
  navigationFilename: {
    marginTop: 5
  },
  helpContainer: {
    marginTop: 15,
    alignItems: 'center'
  },
  helpLink: {
    paddingVertical: 15
  },
  helpLinkText: {
    fontSize: 14,
    color: '#2e78b7'
  },
  logout: {
    marginTop: 130,
    fontSize: 16,
    color: '#ffffff',
    textAlign: 'center'
  },
  button: {
    marginTop: 15,
    color: 'rgba(0,0,0, 1)',
    paddingRight: 40,
    paddingLeft: 40
  },
  move: {
    marginTop: 10
  }
});

const options = {
  container: {
    marginTop: 35,
    backgroundColor: '#ad0404',
    padding: 5,
    borderRadius: 5,
    width: 200,
    alignItems: 'center'
  },
  text: {
    fontSize: 25,
    color: '#ffffff',
    marginLeft: 7,
  }
};

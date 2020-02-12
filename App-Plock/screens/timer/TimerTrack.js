import React from 'react';
import {
  Image,
  Platform,
  ScrollView,
  StyleSheet,
  Button,
  AsyncStorage,
  Text,
  View,
  TouchableHighlight,
} from 'react-native';
import clientApollo from '../../util/clientApollo';
import gql from 'graphql-tag';
import { Stopwatch } from 'react-native-stopwatch-timer';
import { AuthContext } from "../../components/StateContextProvider";

const { useState } = React;

const TimerTrack = props => {

  const { state, dispatch } = React.useContext(AuthContext);

  const client = clientApollo();

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
        });
    }

  };

  const startStopWatch = async id => {
    setStopwatchStart(!isStopwatchStart);
    setResetStopwatch(false);

    const userId = state.user;

    if (!isStopwatchStart) {
      const Datetime = new Date();
      const fech = Datetime.toString();

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
            start_at: fech,
          }
        })
        .then(result => JSON.parse(JSON.stringify(result)))
        .then(result => {
          setIdInterval(result.data.intervalStart.id);
          dispatch({
            type: "START"
          });
        });
    } else {
      const Datetime = new Date();
      const fecha = Datetime.toString();

      client
        .mutate({
          mutation: gql`
            mutation trackSetIntervalEnd($id: ID!, $end_at: String!) {
              intervalEnd(id: $id, endAt: $end_at) {
                id
              }
            }
          `,
          variables: {
            id: idInterval,
            end_at: fecha
          }
        })
        .then(result => {
          dispatch({
            type: "FINISHED"
          });
        })
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
            startStopWatch(choose.id)
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
  welcomeContainer: {
    textAlign: 'center',
    fontSize: 20,
    color: 'white',
  },
  welcome: {
    fontSize: 25,
    textAlign: 'center',
    color: 'white',
    marginTop: 15
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

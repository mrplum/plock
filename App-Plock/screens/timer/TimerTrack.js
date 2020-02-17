import React, { useState } from 'react';
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
  TextInput, 
  KeyboardAvoidingView,
} from 'react-native';
import clientApollo from '../../util/clientApollo';
import gql from 'graphql-tag';
import { Stopwatch } from 'react-native-stopwatch-timer';
import { StackActions } from '@react-navigation/native';
import { AuthContext, Chronometer } from "../../components/StateContextProvider";

const TimerTrack = props => {
  
  const { state, dispatch } = React.useContext(AuthContext);

  const client = clientApollo();

  const [intervalDesc, setIntervalDesc] = useState({
    description: ''
  });

  const choose = props.navigation.getParam('track', 'nothing');
  const timePast = props.navigation.getParam('timerStart', 0);
  const id = choose.id;
  const userId = state.user;
  const intervalId = state.interval;

  const resetStopwatchFunction = () => {

    if (state.working) {

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
            id: intervalId
          }
        }).then(result => JSON.parse(JSON.stringify(result)))
          .then(result => {
        });
    }

  };

  const startStopWatch = () => {

    if (state.working == false) {
      const Datetime = new Date();
      const fech = Datetime.toString();

      client
        .mutate({
          mutation: gql`
            mutation trackSetIntervalStart($track_id: ID!, $user_id: ID!, $start_at: String!, $description: String ) {
              intervalStart(trackId: $track_id, userId: $user_id, startAt: $start_at, description: $description) {
                id
                track {
                  name
                }
              }
            }
          `,
          variables: {
            track_id: choose.id,
            user_id: userId,
            start_at: fech,
            description: intervalDesc.description
          }
        })
        .then(result => JSON.parse(JSON.stringify(result)))
        .then(result => {
          dispatch({
            type: "SETINTERVAL",
            payload: result.data.intervalStart.id
          });
          dispatch({
            type: "START"
          });
          dispatch({
            type: "SETDATE",
            payload: Datetime
          });
        });
    } else {
      const Dateclock = new Date();
      const fecha = Dateclock.toString();

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
            id: intervalId,
            end_at: fecha,
          }
        })
        .then(result => {
          dispatch({
            type: "REMOVEINTERVAL"
          });
          dispatch({
            type: "FINISHED"
          });
          dispatch({
            type: "REMOVEDATE"
          });
          alert('Plock-Time loaded succesfully');
        })
    }
  };

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

        {!state.working &&
          <TextInput
            style={styles.TextInputStyleClass}
            underlineColorAndroid="transparent"
            placeholder="What are you going to work today."
            onChangeText={value => setIntervalDesc({ description: value })}
            value={intervalDesc.description}
            placeholderTextColor={"#ffffff"}
            numberOfLines={15}
            multiline={true}
          />
        }
        <Chronometer running={state.working} workDate={timePast} />

        <TouchableHighlight
          onPress={startStopWatch} >

          <Text style={styles.welcome}>
            {state.working ? 'STOP' : 'START'}
          </Text>

        </TouchableHighlight>

        <TouchableHighlight disabled={!state.working} onPress={resetStopwatchFunction}>

          <Text style={styles.welcome}>RESET</Text>

        </TouchableHighlight>

        <View style={styles.button}>
          <Button
            color = '#37435D'
            title = 'Back to home'
            onPress={() => props.navigation.navigate('Home')}
          />
        </View>

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
  },
  button: {
    marginTop: 15,
    color: 'rgba(0,0,0, 1)',
    paddingRight: 40,
    paddingLeft: 40
  },
  TextInputStyleClass:{
    fontSize: 18,
    textAlign: 'auto', 
    height: 50,
    borderWidth: 2,
    borderColor: 'white',
    borderRadius: 20 ,
    backgroundColor: "#a0a0a0",
    height: 150,
    color: 'white',
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

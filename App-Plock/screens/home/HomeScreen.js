import React,{ useState } from 'react';
import {
  TouchableHighlight,
  Image,
  Platform,
  ScrollView,
  StyleSheet,
  Text,
  Button,
  View,
  AsyncStorage
} from 'react-native';
import {
Icon
} from 'react-native-elements';
import gql from 'graphql-tag';
import { Stopwatch } from 'react-native-stopwatch-timer';
import clientApollo from '../../util/clientApollo';
import stateContext from '../../components/StateContext';
import { AuthContext, Chronometer } from "../../components/StateContextProvider";

const HomeScreen = (props) => {

  const { state, dispatch } = React.useContext(AuthContext);

  const client = clientApollo();

  const handleCreateTrack = () => {
    props.navigation.navigate('Projects');
  };

  const handleSeeTracks = () => {
    props.navigation.navigate('Tracks');
  };

  const handleStatsUser = () => {
    props.navigation.navigate('StatsUser');
  };

  const handleWorkTrack = track => {
      const date = new Date();
      const contextDate = state.workingDate;
      const timer = date.getTime() - contextDate.getTime();
      props.navigation.navigate('Tracker', { timerStart: timer});
  };

  const handleLogout = async () => {
    client
      .mutate({
        mutation: gql`
          mutation {
            logout
          }
        `
      })
      .then(dispatch({
            type: "LOGOUT"
          });
      .then(props.navigation.navigate('Auth'))
      );
  };

  return (
    <View style={styles.container}>

      <Icon
        name='sign-out'
        color='#ffffff'
        type='font-awesome'
        onPress={handleLogout}
        iconStyle={styles.iconPos}
        size={30}
      />

      <ScrollView
        style={styles.container}
        contentContainerStyle={styles.contentContainer}
      >

        <View style={styles.welcomeContainer}>

          <Image
            source={ require('../../assets/images/plock.png') }
            style={styles.welcomeImage}
          />

        </View>

        <Text style={styles.welcome}>¿What do you want to do?</Text>

        <View style={styles.move}>

          <View style={styles.button}>
            <Button
              color = '#ad0404'
              title = 'Create Track'
              onPress={handleCreateTrack}
            />
          </View>

          <View style={styles.button}>
            <Button
              color = '#37435D'
              title = 'See my tracks'
              onPress={handleSeeTracks}
              disabled={state.working}
            />
          </View>

          <View style={styles.button}>
            <Button
              color = '#37435D'
              title = 'Stats'
              onPress={handleStatsUser}
            />
          </View>

        </View>

      </ScrollView>

      {state.working &&
        <TouchableHighlight onPress={ handleWorkTrack } >
          <View style={styles.cen}>
            <Chronometer running={state.working} />
          </View>
        </TouchableHighlight>
      }

    </View>
  )
};

export default HomeScreen;

HomeScreen.navigationOptions = {
  header: null
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
    alignItems: 'center',
    marginTop: -50,
  },
  welcomeImage: {
    width: 251,
    height: 251,
    marginTop: 35,
    resizeMode: 'contain',
    marginLeft: 0
  },
  welcome: {
    fontSize: 17,
    textAlign: 'center',
    color: 'white',
    marginTop: 1
  },
  button: {
    marginTop: 15,
    color: 'rgba(0,0,0, 1)',
    paddingRight: 40,
    paddingLeft: 40
  },
  move: {
    marginTop: 10
  },
  iconPos: {
    marginTop: 38,
    marginLeft: 300
  },
  cen: {
    alignItems: 'center',
  }
});

const options = {
  container: {
    marginTop: 35,
    backgroundColor: '#ad0404',
    padding: 5,
    borderRadius: 5,
    width: 200,
    alignItems: 'center',
    marginLeft: 80
  },
  text: {
    fontSize: 25,
    color: '#ffffff',
    marginLeft: 7,
  }
};

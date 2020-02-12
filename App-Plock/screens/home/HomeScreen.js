import React from 'react';
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
import { AuthContext } from "../../components/StateContextProvider";

const { useState } = React;


const HomeScreen = (props) => {

  const { state, dispatch } = React.useContext(AuthContext);

  const client = clientApollo();

  const [isStopwatchStart, setStopwatchStart] = useState(false);
  const [resetStopwatch, setResetStopwatch] = useState(false);

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
      props.navigation.navigate('Tracker', { 'track': track });
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
      .then(AsyncStorage.removeItem('userToken'))
      .then(props.navigation.navigate('Auth'));
  };

  return !state.working ? (
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
      </View>
  ): (
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
        <TouchableHighlight onPress={ handleWorkTrack } >
          <Stopwatch
            laps
            msecs
            start={isStopwatchStart}
            reset={resetStopwatch}
            options={options}
          />
        </TouchableHighlight>
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
  },
  iconPos: {
    marginTop: 38,
    marginLeft: 300

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
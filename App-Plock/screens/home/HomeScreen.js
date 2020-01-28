import React from 'react';
import {
  Image,
  Platform,
  ScrollView,
  StyleSheet,
  Text,
  Button,
  TouchableOpacity,
  View,
} from 'react-native';
import { createHttpLink } from 'apollo-link-http';
import { setContext } from 'apollo-link-context';
import {AsyncStorage} from 'react-native';
import ApolloClient from 'apollo-client';
import { InMemoryCache } from 'apollo-cache-inmemory';
import gql from 'graphql-tag';

const httpLink = createHttpLink({
  uri: 'http://192.168.0.126:3300/graphql' ,
});


const authLink = setContext(async (_, { headers }) => {
  // get the authentication token from local storage if it exists
  const userToken = await AsyncStorage.getItem('userToken');
  // return the headers to the context so httpLink can read them
  return {
    headers: {
      ...headers,
      Authorization: userToken ? `Bearer ${userToken}` : "",
    }
  }
});

const client = new ApolloClient({
  link: authLink.concat(httpLink),
  cache: new InMemoryCache()
});


const HomeScreen = (props) =>{

  _handleCreateTrack = async () => {
  };

  _handleSeeTracks = async () => {
    props.navigation.navigate('Tracks');
  };

  _handleSeeProjects = async () => {
  };

  _handleStats = async () => {
  };

  _handleLogout = async () => {
    client.mutate({
        mutation: gql`mutation{
                  logout
                }`
    }).then(AsyncStorage.removeItem('userToken'))
      .then(AsyncStorage.removeItem('userId'))
      .then(props.navigation.navigate('Auth'))
  };

  return (
    <View style={styles.container}>
      <ScrollView style={styles.container} contentContainerStyle={styles.contentContainer}>
        <View style={styles.welcomeContainer}>
          <Image
            source={
              __DEV__
                ? require('./plock.png')
                : require('./robot-prod.png')
            }
            style={styles.welcomeImage}
          />
        </View>
        <Text style={styles.welcome}>
           ¿What do you want to do?
        </Text>
        <View style={styles.move}>
          <View style={styles.button}>
            <Button color="#F2B558" title="Create Track" onPress={_handleCreateTrack} />
          </View>

          <View style={styles.button}>
            <Button color="#37435D" title="See my tracks" onPress={_handleSeeTracks} />
          </View>

          <View style={styles.button}>
            <Button color="#37435D" title="See my projects" onPress={_handleSeeProjects} />
          </View>

          <View style={styles.button}>
            <Button color="#37435D" title="See my stats" onPress={_handleStats} />
          </View>

          <Text onPress={_handleLogout} style={styles.logout}>
            Cerrar Sesión
          </Text>
        </View>
      </ScrollView>
    </View>
  );

}

export default HomeScreen;

HomeScreen.navigationOptions = {
  header: null,
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#6b7a8f',
  },
  contentContainer: {
    paddingTop: 30,
  },
  welcomeContainer: {
    alignItems: 'center',
    marginTop: 10,
    marginBottom: 20,
  },
  welcomeImage: {
    width: 251,
    height: 251,
    marginTop: 70,
    resizeMode: 'contain',
    marginLeft: 0,
  },
  welcome: {
    fontSize: 17,
    textAlign: 'center',
    color: 'white',
    marginTop:30,
  },
  getStartedContainer: {
    alignItems: 'center',
    marginHorizontal: 50,
  },
  homeScreenFilename: {
    marginVertical: 7,
  },
  codeHighlightText: {
    color: 'rgba(96,100,109, 0.8)',
  },
  codeHighlightContainer: {
    backgroundColor: 'rgba(0,0,0,0.05)',
    borderRadius: 3,
    paddingHorizontal: 4,
  },
  getStartedText: {
    fontSize: 17,
    color: 'rgba(96,100,109, 1)',
    lineHeight: 24,
    textAlign: 'center',
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
        shadowRadius: 3,
      },
      android: {
        elevation: 20,
      },
    }),
    alignItems: 'center',
    backgroundColor: '#fbfbfb',
    paddingVertical: 20,
  },
  tabBarInfoText: {
    fontSize: 17,
    color: 'rgba(96,100,109, 1)',
    textAlign: 'center',
  },
  navigationFilename: {
    marginTop: 5,
  },
  helpContainer: {
    marginTop: 15,
    alignItems: 'center',
  },
  helpLink: {
    paddingVertical: 15,
  },
  helpLinkText: {
    fontSize: 14,
    color: '#2e78b7',
  },
  logout: {
    marginTop:90,
    fontSize: 16,
    color: '#ffffff',
    textAlign: 'center',
  },
  button: {
    marginTop:15,
    color: 'rgba(0,0,0, 1)',
    paddingRight: 40,
    paddingLeft: 40,
  },
  move: {
    marginTop: 10,
  }
});

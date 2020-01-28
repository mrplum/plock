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
import { useEffect, useState } from 'react';


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



const TracksList = ({props}) => {

  const [list, setList] = useState([]);

  useEffect(() => {
    client.query({
      query: gql`{
        user {
          name
          email
          tracks {
            id
            name
            status
          }
        }  
      }`,
    }).then(result => JSON.parse(JSON.stringify(result)))
      .then(result => {
        setList( result.data.user.tracks );
    }).catch((error) => {
        alert("Username o Password incorrecto");
        console.log(error)
        return;
    });        
  }, [list]);

const hackerList = list.map(track => {

  _handleWorkTrack = async () => {

  };

  return (
    <View key={track.id}>
      <Text style={styles.welcome}>
       The name of the track is: {track.name}
      </Text>
      <View style={styles.button}>
        <Button color="#F2B558" title="Start to work in this track" onPress={_handleWorkTrack} ></Button>
      </View>
    </View>
  );
});

  return(
    <View style={styles.container}>
      {hackerList}

    </View>
    );
}

export default TracksList;

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
    marginTop:18,
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
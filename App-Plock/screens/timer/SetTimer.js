import React, { useState } from "react";
import { Button, View, Text, Platform, StyleSheet, AsyncStorage } from "react-native";
import DateTimePickerModal from "react-native-modal-datetime-picker";
import { API_HOST } from 'react-native-dotenv';
import { createHttpLink } from 'apollo-link-http';
import { setContext } from 'apollo-link-context';
import ApolloClient from 'apollo-client';
import { InMemoryCache } from 'apollo-cache-inmemory';
import gql from 'graphql-tag';


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

const SetTimer = (props) => {
  const [isDatePickerVisible, setDatePickerVisibility] = useState(false);
  const [idInterval, setIdInterval] = useState(0);

  const choose = props.navigation.getParam('track', 'nothing');
  //const id = choose.id;

  const showDatePicker = () => {
    setDatePickerVisibility(true);
  };

  const hideDatePicker = () => {
    setDatePickerVisibility(false);
  };

  const handleInit = async (date) => {

    const userId = await AsyncStorage.getItem('userId');
    const dateTime = date.toString();
    client
        .mutate({
          mutation: gql`
            mutation trackSetIntervalStart($track_id: ID!, $user_id: ID!, $start_at: String! ) {
              intervalStart(trackId: $track_id, userId: $user_id, startAt: $start_at) {
                track {
                  name
                }
              }
            }
          `,
          variables: {
            track_id: choose.id,
            user_id: userId,
            start_at: dateTime
          }
        }).then(result => JSON.parse(JSON.stringify(result)))
          .then(result => {
            setIdInterval(result.data.intervalStart.id);
            hideDatePicker()
        })
          .catch(error => {
            console.log(error);
            alert(error); // eslint-disable-line no-alert
      });

  };

  const handleEnd = date => {
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
        .then(result => console.log(result))
        .then(result => {
          hideDatePicker();
        });
  };

  return (
    <View style={styles.container}>

      <Text style={styles.welcome}>
        Select the date and time that you begin to work in the track.
      </Text>

      <View style={styles.button}>
        <Button title="Set Begin Date" onPress={ showDatePicker } color="#ad0404" />
      </View>

      <DateTimePickerModal
        isVisible={ isDatePickerVisible }
        mode="datetime"
        is24Hour={true}
        onConfirm={ handleInit }
        onCancel={ hideDatePicker }
      />

      <Text style={styles.welcome}>
        Select the date and time that you end the work in the track.
      </Text>

      <View style={styles.button}>
        <Button title="Set End Date" onPress={ showDatePicker } color="#ad0404" />
      </View>      
      
      <DateTimePickerModal
        isVisible={ isDatePickerVisible }
        mode="datetime"
        display="spinner"
        is24Hour={true}
        onConfirm={ () => handleEnd(choose.id)  }
        onCancel={ hideDatePicker }
      />

    </View>
  );
};

export default SetTimer;

SetTimer.navigationOptions = {
  title: 'Set the start and end date',
  headerStyle: {
      backgroundColor: '#808080',
     },headerTintColor: '#fff',

};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#808080',
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
    marginTop: 18,
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
    marginTop: 90,
    fontSize: 16,
    color: '#ffffff',
    textAlign: 'center',
  },
  button: {
    marginTop: 15,
    color: 'rgba(0,0,0, 1)',
    paddingRight: 40,
    paddingLeft: 40,
  },
  move: {
    marginTop: 10,
  },
});
import React from 'react';
import {
  View,
  Image,
  Text,
  TextInput,
  Button,
  StyleSheet,
  AsyncStorage
} from 'react-native';
import { API_HOST } from 'react-native-dotenv';
import ApolloClient from 'apollo-boost';
import gql from 'graphql-tag';

const client = new ApolloClient({ uri: API_HOST });
const { useState } = React;

export const CreateTrackScreen = props => {
  const choose = props.navigation.getParam('project', 'nothing');
  const id = choose.id;

  const [trackName, setTrackName] = useState({
    name: ''
  });

  const [trackDesc, setTrackDesc] = useState({
    description: ''
  });

  const createTrack = async (id) => {
    console.log(id);
    console.log(trackName);
    const userid = await AsyncStorage.getItem('userId');
    console.log(userid);
    console.log(id);
    client
      .mutate({
        mutation: gql`
          mutation createTrack($project_id: ID!, $user_id: ID!, $name: String!, $description: String!) {
            trackCreate(projectId: $project_id, userId: $user_id, name: $name, description: $description) {
              name
              description
          }
        }
        `,
        variables: {
          project_id: id,
          user_id: userid,
          name: trackName.name,
          description: trackDesc.description,
        }
      })
      .then(result => JSON.parse(JSON.stringify(result)))
      .then(result => {
        console.log(result);
      })
      .catch(error => {
        alert('Username o Password incorrecto'); // eslint-disable-line no-alert
      });
  };

  return (
    <View style={styles.container}>

      <Text style={styles.welcome}>
        The name of the project is:
        {choose.name}
      </Text>

      <View >
        <TextInput
          placeholder="Name of the track"
          style={styles.input1}
          onChangeText={value => setTrackName({ name: value })}
          value={trackName.name}
          maxLength={30}
        />

        <TextInput
          style={styles.TextInputStyleClass}
          underlineColorAndroid="transparent"
          placeholder="Enter the description of the track."
          onChangeText={value => setTrackDesc({ description: value })}
          value={trackDesc.description}
          placeholderTextColor={"#ffffff"}
          numberOfLines={15}
          multiline={true}
        />

      </View>
      <View style={styles.centerButton}>
        <View style={styles.button}>
          <Button color="#ad0404" title="Create Track" onPress={() =>
            createTrack(id)
          } />
        </View>
      </View>
    </View>
  );
};

export default CreateTrackScreen;

CreateTrackScreen.navigationOptions = {
  title: 'Create a Track',
  headerStyle: {
      backgroundColor: '#808080',
     },headerTintColor: '#fff',
};

/* eslint no-use-before-define: ["error", { "variables": false }] */

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    backgroundColor: '#808080'
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    color: 'white',
    marginBottom: 80,
  },
  input1: {
    margin: 15,
    marginTop: 2,
    height: 30,
    padding: 5,
    paddingRight: 15,
    paddingLeft: 15,
    fontSize: 16,
    marginBottom: 10,
    color: 'white',
    borderBottomWidth: 1,
    borderBottomColor: '#FFFFFF',
  },
  button: {
    margin: 10,
    paddingTop: 4,
    paddingBottom: 1,
    paddingRight: 40,
    paddingLeft: 40,
    marginTop: 5,
    width: 300,
    color: '#F13E3E',
  },
  acomodar: {
    marginBottom: 50
  },
  centerButton: {
    alignItems: 'center',
    paddingTop: 25
  },
  TextInputStyleClass:{
    fontSize: 18,
    textAlign: 'center',
    height: 50,
    borderWidth: 2,
    borderColor: 'white',
    borderRadius: 20 ,
    backgroundColor: "#a0a0a0",
    height: 150,
    color: 'white',
    }
});

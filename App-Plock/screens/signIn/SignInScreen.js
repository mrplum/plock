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

import ApolloClient from 'apollo-boost';
import gql from 'graphql-tag';

const client = new ApolloClient({ uri: 'http://192.168.0.126:3300/graphql' });
const { useState } = React;

export const SignInScreen = props => {
  const [pass, setPass] = useState({
    password: ''
  });

  const [email, setEmail] = useState({
    email: ''
  });

  const signIn = async () => {
    client
      .mutate({
        mutation: gql`
          mutation login($email: String!, $password: String!) {
            login(email: $email, password: $password) {
              user {
                id
                token
              }
              errors
            }
          }
        `,
        variables: {
          email: email.email,
          password: pass.password
        }
      })
      .then(result => JSON.parse(JSON.stringify(result)))
      .then(result => {
        AsyncStorage.setItem('userToken', result.data.login.user.token);
        AsyncStorage.setItem('userId', result.data.login.user.id);
        props.navigation.navigate('Home');
      })
      .catch(error => {
        alert('Username o Password incorrecto'); // eslint-disable-line no-alert
        console.log(error);
      });
  };

  return (
    <View style={styles.container}>
      <View style={styles.welcomeContainer}>
        <Image
          source={
            __DEV__
              ? require('../home/68930.png')
              : require('../home/robot-prod.png')
          }
          style={styles.welcomeImage}
        />
      </View>

      <View style={styles.acomodar}>
        <Text style={styles.getStartedText}>Inicia sesión</Text>

        <View style={styles.inputPlus}>
          <TextInput
            placeholder="Email"
            style={styles.input1}
            onChangeText={value => setEmail({ email: value })}
            value={email.email}
            maxLength={30}
          />

          <TextInput
            maxLength={20}
            placeholder="Password"
            style={styles.input2}
            secureTextEntry
            onChangeText={value => setPass({ password: value })}
            value={pass.password}
          />
        </View>
        <View style={styles.centerButton}>
          <View style={styles.button}>
            <Button color="#F2B558" title="Iniciar Sesion" onPress={signIn} />
          </View>

          <View style={styles.button}>
            <Button color="#37435D" title="Crear usuario" />
          </View>
        </View>
      </View>
    </View>
  );
};

export default SignInScreen;

SignInScreen.navigationOptions = {
  header: null
};

/* eslint no-use-before-define: ["error", { "variables": false }] */

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    backgroundColor: '#6b7a8f'
  },
  welcomeImage: {
    width: 250,
    height: 250,
    resizeMode: 'contain',
    marginTop: -10,
    marginLeft: 0
  },
  welcomeContainer: {
    alignItems: 'center',
    marginTop: 10,
    marginBottom: 25
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10
  },
  input1: {
    margin: 15,
    marginTop: 8,
    height: 30,
    padding: 5,
    paddingRight: 144,
    paddingLeft: 15,
    fontSize: 16,
    marginBottom: 10,
    color: 'white',
    borderBottomWidth: 1,
    borderBottomColor: '#FFFFFF',
    alignSelf: 'flex-start'
  },
  input2: {
    margin: 15,
    marginTop: 8,
    height: 30,
    padding: 5,
    paddingRight: 104,
    paddingLeft: 15,
    fontSize: 16,
    marginBottom: 10,
    color: 'white',
    borderBottomWidth: 1,
    borderBottomColor: '#FFFFFF',
    alignSelf: 'flex-start'
  },
  inputPlus: {
    paddingLeft: 89,
    paddingTop: 20
  },
  getStartedText: {
    marginTop: -10,
    fontSize: 17,
    color: '#37435D',
    lineHeight: 32,
    textAlign: 'center',
    backgroundColor: '#FFFFFF',
    height: 35
  },
  button: {
    margin: 10,
    paddingTop: 4,
    paddingBottom: 1,
    paddingRight: 40,
    paddingLeft: 40,
    marginTop: 5,
    width: 300,
    color: '#F13E3E'
  },
  acomodar: {
    marginBottom: 50
  },
  centerButton: {
    alignItems: 'center',
    paddingTop: 25
  }
});

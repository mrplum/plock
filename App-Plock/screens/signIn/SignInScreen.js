import React from 'react';
import {
  View,
  Image,
  Text,
  StyleSheet,
  AsyncStorage,
  KeyboardAvoidingView
} from 'react-native';
import {
	Input,
	Button,
	Icon
} from 'react-native-elements';
import { API_HOST } from 'react-native-dotenv';
import ApolloClient from 'apollo-boost';
import gql from 'graphql-tag';

const client = new ApolloClient({ uri: API_HOST });
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
      });
  };

  return (
    <View style={styles.container}>
      
      <KeyboardAvoidingView
        style={styles.container}
        behavior='position'
        keyboardVerticalOffset={28}
      >

      
      
      
      
      <View style={styles.welcomeContainer}>
        <Image
          source={ require('../../assets/images/plock.png') }
          style={styles.welcomeImage}
        />
      </View>

      <Text style={styles.getStartedText}>Log in</Text>

      <Input
        placeholder=' Email'
        style={styles.input}
        onChangeText={value => setEmail({ email: value })}
        value={email.email}
        maxLength={30}
        leftIcon={
          <Icon
            name='email'
            color='#000000'
          />
        }
      />

      <Input
        maxLength={20}
        placeholder=' Password'
        style={styles.input}
        secureTextEntry
        onChangeText={value => setPass({ password: value })}
        value={pass.password}
        leftIcon={
          <Icon
            name='lock'
            color='#000000'
          />
        }
      />

      <View style={styles.SeparatorLine} />

      <View style={styles.center}>
          <Button 
            buttonStyle={styles.button}
            title='Log in'
            onPress={signIn}
          />
      </View>

      </KeyboardAvoidingView>

    </View>
  );
};

export default SignInScreen;

SignInScreen.navigationOptions = {
  header: null
};


const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    backgroundColor: '#808080'
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
  input: {
		margin: 15,
		height: 40,
		padding: 5,
		fontSize: 16,
		borderBottomWidth: 1,
		borderBottomColor: '#000000'
	},
  inputPlus: {
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
    height: 50,
    width: 150,
    backgroundColor: '#8b0000',
    borderRadius: 10
  },
  center: {
    alignItems:'center',
  	justifyContent:'center'
  },
  SeparatorLine :{
		height: 40
	}
});

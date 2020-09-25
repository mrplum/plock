import React from 'react';
import {
  View,
  Image,
  Text,
  TextInput,
  StyleSheet,
  TouchableOpacity,
  KeyboardAvoidingView
} from 'react-native';
import { API_HOST } from 'react-native-dotenv';
import ApolloClient from 'apollo-boost';
import gql from 'graphql-tag';

import { AuthContext } from "../../components/StateContextProvider";


const client = new ApolloClient({ uri: API_HOST });
const { useState } = React;

export const SignInScreen = props => {
  const [pass, setPass] = useState({
    password: ''
  });

  const [email, setEmail] = useState({
    email: ''
  });

  const { dispatch } = React.useContext(AuthContext);
  
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
        dispatch({
          type: "LOGIN",
          payload: result.data.login
        });
        props.navigation.navigate('Home');
      })
      .catch(error => {
        console.log(error);
        alert('Username o Password incorrecto'); // eslint-disable-line no-alert
      });
  };

  return (
    <View style={styles.container}>
        <View style={styles.welcomeContainer}>
          <Image
            source={ require('../../assets/images/plock.png') }
            style={styles.welcomeImage}
          />
        </View>

        <View style={styles.input} >
          <TextInput
            style={styles.inputText}
            placeholder="Email..."
            placeholderTextColor="#003f5c"
            value={email.email}
            onChangeText={value => setEmail({email:value})}/>
        </View>

        <View style={styles.input} >
          <TextInput
            secureTextEntry
            style={styles.inputText}
            placeholder="Password..."
            placeholderTextColor="#003f5c"
            value={pass.password}
            onChangeText={value => setPass({password:value})}/>
        </View>

        <TouchableOpacity>
          <Text style={styles.forgot}>Forgot Password?</Text>
        </TouchableOpacity>
        <TouchableOpacity style={styles.loginBtn} onPress={signIn} >
          <Text style={styles.loginText}>LOGIN</Text>
        </TouchableOpacity>
        <TouchableOpacity>
          <Text style={styles.loginText}>Signup</Text>
        </TouchableOpacity>
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
    backgroundColor: '#003f5c',
    alignItems: 'center',
    justifyContent: 'center',
  },
  welcomeImage: {
    width: 250,
    height: 250,
    resizeMode: 'contain',
    marginTop: -10,
    marginLeft: 0
  },
  welcomeContainer: {
    fontWeight:"bold",
    fontSize:50,
    color:"#fb5b5a",
    marginBottom:40
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10
  },
  input: {
    width:"80%",
    backgroundColor:"#465881",
    borderRadius:25,
    height:50,
    marginBottom:20,
    justifyContent:"center",
    padding:20
  },
  inputText: {
    height:50,
    color:"white"
  },
  forgot:{
    color:"white",
    fontSize:11
  },
  loginBtn:{
    width:"80%",
    backgroundColor:"#fb5b5a",
    borderRadius:25,
    height:50,
    alignItems:"center",
    justifyContent:"center",
    marginTop:40,
    marginBottom:10
  },
  loginText:{
    color:"white"
  }
});

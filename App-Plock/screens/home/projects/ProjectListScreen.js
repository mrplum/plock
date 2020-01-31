import React,{ useEffect, useState } from 'react';
import {
  Platform, StyleSheet, Text, Button, View
} from 'react-native';
import { API_HOST } from 'react-native-dotenv';
import { createHttpLink } from 'apollo-link-http';
import { setContext } from 'apollo-link-context';
import { AsyncStorage } from 'react-native';
import ApolloClient from 'apollo-client';
import { InMemoryCache } from 'apollo-cache-inmemory';
import gql from 'graphql-tag';


const httpLink = createHttpLink({

  uri: API_HOST,

});

const authLink = setContext(async (_, { headers }) => {
  // get the authentication token from local storage if it exists
  const userToken = await AsyncStorage.getItem('userToken');
  // return the headers to the context so httpLink can read them
  return {
    headers: {
      ...headers,
      Authorization: userToken ? `Bearer ${userToken}` : '',
    },
  };
});

const client = new ApolloClient({
  link: authLink.concat(httpLink),
  cache: new InMemoryCache(),
});

const ProjectsList = props => {
  const [list, setList] = useState([]);
  const [flag, setFlag] = useState(true);


  useEffect(() => {
    client
      .query({
        query: gql`
          {
            projects {
              id
              name
            }
          }`,
      })
      .then((result) => JSON.parse(JSON.stringify(result)))
      .then((result) => {
        setList(result.data.projects);
      })
      .catch((error) => {
        alert('You dont have projects for work');
      });
  }, [flag]);

  const selectProject = project => {
    props.navigation.navigate('Track', { project });
  };

  const projectList = list.map((project) => (
    <View key={project.id}>
      <Text style={styles.welcome}>
        The name of the project is:
        {project.name}
      </Text>
      <View style={styles.button}>
        <Button
          color="#ad0404"
          title="Select this project to create a track"
          onPress={() => selectProject(project)}
        />
      </View>
    </View>
  ));

  return <View style={styles.container}>{projectList}</View>;
};

export default ProjectsList;

ProjectsList.navigationOptions = {
  title: 'List of Projects',
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

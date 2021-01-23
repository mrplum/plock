import React,{ useEffect, useState } from 'react';
import {
  Platform, StyleSheet, Text, Button, View, AsyncStorage
} from 'react-native';
import clientApollo from '../../../util/clientApollo';
import gql from 'graphql-tag';
import { API_HOST } from 'react-native-dotenv';

const ProjectsList = props => {
  const [list, setList] = useState([]);
  const [flag, setFlag] = useState(true);
  const client = clientApollo();

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

      <Text>
        { API_HOST }
      </Text>
    
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
  welcome: {
    fontSize: 17,
    textAlign: 'center',
    color: 'white',
    marginTop: 18,
  },
  button: {
    marginTop: 15,
    color: 'rgba(0,0,0, 1)',
    paddingRight: 40,
    paddingLeft: 40,
  }
});

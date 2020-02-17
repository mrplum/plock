import React,{ useEffect, useState } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  Button,
  View,
  ScrollView,
  AsyncStorage
} from 'react-native';
import { setContext } from 'apollo-link-context';
import clientApollo from '../../../util/clientApollo'
import StateContext from '../../../components/StateContext';
import gql from 'graphql-tag';
import {
Icon
} from 'react-native-elements';
import { AuthContext } from "../../../components/StateContextProvider";

const TracksList = props => {
  const [list, setList] = useState([]);
  const [flag, setFlag] = useState(true);
  const client = clientApollo();
  
  const { state, dispatch } = React.useContext(AuthContext);

  useEffect(() => {
    client
      .query({
        query: gql`
          {
            user {
              tracks {
                edges{
                  node{
                    id
                    name
                    description
                    status
                  }
                }
              }
            }
          }
        `
      })
      .then(result => JSON.parse(JSON.stringify(result)))
      .then(result => {
        setList(result.data.user.tracks.edges);
      })
      .catch(error => {
        console.log(error);
        alert('You dont have tracks for work');
      });
  },[flag]);

  const handleWorkTrack = track => {
    props.navigation.navigate('Tracker', { track });
  };

  const handleSetTimeTrack = track => {
    props.navigation.navigate('SetTime', { track });
  };

  const trackList = list.map(track => (

    <View key={track.node.id}>
      {(track.node.status != 'finished') &&
        <View>
          <Text style={styles.welcome}>
            {track.node.name}
          </Text>

          <Text style={styles.welcome}>
            The status of the track is:
            {track.node.status}   
          </Text>

          <View style={styles.button}>
            <Button
              color="#ad0404"
              title="Start to work on this track"
              onPress={() => handleWorkTrack(track.node)}
              disabled={track.node.status == 'finished'}
            />
          </View>

          <View style={styles.button}>
            <Button
              color="#ad0404"
              title="Set date that you had worked on this track"
              onPress={() => handleSetTimeTrack(track.node)}
              disabled={track.node.status == 'finished'}
            />
          </View>
        </View>
      }  
    </View>
  ));

  return (

    <ScrollView
      style={styles.container}
      contentContainerStyle={styles.contentContainer}
    >
      <View style={styles.container}>{trackList}</View>
    </ScrollView>
  );
};

export default TracksList;

TracksList.navigationOptions = {
  title: 'List of Tracks',
  headerStyle: {
    backgroundColor: '#808080'
  },
  headerTintColor: '#fff'
};

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#808080'
  },
  contentContainer: {
    paddingTop: 30
  },
  welcome: {
    fontSize: 17,
    textAlign: 'center',
    color: 'white',
    marginTop: 18
  },
  button: {
    marginTop: 15,
    color: 'rgba(0,0,0, 1)',
    paddingRight: 40,
    paddingLeft: 40
  },
  iconPos: {
    marginTop: 15,
    marginRight: 300

  },
  position:{
    marginTop: 5
  }
});

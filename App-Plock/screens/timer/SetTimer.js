import React, { useState } from "react";
import { Button, View, Text, Platform, StyleSheet, AsyncStorage, TextInput, KeyboardAvoidingView } from "react-native";
import DateTimePickerModal from "react-native-modal-datetime-picker";
import clientApollo from '../../util/clientApollo';
import gql from 'graphql-tag';
import { AuthContext } from "../../components/StateContextProvider";

const SetTimer = (props) => {

  const { state, dispatch } = React.useContext(AuthContext);

  const client = clientApollo();

  const [isDatePickerVisible, setDatePickerVisibility] = useState(false);
  const [datePickSee, setDatePickVisible] = useState(false);
  const [idInterval, setIdInterval] = useState(0);

  const [intervalDesc, setIntervalDesc] = useState({
    description: ''
  });

  const choose = props.navigation.getParam('track', 'nothing');

  const showDatePicker = () => {
    setDatePickerVisibility(true);
  };

  const hideDatePicker = () => {
    setDatePickerVisibility(false);
  };

  const seeDatePick = () => {
    setDatePickVisible(true);
  };

  const unseeDatePick = () => {
    setDatePickVisible(false);
  };

  const handleInit = async (date) => {

    const userId = state.user;
    const dateTime = date.toString();

    client
        .mutate({
          mutation: gql`
            mutation trackSetIntervalStart($track_id: ID!, $user_id: ID!, $start_at: String!, $description: String ) {
              intervalStart(trackId: $track_id, userId: $user_id, startAt: $start_at, description: $description) {
                id
                track {
                  name
                }
              }
            }
          `,
          variables: {
            track_id: choose.id,
            user_id: userId,
            start_at: dateTime,
            description: intervalDesc.description
          }
        }).then(result => JSON.parse(JSON.stringify(result)))
          .then(result => {
            setIdInterval(result.data.intervalStart.id);
            hideDatePicker();
        })
        .catch(error => {
          console.log(error);
          alert('Invalid date'); // eslint-disable-line no-alert
      });

  };

  const handleEnd = (date) => {
    const dateTime = date.toString();

    client
      .mutate({
        mutation: gql`
          mutation trackSetIntervalEnd($id: ID!, $end_at: String!) {
            intervalEnd(id: $id, endAt: $end_at) {
              id
            }
          }
        `,
        variables: {
          id: idInterval,
          end_at: dateTime
        }
      })
      .then(result => {
        alert('Plock-Time loaded succesfully');
        unseeDatePick();
      }).catch(error => {
        console.log(error);
      });
  };

  return (
    <View style={ styles.container }>

      <TextInput
        style={styles.TextInputStyleClass}
        underlineColorAndroid="transparent"
        placeholder="What have you been working on."
        onChangeText={value => setIntervalDesc({ description: value })}
        value={intervalDesc.description}
        placeholderTextColor={"#ffffff"}
        numberOfLines={15}
        multiline={true}
        editable={!isDatePickerVisible}
      />

      <View style={ styles.contain }>

        <Text style={ styles.welcome }>
          Select the date and time that you begin to work on the track.
        </Text>

        <View style={ styles.button }>
          <Button title="Set Begin Date" onPress={ showDatePicker } color="#ad0404" />
        </View>

        <DateTimePickerModal
          isVisible={ isDatePickerVisible }
          mode="datetime"
          is24Hour={ true }
          onConfirm={ handleInit }
          onCancel={ hideDatePicker }
        />

      </View>

      <View style={ styles.containerdoor }>

        <Text style={ styles.welcome }>
          Select the date and time that you end the work on the track.
        </Text>

        <View style={ styles.button }>
          <Button title="Set End Date" onPress={ seeDatePick } color="#ad0404" />
        </View>

        <DateTimePickerModal
          isVisible={ datePickSee }
          mode="datetime"
          is24Hour={true}
          onConfirm={ handleEnd }
          onCancel={ unseeDatePick }
        />
      </View>

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
  contain: {
    flex: 1,
    marginTop: 25,
    backgroundColor: '#808080',
  },
  containerdoor: {
    flex: 1,
    marginBottom: 80,
    backgroundColor: '#808080',
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
  button: {
    marginTop: 15,
    color: 'rgba(0,0,0, 1)',
    paddingRight: 40,
    paddingLeft: 40,
  },
  TextInputStyleClass:{
    fontSize: 18,
    textAlign: 'center',
    height: 50,
    borderWidth: 2,
    marginTop: 15,
    borderColor: 'white',
    borderRadius: 20 ,
    backgroundColor: "#a0a0a0",
    height: 150,
    color: 'white',
    }
});

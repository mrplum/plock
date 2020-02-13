import React from 'react';
import { AsyncStorage } from 'react-native';
import { Stopwatch } from 'react-native-stopwatch-timer'

export const AuthContext = React.createContext(); // added this

const initialState = {
  isAuthenticated: false,
  user: null,
  token: null,
  working: false,
  interval: null,
  workingDate: null,
};

const reducer = (state, action) => {
  switch (action.type) {
    case "LOGIN":
      AsyncStorage.setItem('userToken', action.payload.user.token);
      return {
        ...state,
        isAuthenticated: true,
        user: action.payload.user.id,
        token: action.payload.user.token
      };
    case "LOGOUT":
      AsyncStorage.removeItem('userToken');
      return {
        ...state,
        isAuthenticated: false,
        user: null
      };
    case "FINISHED":
      return {
        ...state,
        working: false
      };
    case "START":
      return {
        ...state,
        working: true
      };
    case "SETINTERVAL":
      return {
        ...state,
        interval: action.payload
      };
    case "REMOVEINTERVAL":
      return {
        ...state,
        interval: null
      };
    case "SETDATE":
      return {
        ...state,
        workingDate: action.payload
      };
    case "REMOVEDATE":
      return {
        ...state,
        workingDate: null
      };  
    default:
      return state;
  }
};

const Chronometer = (props) => {
  return(
    <Stopwatch
      laps
      start={props.running}
      startTime= { props.workDate }
      reset={false}
      // To reset
      options={options}
      // options for the styling
    />
  )
};

export { initialState, reducer, Chronometer };

const options = {
  container: {
    marginTop: 35,
    backgroundColor: '#ad0404',
    padding: 5,
    borderRadius: 5,
    width: 200,
    alignItems: 'center'
  },
  text: {
    fontSize: 25,
    color: '#ffffff',
    marginLeft: 7,
  }
};

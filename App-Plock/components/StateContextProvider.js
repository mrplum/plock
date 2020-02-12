import React from 'react';
import { AsyncStorage } from 'react-native';

export const AuthContext = React.createContext(); // added this

const initialState = {
  isAuthenticated: false,
  user: null,
  token: null,
  working: false,
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
    default:
      return state;
  }
};

export { initialState, reducer };
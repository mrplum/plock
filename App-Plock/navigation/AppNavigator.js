import React from 'react';
import { Platform } from 'react-native';
import { createStackNavigator } from 'react-navigation-stack';
import {createSwitchNavigator, createAppContainer} from 'react-navigation';

import MainTabNavigator from './MainTabNavigator';
import SignInScreen from '../screens/signIn/SignInScreen';
import HomeScreen from '../screens/home/HomeScreen';
import TracksListScreen from '../screens/home/tracks/TracksListScreen';
import ProjectListScreen from '../screens/home/projects/ProjectListScreen';
import StatsUserScreen from '../screens/home/user/StatsUserScreen';
import Tracker from '../screens/timer/TimerTrack';
import CreateTrackScreen from '../screens/home/projects/CreateTrackScreen';
import SetTimeTrack from '../screens/timer/SetTimer';

const config = Platform.select({
  web: { headerMode: 'screen' },
  default: {},
});

const AuthStack = createStackNavigator(
  {
    SignIn: SignInScreen,
  },
  config
);

AuthStack.navigationOptions = {
  tabBarLabel: 'Settings',
  tabBarIcon: ({ focused }) => (
    <TabBarIcon focused={focused} name={Platform.OS === 'ios' ? 'ios-options' : 'md-options'} />
  ),
};


const HomeScreenStack = createStackNavigator(
  {
    Home: HomeScreen,
    Tracks: TracksListScreen,
    Projects: ProjectListScreen,
    Track: CreateTrackScreen,
    Tracker: Tracker,
    SetTime: SetTimeTrack,
    StatsUser: StatsUserScreen
  },
  config
);

HomeScreenStack.navigationOptions = {
  tabBarLabel: 'Settings',
  tabBarIcon: ({ focused }) => (
    <TabBarIcon focused={focused} name={Platform.OS === 'ios' ? 'ios-options' : 'md-options'} />
  ),
};

export default createAppContainer(
  createSwitchNavigator({
    // You could add another route here for authentication.
    // Read more at https://reactnavigation.org/docs/en/auth-flow.html
    Auth: AuthStack,
    Home: HomeScreenStack,
    Main: MainTabNavigator,
  })
);

import React from 'react';
import { useState } from 'react';

//import createUseContext from 'constate'; // State Context Object Creator

function useCounter() {
  const [userId, setUserId] = useState();
  const [trackId, setTrackId] = useState();

  setCurrentUser = (id) => () => {
    setUserId(id);
  }

  setCurrentTrack = (id) => () => {
    setTrackId(id);
  }

  return { userId, trackId, setCurrentUser, setCurrentTrack };
}

export const useStateContext = React.createContext(useCounter);

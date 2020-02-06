import { setContext } from 'apollo-link-context'
import { AsyncStorage } from 'react-native'
import ApolloClient from 'apollo-client'
import { createHttpLink } from 'apollo-link-http'
import { InMemoryCache } from 'apollo-cache-inmemory'
import { API_HOST } from 'react-native-dotenv'

const clientApollo = () => {

  const httpLink = createHttpLink({
    uri: API_HOST,
  });

  const authLink = setContext(async (_, { headers }) => {
    const userToken = await AsyncStorage.getItem('userToken');
    return {
      headers: {
        ...headers,
        Authorization: userToken ? `Bearer ${userToken}` : '',
      },
    };
  });

  const client = new ApolloClient({ link: authLink.concat(httpLink), cache: new InMemoryCache() })

  return (
    client
  )
}

export default clientApollo;
## Navigation in React-Native (Tab and Stack base Navigation)

## Objectives 

We have seen navigation in React Native via the navigation stack, namely **createStackNavigator**. For a review on how it works see [createStackNavigator](https://reactnavigation.org/docs/en/stack-navigator.html). 

Today we will be building upon this knowledge to create a Tab based navigation hierarchy. 

**createBottomTabNavigator**  
A simple tab bar on the bottom of the screen that lets you switch between different routes. Routes are lazily initialized -- their screen components are not mounted until they are first focused.

```javascript 
export default createBottomTabNavigator({
  Home: HomeScreen,
  Settings: SettingsScreen,
})
```

The app we will be building a Citibike app. 

**Endpoints**  
Bike Station Information: ```https://gbfs.citibikenyc.com/gbfs/en/station_information.json```  
Real time status on bike availability: ```https://gbfs.citibikenyc.com/gbfs/en/station_status.json```   

## CitiBikeAPI.js 

The CitiBikeAPI has two functions one fetches the bike station infomation from Citibike API. In the for..in statement we construct a station object which will hold a coordinate object needed by the MapView's Marker component and the bike station object. 

The bikeStationStatus fetches the real time bike status information from Citibike API.

**Complete Implementation**  
```javascript
export function bikeStationInformation() {
  return fetch('https://gbfs.citibikenyc.com/gbfs/en/station_information.json') 
  .then(response => response.json()) 
  .then(jsonData => {
    const data = jsonData['data']
    const results = data['stations']

    let objects = []
    
    for(let index in results) {
      let object = {
        station: results[index], 
        coordinate: {
          latitude: results[index].lat, 
          longitude: results[index].lon, 
        }
      }
      objects.push(object)
    }    
    return objects 
  }) 
  .catch(err => console.error(err))
}

export function bikeStationStatus() {
  return fetch('https://gbfs.citibikenyc.com/gbfs/en/station_status.json') 
    .then(response => response.json()) 
    .then(jsonData => {
      const data = jsonData['data']
      const stationsStatus = data['stations']
      return stationsStatus
    }) 
    .catch(err => console.error(err)) 
}
```

## App.js

In App.js the RootStack is setting up a Tab Bar Style Architecture. The List route holds a ListStack object which itself is a Navigation Stack. There are two tab routes: the List tab bar and the Map tab bar. 

Imports being used here are createStackNavigator and createBottomTabNavigator from the third party library, react-navigation. For the tab bar icons we use Ionicons from the react-native-vector-icons library. We import our own custom function from the CitiBikeAPI.js, namely the bikeStationInformation and bikeStationStatus functions. The are three routes (screens) in our app. 

* BikeStationsListScreen: the first tab bar which consist of a FlatList of station items
* BikeStationsMapScreen: the second tab bar which is a MapView with station annotations 
* StationDetailsScreen: shows a MapView with a Marker of the selected station

**Complete Implementation**  
```javascript
import React, { Component } from 'react';

// import 3rd Party libraries 
import { createStackNavigator } from 'react-navigation'
import { createBottomTabNavigator } from 'react-navigation'
import Ionicons from 'react-native-vector-icons/Ionicons'

// import our cutom functions 
import { bikeStationInformation, bikeStationStatus } from './helpers/CitiBikeAPI'

// import screen components 
import BikeStationsListScreen from './screens/BikeStationsListScreen';
import BikeStationsMapScreen from './screens/BikeStationsMapScreen';
import StationDetailsScreen from './screens/StationDetailsScreen';

const ListStack = createStackNavigator({
  List: BikeStationsListScreen, 
  Details: StationDetailsScreen
})

const RootStack = createBottomTabNavigator(
  {
  List: ListStack, 
  Map: BikeStationsMapScreen
  }, 
  {
    // Setting up the tab bar icons for the List and Map Screens 
    navigationOptions: ({ navigation }) => ({
      tabBarIcon: ({ focused, tintColor }) => {
        const { routeName } = navigation.state
        let iconName
        if (routeName === 'List') {
          iconName = `ios-list${focused ? '' : '-outline'}`
        } else if (routeName === 'Map') {
          iconName = `ios-map${focused ? '' : '-outline'}`
        }
        return <Ionicons name={iconName} size={27} color={tintColor} />
      },
    }),
    tabBarOptions: {
      activeTintColor: 'tomato',
      inactiveTintColor: 'gray',
    },
  }
)

// The one component our App returns is the RootStack component which we have defined to be a bottom tab navigator
export default class App extends Component {
  render() {
    return(
      <RootStack />
    )
  }
}
```

## BikeStationsListScreen.js 

**Complete Implementation**  
```javascript
import React, { Component } from 'react'
import { View, 
         FlatList, 
         Text, 
         StyleSheet } from 'react-native'

// import 3rd party libraries 
import { SearchBar } from 'react-native-elements'

// import function 
import { bikeStationInformation } from '../helpers/CitiBikeAPI'

// The navigationOptions is where further customization can be done for the screen component 
// Here the Navigation screen title is being set.
export default class BikeStationsListScreen extends Component {

  // A stations array is declared as part of our state variables 
  constructor(props) {
    super(props) 
    this.state = {
      stations: [], 
    }
  }

  // The componentDidMount view cycle makes a call to fetch all the Citibike stations in New York City. 
  // The stations array is then set with the result of the promise 
  // A filteredStations temp array is used for search filtering
  // The query variable here is used to clear the searchBar when the clear button is pressed 
  componentDidMount() {
    super.componentDidMount
    bikeStationInformation()
      .then((results) => {
        let objects = []
        for(let index in results) {
          objects.push(results[index].station)
        }
        this.setState({
          stations: objects,
          filteredStations: objects, 
          query: '', 
        })
      }) 
  }

  static navigationOptions = {
    title: 'CitiBike Locations', 
  }

  // The renderItemSeperator returns a View component to the ItemSeparatorComponent to render a line between items in the
  // FlatList
  renderItemSeperator() {
    return <View style={{backgroundColor:'lightgray', height:0.5}} />
  }

  // The filterSearch function takes a single String argument and does a filter on the stations and updates the FlatList
  filterSearch = (word ) => {
    this.setState({
      query: word, 
      filteredStations: this.state.stations.filter((station) => station.name.toLowerCase().includes(word.toLowerCase()))
    })
  }

  render() {
    return (
      <View>
        {/* Since react-native does not have a native SearchBar component we will use react-native-elements SearchBar.  */}
        <SearchBar
          lightTheme
          round
          clearIcon={{color: 'gray'}}
          placeholder='search for bike location'
          onChangeText={(searchText) => this.filterSearch(searchText)}
          autoCapitalize='none'
          autoCorrect={false}
          onClear={() => this.setState({query: ''})}
          value={this.state.query}
        />
        {/* The FlatList gets its data from the fetch API to get all Citibike stations */}
        {/* <View style={{backgroundColor:'red', height:'100%', width:'100%'}}></View> */}
        <FlatList 
          data={this.state.filteredStations}
          renderItem={({item}) => <Text 
                                    style={styles.item}
                                    onPress={() => this.props.navigation.navigate('Details', {
                                      station: item
                                    })}
                                  >
                                      {item.name}
                                  </Text>}

          // A unique key is needed here we will use the station_id
          keyExtractor={item => item.station_id}
          
          // Expects a component that will render between items in the FlatList
          ItemSeparatorComponent={this.renderItemSeperator}
        />
      </View>   
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1, 
    alignItems: 'center', 
    justifyContent: 'center', 
  },
  item: {
    padding: 10, 
    fontSize: 20, 
  } 
})
```

## BikeStationsMapScreen.js 

**Complete Implementation**  
```javascript
import React, { Component } from 'react'

// import 3rd party libraries 
import MapView from 'react-native-maps'
import { Marker } from 'react-native-maps'

// import our custom functions 
import { bikeStationInformation, bikeStationStatus } from '../helpers/CitiBikeAPI'

export default class BikeStationsMapScreen extends Component {
  constructor() {
    super() 
    this.state = {

      // an array of stations from the Citibike API 
      stations: [], 

      stationStatusArray: [],

      // region defaults to be centered in New York City
      region: {
        latitude: 40.6974881,
        longitude: -73.979681,
        latitudeDelta: 0.0922,
        longitudeDelta: 0.0421,
      }
    }
  }

  componentDidMount() {
    super.componentDidMount

    // helper function to get the bike station information from the Citibike API 
    bikeStationInformation()
      .then((results) => {
        this.setState({
          stations: results, 
        })
      })

    bikeStationStatus() 
      .then((results) => {
        this.setState({
          stationStatusArray: results, 
        })
      })
  }

  // Gets the real time status information for this particular Station 
  fetchStationStatus = (item) => {
    const results = this.state.stationStatusArray.filter((station) => station.station_id === item.station_id)
    if(results.length === 1) {
      return results[0]
    } 
    return {}
  }

  render() {
    return(
      // Using the MapView component from react-native-maps to render the Map 
      <MapView 
        style={{flex:1}}
        region={this.state.region}
      >
        {/* Iterates through our stations to create Marker annotations for the map using the coordinate we constructed for our station object*/}
        {this.state.stations.map((stationObject) => {

          // Using the results of the Bike Station Status date create a description to show the real time station data for the Marker annotation
          const stationStatus = this.fetchStationStatus(stationObject.station)
          const description = 'Bikes Available: ' + stationStatus.num_bikes_available + ' '
          + 'Docks Available: ' + stationStatus.num_docks_available

          return <Marker 
            coordinate={stationObject.coordinate}
            title={stationObject.station.name}
            // description={'Bike Capacity: ' + stationObject.station.capacity}
            description={description}
           
            // Here we need to use a unique key when iterating through our collection
            key={stationObject.station.station_id}
          />
        })}

      </MapView>
    )
  }
} 
```

## StationDetailsScreen.js 

**Complete Implementation**  
```javascript
import React, { Component } from 'react'

// import 3rd party libraries 
import MapView from 'react-native-maps'
import { Marker } from 'react-native-maps';

// import our custom functions 
import { bikeStationStatus } from '../helpers/CitiBikeAPI'

export default class StationDetailsScreen extends Component {
  constructor(props) {
    super(props)
    this.state = {
      // staion is passed in as a prop from the parent component 
      station: {},

      // stationStatusArray gets populated from the Ciitbike API request
      stationStatusArray: [], 
    }
  }

  componentDidMount() {
    super.componentDidMount

    // helper function to get the real time bike station status information from the CitiBike API
    bikeStationStatus() 
    .then(results => {
      this.setState({
        stationStatusArray: results
      }) 
    })
  }

  // Gets the real time status information for this particular Station 
  fetchStationStatus = () => {
    const { navigation } = this.props
    const stationInfo = navigation.getParam('station', 'no station info')
    const results = this.state.stationStatusArray.filter((station) => station.station_id === stationInfo.station_id)
    if(results.length === 1) {
      return results[0]
    } 
    return {}
  }

  // Set the title for the Navigation Bar
  static navigationOptions = {
    title: 'Station Details',
  }

  render() {
    // Retrieve the station prop from the navigation params
    const { navigation } = this.props
    const stationInfo = navigation.getParam('station', 'no station info')

    // The Marker component needs a coordinate so here we are creating one from the lat and lon of the station
    const coordinate = {
      latitude: stationInfo.lat, 
      longitude: stationInfo.lon, 
    }

    // Constructing a description for the Marker callout
    const station = this.fetchStationStatus()
    const description = 'Bikes Available: ' + station.num_bikes_available + ' '
                        + 'Docks Available: ' + station.num_docks_available

    // Our main component in a MapView with the Marker representing the bike station's location
    return(
      <MapView style={{flex: 1}}
        initialRegion={{
          latitude: stationInfo.lat, 
          longitude: stationInfo.lon, 
          latitudeDelta: 0.0922, 
          longitudeDelta: 0.0421,
        }}
      >
        <Marker 
          coordinate={coordinate}
          title={stationInfo.name}
          description={description}
        />
      </MapView>
    )
  }
}
```


## Completed Screenshots

By far the most attractive part of react-native is being cross-platform. Evident below with screenshots of our citi-bike-app running on both iOS and Android with an identical codebase of Javacript and react-native.

BikeStationsListScreen 
<p align="center">
  <img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit10/Images/citi-bike-app-list.png" width="275" height="590" />
</p>

BikeStationsMapScreen
<p align="center">
  <img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit10/Images/citi-bike-app-map.png" width="275" height="590" />
</p>

BikeStationsListScreen (Android)
<p align="center">
  <img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit10/Images/citi-bike-app-list-android..png" width="300" height="533" />
</p>

BikeStationsMapScreen (Android)
<p align="center">
  <img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit10/Images/citi-bike-app-map-android.png" width="300" height="533" />
</p>



## Resources 

|Resources|Summary|
|:------|:--------|
| [React Navigation](https://reactnavigation.org/) |Routing and navigation for your React Native apps|
| [Tab Navigation](https://reactnavigation.org/docs/en/tab-based-navigation.html) | A simple tab bar on the bottom of the screen that lets you switch between different routes (screens).  |
| [React Native Elements](https://react-native-training.github.io/react-native-elements/docs/searchbar.html) | SearchBar  |
| [React Community](https://github.com/react-community/react-native-maps) | react-native-maps |
| [oblador](https://github.com/oblador/react-native-vector-icons/blob/master/glyphmaps/Ionicons.json) | Customizable Icons for React Native with support for NavBar/TabBar/ToolbarAndroid, image source and full styling. |


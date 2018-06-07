## TextInput, Handling Touches and ScrollView

The components we will be importing from react-native to build a login screen includes: 
* TouchableHighlight: a component that has an onPress prop to notify a function of the user's tap on the UI element
* TextInput: accepts user input similar to a UITextField in iOS 
* ImageBackground: we will use this component to set a background image for out login screen

Here we are importing the necessary components from react-native 

```javascript 
import React, { Component } from 'react'; 
import { View, Text, StyleSheet, TextInput, TouchableHighlight, Alert, ImageBackground } from 'react-native'; 
```

Our basic class structure

```javascript 
export default class App extends Component {
  render() {
    return(
      <View>
      </View>
    )
  }
} 
```

A function that presents an alert on screen when the login button is pressed by the user 
```javascript 
login = () => {
  Alert.alert('Successfully signed in')
}
```


The structure on setting up an ImageBackground component 
```javascript 
<ImageBackground 
  style={styles.container}
  resizeMode='cover'
  source={{uri:'https://upload.wikimedia.org/wikipedia/commons/thumb/6/68/Grass_dsc08672-nevit.jpg/1200px-Grass_dsc08672-nevit.jpg'}}
/>
```

The username TextInput component 
```javascript 
<TextInput 
  style={styles.input}
  placeholder='Username'
  placeholderTextColor='white'
/>
```

The TouchableHightlight will be the button the user presses to login 

```javascript 
<TouchableHighlight
  style={styles.submitButton}
  onPress={() => this.login(this.state.email, this.state.password)}
>
  <Text style={styles.submitButtonText}>Submit</Text>
</TouchableHighlight>
```

We are using the StyleSheet component to makeup the styles for our various UI elements 

```javascript 
const styles = StyleSheet.create({
  container: {
    paddingTop: 40, 
  }, 
  input: {
    margin: 15, 
    height: 40, 
    borderColor: 'gray', 
    borderWidth: 1, 
  }, 
  submitButton: {
    backgroundColor: 'orange', 
    padding: 10, 
    margin: 15, 
    height: 40, 
    alignItems: 'center'
  }, 
  submitButtonText: {
    color: 'white', 
  }
})
```
 
The construction of our app sets the defaults states for email and password

```javascript 
constructor(props) {
  super(props)
  this.state = {email: '', password: ''}
}
```

Functions to update the state for email and password 
```javascript 
updateEmail = (text) => {
  this.setState({email: text})
}

updatePassword = (text) => {
  this.setState({password: text})
}
```

Login Screen UI 
<p align="center">
  <img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit10/Images/login-screen.png" width="341" height="605" />
</p>

## Implementing a ScrollView component

```javascript 
import React, { Component } from 'react'; 
import { ScrollView, View, StyleSheet, Image } from 'react-native'; 

export default class App extends Component {
  render() {
    return(
      <ScrollView
        contentContainerStyle={styles.contentContainer}
      >
        <Image 
          style={styles.image}
          source={{uri:'https://resizing.flixster.com/O_KWixx0atbaRUabpg-ON7sIWwY=/1200x1800/v1.dDsyNzY5MzM7ajsxNzczMzsxMjAwOzEyMDA7MTgwMA'}}
        />
        <Image 
          style={styles.image}
          source={{uri:'https://resizing.flixster.com/ddaZi2sVx-LGH7KecCJA-A6S_n8=/180x265/v1.dDsyNzg5MTY7ajsxNzczMzsxMjAwOzE4MDsyNjU'}}
        />
        <Image 
          style={styles.image}
          source={{uri:'https://resizing.flixster.com/_QWMYTZC-jFLcA0t38k0YP4j9wE=/1500x2222/v1.dDsyOTU3NjU7ajsxNzczMzsxMjAwOzE1MDA7MjIyMg'}}
        />
        <Image 
          style={styles.image}
          source={{uri:'https://resizing.flixster.com/YIMcUU9k9BJVQDvZkbBxfJh92vQ=/646x960/v1.dDsyODI1ODE7ajsxNzczMzsxMjAwOzY0Njs5NjA'}}
        />
        <Image 
          style={styles.image}
          source={{uri:'https://resizing.flixster.com/CJc_xtedY987r4jbDYS-DceIM6I=/1028x1542/v1.dDszMDYxMDM7ajsxNzczMzsxMjAwOzEwMjg7MTU0Mg'}}
        />
        <Image 
          style={styles.image}
          source={{uri:'https://resizing.flixster.com/yT5yTHSoEKLzaljKm5Mf5Wm4OF4=/2000x3000/v1.dDsyOTU0NTY7ajsxNzczMzsxMjAwOzIwMDA7MzAwMA'}}
        />
        <Image 
          style={styles.image}
          source={{uri:'https://resizing.flixster.com/ATufPpI_Feb0_3IezdnEI5NRWHo=/2000x3000/v1.dDsyODMzOTk7ajsxNzczMzsxMjAwOzIwMDA7MzAwMA'}}
        />
        <Image 
          style={styles.image}
          source={{uri:'https://resizing.flixster.com/U2djpSbQrANjkmzrWDVBIEQJ-W4=/1500x2222/v1.dDsyOTMwNDU7ajsxNzczMzsxMjAwOzE1MDA7MjIyMg'}}
        />
        <Image 
          style={styles.image}
          source={{uri:'https://resizing.flixster.com/IxFEFhtDoo2VzpPKDS40y6so7Kw=/1600x2400/v1.dDsyODI4MzA7ajsxNzczMzsxMjAwOzE2MDA7MjQwMA'}}
        />
        <Image 
          style={styles.image}
          source={{uri:'https://resizing.flixster.com/OeXKRR2qBSfakRyZX-4UvspcH6o=/1594x2391/v1.dDsyODUzOTk7ajsxNzczMzsxMjAwOzE1OTQ7MjM5MQ'}}
        />
      </ScrollView>
    )
  }
}

const styles = StyleSheet.create({
  contentContainer: {
    alignItems: 'center', 
  }, 
  container: {
    flex: 1, 
    backgroundColor: 'powderblue', 
  }, 
  image: {
    width: '100%', 
    height: 600, 
  }, 
})
```

The ScrollView UI 
<p align="center">
  <img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit10/Images/scroll-view.png" width="341" height="605" />
</p>

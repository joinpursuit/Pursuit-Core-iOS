## React-Native Networking (Flickr App) 

## Objectives
* Let's build upon our knowledge of Javascript's **Fetch API** to make network requests for our react-native apps
* Making a custom component and injecting the necessary **props** from the parent component 
* Setting **state** of a custom component 
* Using a **Promise** to return data logic to a component in this case App.js
* Exporting a custom function and component
* Importing a custom function and component 

**Flickr search photos endpoint:** ``` https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key={FLICKR API KEY HERE}&lat=40.93&lon=-73.88&format=json&extras=url_m,description&per_page=500&text={KEYWORD SEARCH}&nojsoncallback=1&safe_search=3&radius=32 ``` 

If you need an API key sign up [here](https://www.flickr.com/services/api/misc.api_keys.html)

**Fetch API Review**  
```javascript 
fetch('ENDPOINT HERE')
  .then(response => response.json()) 
  .then(jsonData => console.log(jsonData)) 
  .catch(err => console.error(err)) 
```

Above we are making a fetch() request and getting back a **Promise** with the **response** object. Then we return the json() to get another promise with the data we're interested in. Don't forget to catch() any potential errors. 

For stripping HTML tags from a String in Javascript use 
```javascript
const strippedString = someString.replace(/<[^>]*>/g, '') 
```

**App.js**  

App.js imports a custom function **searchPhotos** and custom component **Photocard**. The searchPhotos does the Fetch request. Photocard is reponsible for rendering the Flickr photo and associated values. 

```javascript 
import React, { Component } from 'react'
import { View, 
         StyleSheet, 
         TouchableHighlight, 
         Image, 
         Text } from 'react-native'

export default class PhotoCard extends Component {
  constructor(props) {
    super(props)
    this.state = {
      imageURL: '', 
      title: '', 
      description: '', 
    }
  }

  

  render() {
    const desc = this.props.description.replace(/<[^>]*>/g, '')
    return(
      <TouchableHighlight
      >
        <View style={styles.container}>
          <Image
            style={styles.image}
            source={{uri:this.props.imageURL}}
          />
          <Text style={styles.title}>{this.props.title}</Text>
          <Text style={styles.description}>{desc}</Text>
        </View>
      </TouchableHighlight>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1, 
    alignItems: 'center', 
    justifyContent: 'center'
  }, 
  image: {
    height: 400, 
    width: '100%', 
  },
  title: {
    fontSize: 20, 
    color: 'white', 
  }, 
  description: {
    fontSize: 20, 
    color: 'white', 
  }
})
```

**FlickrAPI.js**  

This function is responsible to making the fetch api network request. The **searchPhotos()** function takes in a String keyword from the user then makes the request. 

```javascript 
export function searchPhotos(searchKeyword) {
  const apiKey = '{FLICKR API KEY HERE}'
  const newyork = '&lat=40.6974034&lon=-74.1197635'
  const cairns = '&lat=-16.9184235&lon=145.768141' 

  return fetch('https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=' 
                + apiKey + newyork 
                + '&format=json&extras=url_m,description&per_page=500&text=' 
                + encodeURI(searchKeyword) + '&nojsoncallback=1&safe_search=3&radius=32')
    .then(response => response.json())
    .then(jsonData => {
      const results = jsonData['photos']
      const photos = results['photo']
      return photos
    })
    .catch(err => console.error(err))
```

A **Promise** is returned to the caller from the App.js component. 

**PhotoCard.js**  

This component will be our Photo card component which consists of am Image, and 2 Text components which will render the **url_m** for the Flickr photo, the **title** and the **description._content**  

```javascript 
import React, { Component } from 'react'
import { View, 
         StyleSheet, 
         TouchableHighlight, 
         Image, 
         Text } from 'react-native'

export default class PhotoCard extends Component {
  constructor(props) {
    super(props)
    this.state = {
      imageURL: '', 
      title: '', 
      description: '', 
    }
  }

  

  render() {
    const desc = this.props.description.replace(/<[^>]*>/g, '')
    return(
      <TouchableHighlight
      >
        <View style={styles.container}>
          <Image
            style={styles.image}
            source={{uri:this.props.imageURL}}
          />
          <Text style={styles.title}>{this.props.title}</Text>
          <Text style={styles.description}>{desc}</Text>
        </View>
      </TouchableHighlight>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1, 
    alignItems: 'center', 
    justifyContent: 'center'
  }, 
  image: {
    height: 400, 
    width: '100%', 
  },
  title: {
    fontSize: 20, 
    color: 'white', 
  }, 
  description: {
    fontSize: 20, 
    color: 'white', 
  }
})
```

## Resource 

| Resource | Summary |
|:-----|:------|
| [Login Room](https://www.logicroom.co/react-native-architecture-explained/) | React Native Architecture : Explained! |

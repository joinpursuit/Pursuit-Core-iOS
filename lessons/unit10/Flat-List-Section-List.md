## List Views 

We've seen the ScrollView component. It enables us to embed other components as its children and those become part of the ScrollView's content. In today's lesson we will dive into two list components available in React-Native: 
* FlatList
* SectionList 

## FlatList 

A FlatList has two required props, **data** and **renderItem** data is the source of the content for the list to render. renderItem returns one item from the data contents. 

We will be importing the following components from react-native: 
* ImageBackground 
* StyleSheet 
* FlatList
* Text

```javascript 
import React, { Component } from 'react'; 
import { StyleSheet,
         ImageBackground, 
         FlatList, 
         Text } from 'react-native'; 
```

At the top level of our component hierarchy is an <ImageBackground> component. 
         
```javascript
<ImageBackground 
 style={styles.container}
 source={{uri:'http://www.everymantri.com/.a/6a00d83451b18a69e2011571aea92c970b-pi'}}
>        
```         
         
The FlatList will represent a series of endurance races. The **data** prop holds the contents to be shown in the list. Here this is a static list, but soon we will be making network API calls to populate our data prop. **renderItem** uses the item key to get the value from the data.          
         
```javascript 
<FlatList 
 data={[
   {key : 'NYC Marathon'},
   {key : 'Savageman'}, 
   {key : 'IRONMAN Lake Placid'},
   {key : 'IRONMAN Copenhagen'},
   {key : 'Montauk Half'},
   {key : 'Pilgrimman'},
   {key : 'Vineman'},
   {key : 'Waterman Half'},
   {key : 'NYC Triathlon'},
   {key : 'Town of Hemstead Triathlon'},
 ]}
 renderItem={({item}) => <Text style={styles.item}>{item.key}</Text>}
/>
```
         
Completed source code for the FlatList demo. 

```javascript 
import React, { Component } from 'react'; 
import { StyleSheet,
         ImageBackground, 
         FlatList, 
         Text } from 'react-native'; 

export default class App extends Component {
  render() {
    return(
      <ImageBackground 
        style={styles.container}
        source={{uri:'http://www.everymantri.com/.a/6a00d83451b18a69e2011571aea92c970b-pi'}}
      >
        <FlatList 
          data={[
            {key : 'NYC Marathon'},
            {key : 'Savageman'}, 
            {key : 'IRONMAN Lake Placid'},
            {key : 'IRONMAN Copenhagen'},
            {key : 'Montauk Half'},
            {key : 'Pilgrimman'},
            {key : 'Vineman'},
            {key : 'Waterman Half'},
            {key : 'NYC Triathlon'},
            {key : 'Town of Hemstead Triathlon'},
          ]}
          renderItem={({item}) => <Text style={styles.item}>{item.key}</Text>}
        />
      </ImageBackground>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1, 
    backgroundColor: 'skyblue', 
  }, 
  overlay: {
    backgroundColor: 'black', 
    width:100, 
    height: 100
  }, 
  item: {
    fontSize: 20, 
    fontWeight: 'bold', 
    color: 'white', 
    height: 80, 
    padding: 10, 
  }
})
```

FlatList Demo UI

<p align="center">
 <img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit10/Images/flat-list.png" width="340" height="650" />
</p>

## SectionList 

**SectionList** as the name suggests is a list of rendered contents with a section header which grounps it's appropriate data accordingly. The required props of a SectionList are **sections**, **renderItem**, **renderSectionHeader** and **keyExtractor**.   

**keyExtractor** : needs to be a unique key for tracking the items in the list 

First let's import the necessary components from react-native

```javascript
import React, { Component } from 'react'; 
import { View, SectionList, StyleSheet, Text, Alert } from 'react-native'; 
```

The const variables will hold our data objects 

```javascript 
const monday = ['WWDC 2018 Keynote', 'Platforms State of the Union', 'Apple Design Awards']
const tuesday = ['What\'s New in Swift', 'Introduction MapKit JS', 'What\'s New in Cocoa Touch']
const wednesday = ['Whats new in ARKit', 'What\'s New in Testing', 'New Ways to Work with Workouts']
const thursday = ['Building Faster in Xcode', 'Creating Photo and Video Effects Using Depth', 
             'Creating Audio Apps for watchOS', 'The Life of a Button']
const friday = ['Using Collections Effectively', 'Create Your Own Swift Playgrounds Subscription', 
           'Understanding Crashes and Crash Logs', 'Behind the Scenes of the Xcode Build Process', 
           'Adding Delight to your iOS App']
```

The SectionList component will render the days of the week as section headers and the data for each section will be the WWDC session. 

```javascript 
<SectionList 
sections={[
 {title: 'Monday', data: monday}, 
 {title: 'Tuesday', data: tuesday},
 {title: 'Wednesday', data: wednesday},
 {title: 'Thursday', data: thursday},
 {title: 'Friday', data: friday}
]}
renderItem={({item}) => <Text style={styles.item} onPress={this.didSelectItem.bind(this, item)}>{item}</Text>}
renderSectionHeader={({section}) => <Text style={styles.sectionHeader}>{section.title}</Text>}
keyExtractor={(item, index) => index}
/>
```


Completed SectionList demo.

```javascript 
import React, { Component } from 'react'; 
import { View, SectionList, StyleSheet, Text, Alert } from 'react-native'; 

export default class App extends Component {
  didSelectItem = (item) => {
    Alert.alert(item)
  }

  render() {
    const monday = ['WWDC 2018 Keynote', 'Platforms State of the Union', 'Apple Design Awards']
    const tuesday = ['What\'s New in Swift', 'Introduction MapKit JS', 'What\'s New in Cocoa Touch']
    const wednesday = ['Whats new in ARKit', 'What\'s New in Testing', 'New Ways to Work with Workouts']
    const thursday = ['Building Faster in Xcode', 'Creating Photo and Video Effects Using Depth', 
                      'Creating Audio Apps for watchOS', 'The Life of a Button']
    const friday = ['Using Collections Effectively', 'Create Your Own Swift Playgrounds Subscription', 
                    'Understanding Crashes and Crash Logs', 'Behind the Scenes of the Xcode Build Process', 
                    'Adding Delight to your iOS App']

    return(
      <View style={styles.container}>
        <View style={styles.topBar}>
          <Text style={styles.title}>WWDC 2018</Text>
        </View>
        <SectionList
        // required props: sections, renderItem, renderSectionHeader, keyExtractor 
        sections={[
          {title: 'Monday', data: monday}, 
          {title: 'Tuesday', data: tuesday},
          {title: 'Wednesday', data: wednesday},
          {title: 'Thursday', data: thursday},
          {title: 'Friday', data: friday}
        ]}
        renderItem={({item}) => <Text style={styles.item} onPress={this.didSelectItem.bind(this, item)}>{item}</Text>}
        renderSectionHeader={({section}) => <Text style={styles.sectionHeader}>{section.title}</Text>}
        keyExtractor={(item, index) => index}
      />
      </View>
    )
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1, 
  },
  topBar: {
    alignItems: 'center',
    justifyContent: 'center',
    height: 44,  
    backgroundColor: '#f5a623'
  },
  title: {
    fontSize: 24, 
    fontWeight: '900',
    color: 'white'
  },
  sectionHeader: {
    backgroundColor: '#f5a623', 
    fontSize: 20, 
    padding: 5, 
    color: '#fff'
  }, 
  item: {
    fontSize: 15, 
    padding: 5, 
    color: '#000', 
    backgroundColor: '#f5f5f5'
  }
})
```

SectionList Demo UI

<p align="center">
 <img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit10/Images/section-lists.png" width="340" height="650" />
</p>




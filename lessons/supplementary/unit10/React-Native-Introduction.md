## React-Native Introduction

## What is React-Native
React-Native is a framework that enables you to build native apps (iOS and Android) using Javascript and React. As opposed to tools before like Cordova and PhoneGap, React-Native calls native framewords to build out the apps components such as a UIButton in React-Native calls UIKit's UIButton native framework at runtime. The user in turn gets a true native experience. Both react and react-native are tools started by Facebook. Those tools has since been open sourced and is heavily supported by the open source community. 

## How do we write and run React-Native 

## Prerequites needed in order to run and use React-Native 

Most tools and frameworks we need to use for react-native requires third party libraries. Node is a javascript runtime that has a package manager (e.g npm, yarn) that allows the installation of third party libraries similar to cocoapods in iOS development.

Let's get started.

> At this point if you do not have node installed or need to verify if node is installed run ```node -v``` if you get **command not found** in terminal then node is not installed, otherwise you will see the current version number of your node installation e.g v9.6.1. 

> If you do not have homebrew installed paste and run the following command in terminal 
```/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"```

> To install node run the following command ```brew install node```

> To upgrade node ```brew upgrade node```

What is **brew**  
Homebrew installs packages to their own directory and then symlinks their files into ```/usr/local```

One of the remarkable features of deveoping react-native apps is [**hot and live reloading**](https://facebook.github.io/react-native/blog/2016/03/24/introducing-hot-reloading.html). Hot reloading runs your application whenever there is a code change, so unlike developing an iOS app in Xcode where we have to command + R each time we want a new simulator run and waiiiit, hot reloading does this automatically whenever a change is detected. Hot loading is made possible through a tool called **watchman** again we will need to install watchman using **brew**.  

```brew install watchman```

A few ways and tools used to run react-native apps: 
* create-react-native-app cli (command line interface)
* expo cli 
* react-native cli

## Create-React-Native-App

Install the create-react-native-app cli using npm (node package manager) npm is part our node installation. 
```
npm -g install create-react-native-app
```

Create a create-react-native-app
```
create-react-native-app my-app
```

If all goes successfully the following will be printed in terminal 

``` 
Success! Created my-app at /Users/alexpaul/Documents/React-Native/C4Q/create-react-native-apps/my-app
Inside that directory, you can run several commands:

  yarn start
    Starts the development server so you can open your app in the Expo
    app on your phone.

  yarn run ios
    (Mac only, requires Xcode)
    Starts the development server and loads your app in an iOS simulator.

  yarn run android
    (Requires Android build tools)
    Starts the development server and loads your app on a connected Android
    device or emulator.
  

  yarn test
    Starts the test runner.

  yarn run eject
    Removes this tool and copies build dependencies, configuration files
    and scripts into the app directory. If you do this, you can’t go back!


We suggest that you begin by typing:

  cd my-app
  yarn start

Happy hacking!
```

Let's now run our app 

```yarn start```

What is **yarn**  
Yarn is a third party package manager used in Node. (Node alos has its default package manager called npm). According to Yarn, it caches every package it downloads so it never needs to download it again. It also parallelizes operations to maximize resource utilization so install times are faster than ever. 

> Installing ```yarn``` if not already installed. ```npm -g install yarn```

Now we will have some options in which to run and view the app: 
* Android device: point the **expo** app to the QR code in terminal 
* iOS Device: also point the device to the QR code using the **expo** app or press s to email/text the app URL to your phone
* Simulaor: press a (Android) or i (iOS) to start the simulator

**Viewing and editing the code for our app**  
After running the above command to create your crna app (creat-react-native-app) the result will be a scaffold of packages, files, folders required in order to run a barebone creae-react-native-app

To view the folder structure and edit files in your create-react-native-app we will use [Visual Studio Code](https://code.visualstudio.com/). After downloading and installing VS Code, open VS Code and go to File -> Open and navigate to where you saved your **my-app** app then open it. You will know see the scaffold app that was build through the cli command in terminal. 

**App.js**  

```javascript 
import React from 'react';
import { StyleSheet, Text, View } from 'react-native';

export default class App extends React.Component {
  render() {
    return (
      <View style={styles.container}>
        <Text>Open up App.js to start working on your app!</Text>
        <Text>Changes you make will automatically reload.</Text>
        <Text>Shake your phone to open the developer menu.</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
```

Continue reading more about react-native from the official facebook react-native [documentation](https://facebook.github.io/react-native/)





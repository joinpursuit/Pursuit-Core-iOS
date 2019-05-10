## Introduction to Persistence with UserDefaults

Understanding and implementing data persistence is a vital part of iOS app development. Persistence is the manner in which data is saved to the user's iOS device. iOS has many persistent data storage solutions; in this lesson, we will be using **UserDefaults** as the data persistence mechanism.

### UserDefaults Overview

 [UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults/)  

The UserDefaults class provides a programmatic interface for interacting with the defaults system. The defaults system allows an app to customize its behavior to match a user’s preferences. For example, you can allow users to specify their preferred units of measurement or media playback speed. Apps store these preferences by assigning values to a set of parameters in a user’s defaults database. The parameters are referred to as defaults because they’re commonly used to determine an app’s default state at startup or the way it acts by default.

At runtime, you use UserDefaults objects to read the defaults that your app uses from a user’s defaults database. UserDefaults caches the information to avoid having to open the user’s defaults database each time you need a default value. When you set a default value, it’s changed synchronously within your process, and asynchronously to persistent storage and other processes.

### What are Property List

A property list is a representation of a hierarchy of objects that can be stored in the file system and reconstituted later.

A default object must be a property list—that is, an instance of (or for collections, a combination of instances of) NSData, NSString, NSNumber, NSDate, NSArray, or NSDictionary. If you want to store any other type of object, you should typically archive it to create an instance of NSData.

### Readings
1. [Apple Docs on UserDefaults](https://developer.apple.com/documentation/foundation/userdefaults/)
2. [An Introduction to NSUserDefaults](http://www.codingexplorer.com/nsuserdefaults-a-swift-introduction/)
3. [StackOverflow Post on UserDefault limits](https://stackoverflow.com/questions/35961005/how-much-data-can-i-store-in-nsuserdefaults)
4. [More Examples on UserDefaults](https://www.hackingwithswift.com/read/12/2/reading-and-writing-basics-userdefaults)
5. [Op: Don't Store Sensitive Data in UserDefaults](https://www.andyibanez.com/nsuserdefaults-not-for-sensitive-data/)
6. [How to save user settings using UserDefaults](https://www.hackingwithswift.com/example-code/system/how-to-save-user-settings-using-userdefaults)   

---
### Objectives

1. Become familiar with using `UserDefaults` to store data
2. Understand that `UserDefaults` is a light-weight, persistant storage option for small amounts of data that relate to how your app should be configured, based on the user's selection/choices.
3. Understand how the `Codable` protocol  allows for easy conversion between Swift objects and storeable `Data`

---
### Persistence

### `UserDefaults`: Light-weight, simple persistant storage

The intended use of `UserDefaults` is in the name: you want to store a user's default preferences when using your app. For example, suppose your app offered a "night mode". A user might only want to use your app in "night mode" because it's easier for them to read. It wouldn't be a great experience for them, however, if they had to switch the app into "night mode" every time they opened the app. Instead, you store the user's preference for using "night mode" in `UserDefaults` and then every time your app launches you retrieve that stored information and update your app before it finishes launching.

##### [Dark mode themes for the Twitter app](https://www.slashgear.com/twitter-night-mode-activated-on-ios-and-android-22452842/)  

---
### Trying out `UserDefaults`

> Note: We're going to be writing this code inside of `didFinishLaunching` in the `AppDelegate.swift` file.

Let's take a look at a few basic examples of storing and retrieving data.

It all begins with the `standard` singleton:

```swift
let defaults = UserDefaults.standard
```

> Note: It's possible to define a separate `UserDefaults` by creating one with a new id, but unnecessary for our purposes.

From here, it's as simple as calling `set(_:forKey:)` function on `defaults` in order to store data:

```swift
	let defaults = UserDefaults.standard

	// store a string
	let string = "Hello, World"
	defaults.set(string, forKey: "stringKey")

	// store a number
	let number = 10
	defaults.set(number, forKey: "numbersKey")

	// store an array
	let arr = ["Hello", "World"]
	defaults.set(arr, forKey: "arrKey")

	// store a dict
	let dict = ["Hello" : "World"]
	defaults.set(dict, forKey: "dictKey")
```

Retrieving that data is only slightly more work since you need to account for optionals and types:

```swift
	// retrieve a string
	if let aString = defaults.value(forKey: "stringKey") as? String {
		print("String Retrieved: \(aString)")
	}

	// retrieve a number
	if let aNumber = defaults.value(forKey: "numbersKey") as? Int {
		print("Number Retrieved: \(aNumber)")
	}

	// retrieve an array
	if let aArr = defaults.value(forKey: "arrKey") as? [String] {
		print("Array Retrieved: \(aArr)")
	}

	// retrieve a dict
	if let aDict = defaults.value(forKey: "dictKey") as? [String:String] {
		print("Dictionary Retrieved: \(aDict)")
	}
```


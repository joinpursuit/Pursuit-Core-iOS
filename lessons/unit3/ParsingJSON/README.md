# Parsing JSON

### Project Links

- [Downcasting Project](https://github.com/C4Q/AC-iOS-ParsingJSONExample)
- [Codable Project](https://github.com/C4Q/AC-iOS-CodableExample/tree/master)


### Resources

1. [Postman](https://www.getpostman.com/)
2. [What is JSON? - Squarespace](https://developers.squarespace.com/what-is-json/)
3. [Apple Docs - JSON](https://developer.apple.com/swift/blog/?id=37)
4. [Apple Docs - Bundle](https://developer.apple.com/documentation/foundation/bundle)
5. [Apple Docs - JSONSerialization](https://developer.apple.com/documentation/foundation/jsonserialization)
6. [Apple Docs - JSONDecoder](https://developer.apple.com/documentation/foundation/jsondecoder)

### Objectives

**Method One: Downcasting**

1. Create a custom class to model the JSON object
2. Create a convenience initializer takes a dictionary of [String: Any] as input
3. Create a class function that takes Data as input and returns an array of your custom objects by parsing the Data using downcasting and JSONSerialization
4. Convert a .json file to Data using Bundle.main

**Method Two: Codable**

1. Create a custom class to model the JSON object
2. Create additional wrapper classes to model the nesting in JSON
3. Convert a .json file to Data using Bundle.main
4. Use JSONDecoder to create an array of your custom objects


## 1. JSON

In earlier projects, the data we had was given as series of instances of a class:

<details>
<summary>Example</summary>

```swift
class HalloweenImage {
    var imageName: String
    var tags: [String]
    init(imageName: String, tags: [String]) {
        self.imageName = imageName
        self.tags = tags
    }
    static let images: [HalloweenImage] = [
     HalloweenImage(imageName: "pumpkinHead",
                    tags: ["Costume", "Pumpkin", "Scarecrow"]),
     HalloweenImage(imageName: "pumpkin",
                    tags: ["Pumpkin", "Spooky"]),
     HalloweenImage(imageName: "pumpkinWeb",
                    tags: ["Pumpkin", "Spider"]),
     HalloweenImage(imageName: "spiderHouse",
                    tags: ["Spider", "Haunted House"]),
     HalloweenImage(imageName: "hauntedHouse",
                    tags: ["Pumpkin", "Haunted House"]),
     HalloweenImage(imageName: "witchCat",
                    tags: ["Witch", "Cat", "Broom"]),
    HalloweenImage(imageName: "witchForest",
                   tags: ["Witch", "Moon", "Forest"]),
    HalloweenImage(imageName: "catInPumpkin",
                   tags: ["Cat", "Pumpkin", "Witch", "Spider"])
	]
}
```

</details>

Information on the internet is rarely formatted as Swift objects.  One of the most common ways that information can be transmitting it in the form of a Javascript Object (JSON).  A Javascript Object is what we would call a *Dictionary* in Swift.  It has a series of key/value pairs where the keys are of type String and the values are of type Any.

<details>
<summary>JSON Example</summary>

```javascript
[game of thrones json](http://api.tvmaze.com/shows/82/episodes)
```
</details>

We will soon see how to get JSON directly from an online URL.  For now, we will have a JSON file stored locally in our Xcode project.


## 2. Convert a .json file from the App Bundle to Data

In our file we have a .json file.  It's not very useful to us in its current form, so we'll need to convert it into a Swift type.  First, we'll have to look in the Bundle and find the location to the file.  Then we'll try to convert it into Data.

```swift
func loadData() {
	//Create a String path that is the filepath to the saved .json file
	if let path = Bundle.main.path(forResource: "gameofthronesinfo", ofType: "json") {
		//Convert the String into a URL
   		let myURL = URL(fileURLWithPath: path)
   		//Get the Data at the URL
   		//Getting the data could fail, so we must mark it with try.  
   		//try? means that if getting theData fails, we should return nil.
   		if let data = try? Data(contentsOf: myURL) {
   			//parse the data here
   		}
	}
}
```

# Parsing JSON with downcasting (pre-Swift 4 method)

## Downcasting 1. Create a model that represents your JSON.

Let's return to the JSON above which can be found at the link [here](http://api.tvmaze.com/shows/82/episodes).  In order to investigate its structure, we'll want to use a 3rd party service to look at its structure.  [Postman](https://www.getpostman.com) is one such service.  We now want to create a model that we can use to store this information.

```swift
class GOTEpisode {
	let name: String
	let mediumImage: String
	let largeImage: String
	let runtime: Int
	let summary: String
	init(name: String, mediumImage: String, largeImage: String, runtime: Int, summary: String) {
		self.name = name
		self.mediumImage = mediumImage
		self.largeImage = largeImage
		self.runtime = runtime
		self.summary = summary
	}
}
```


## Downcasting 2. Create a convenience initializer from [String: Any]

```swift
convenience init?(from episodeDict: [String: Any]) {
    guard let name = episodeDict["name"] as? String else {return nil }
    let runtime = episodeDict["runtime"] as? Int ?? 0
    let summary = episodeDict["summary"] as? String ?? "No summary available"
    var mediumImage: String?
    var largeImage: String?
    if let imageDict = episodeDict["image"] as? [String: String] {
        mediumImage = imageDict["mediumImage"]
        largeImage = imageDict["largeImage"]
    }
    self.init(name: name, mediumImage: mediumImage, largeImage: largeImage, runtime: runtime, summary: summary)
}
```

## Downcasting 3. Create a class function that converts Data to an array of custom objects


```swift
class func getEpisodes(from data: Data) -> [GOTEpisode] {
    var episodes = [GOTEpisode]()
    do {
        let json = try JSONSerialization.data(withJSONObject: data, options: [])
        guard let episodeArr = json as? [[String: Any]] else {return []}
        for episodeDict in episodeArr {
            if let episode = GOTEpisode(from: episodeDict) {
                episodes.append(episode)
            }
        }
        return episodeArr
    }
    catch {
        print("Error serializating data")
    }
}
```

## Downcasting 4. Call your class function to load data

```swift
if let path = Bundle.main.path(forResource: "gameofthronesinfo", ofType: "json") {
    let myURL = URL(fileURLWithPath: path)
    if let data = try? Data(contentsOf: myURL) {
        self.episodes = GOTEpisode.getEpisodes(from: data)
    }
}
```

# Parsing JSON with Codable (Swift 4)

## Codable 1. Create a model that represents your JSON.

Swift 4 introduced a new protocol called Codable.  It has many uses that we will see in class, but for now we will use it for parsing JSON.  For a class or struct to conform to Codable, it needs to be made up of classes/structs that conform to Codable.

Built-in Codable Types include:

- String
- Int
- Double
- Data
- URL
- Any collection made up of the above

Swift 4 also introduces a class JSONDecoder that converst JSON into a Swift type that implements Codable.  It will do this automatically if the names of your class match the names of the keys of the JSON.

```swift
struct GOTEpisode: Codable {
    let name: String
    let runtime: Int
    let summary: String
    let image: ImageWrapper
}

struct ImageWrapper: Codable {
    let medium: String
    let original: String
}
```

## Codable 2. Parse the data using JSONDecoder().decode(_:from:)

```swift
if let path = Bundle.main.path(forResource: "gameofthrones", ofType: "json") {
    let myURL = URL(fileURLWithPath: path)
    if let data = try? Data(contentsOf: myURL) {
        do {
            self.episodes = try JSONDecoder().decode([GOTEpisode].self, from: data)
        }
        catch {
            print("Error Decoding Data")
        }
    }
}
```


# Codable Practice


For this set of exercises, follow these general guidelines:

1. Create a new empty swift file named `Pods.swift` to add all of the structs you will be writing
2. Create a new file, `PodRequestor.swift` to create a request for each example problem. You should name these functions like `func example1Request`, `func example2Request`, etc...
3. Call each new request in either the `AppDelegate`'s `didFinishLaunching` or in `ViewController`'s `viewDidLoad`
4. There are no tests for these exercises, so instead print out to console the result of each successful request. For example after creating a `Podcast` object, have `print("Podcast created: ",  podcast.podcast)`
5. Exercise answers are provided to you under `Exercises/Exercises.md`. Be sure to attempt a problem before checking the answer

> Note: For each of these exercises, make sure that you're checking out the JSON response for each URL using Postman. The response should match the snippets provided with the exercise questions, but you are to verify this.

#### Pod(s) Save America

---
*Example 1*: `https://api.myjson.com/bins/tq46v`

- Create a new model, `Podcast` that conforms to `Codable`
- Make a request the the URL listed and create an instance of `Podcast`

```json
{
    "podcast": "Pod Save America",
    "producer": "Crooked Media",
    "url": "https://itunes.apple.com/us/podcast/pod-save-america/id1192761536?mt=2"
}
```

---
*Example 2*:  `https://api.myjson.com/bins/182vl3`

-  Create a new wrapper, `PodInfo` to house a `Podcast` object

```json
{
    "pod": {
        "podcast": "Pod Save America",
        "producer": "Crooked Media",
        "url": "https://itunes.apple.com/us/podcast/pod-save-america/id1192761536?mt=2"
    }
}
```

---
*Example 3*: `https://api.myjson.com/bins/n8pev`

- Create a new struct, `Episode`

```json
{
  "title": "Making Redistricting Sexy Again...",
  "time": "1hr 19min",
  "released": "June 6 2017",
  "number": 1
}
```

---
*Example 4*: `https://api.myjson.com/bins/mn9t3`

- Expand `Pod` to include `[Episode]`

```json
{
    "pod": {
        "podcast": "Pod Save America",
        "producer": "Crooked Media",
        "url": "https://itunes.apple.com/us/podcast/pod-save-america/id1192761536?mt=2",
        "episodes": [
            {
                "title": "Making Redistricting Sexy Again...",
                "time": "1hr 19min",
                "released": "June 6 2017",
                "number": 1
            }
        ]
    }
}
```

---
*Example 5*: `https://api.myjson.com/bins/18qgcn`

- Extend `PodInfo` to expect an array of `Podcast`

```json
{
  "pods": [
    {
      "podcast": "Pod Save America",
      "producer": "Crooked Media",
      "url": "https://itunes.apple.com/us/podcast/pod-save-america/id1192761536?mt=2",
      "episodes": [
        {
          "title": "Making Redistricting Sexy Again...",
          "time": "1hr 19min",
          "released": "June 6 2017",
          "number": 1
        }
      ]
    },
    {
      "podcast": "The Daily",
      "producer": "New York Times",
      "url": "https://itunes.apple.com/us/podcast/the-daily/id1200361736?mt=2",
      "episodes": [
        {
          "title": "Friday July 7th",
          "time": "22min",
          "released": "June 7 2017",
          "number": 1
        }
      ]
    }
  ]
}
```

---
*Example 6*: `https://api.myjson.com/bins/7xv5z`

- Extend `PodInfo` to have a new property for `meta` data. The `meta` property should be of type `PodMeta` and also `Codable`

```json
{
    "meta": {
        "date_requested": "2017-07-07 17:23:50 +0000"
    },
    "pods": [
        {
            "podcast": "Pod Save America",
            "producer": "Crooked Media",
            "url": "https://itunes.apple.com/us/podcast/pod-save-america/id1192761536?mt=2",
            "episodes": [
                {
                    "title": "Making Redistricting Sexy Again...",
                    "time": "1hr 19min",
                    "released": "June 6 2017",
                    "number": 1
                }
            ]
        },
        {
            "podcast": "The Daily",
            "producer": "New York Times",
            "url": "https://itunes.apple.com/us/podcast/the-daily/id1200361736?mt=2",
            "episodes": [
                {
                    "title": "Friday July 7th",
                    "time": "22min",
                    "released": "June 7 2017",
                    "number": 1
                }
            ]
        }
    ]
}
```

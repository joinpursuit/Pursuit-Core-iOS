# Parsing JSON

### Project Links

- [Starting Project](https://github.com/lynksdomain/JsonParsing)


### Resources

1. [Postman](https://www.getpostman.com/)
2. [What is JSON? - Squarespace](https://developers.squarespace.com/what-is-json/)
3. [Apple Docs - JSON](https://developer.apple.com/swift/blog/?id=37)
4. [Apple Docs - Bundle](https://developer.apple.com/documentation/foundation/bundle)
5. [Apple Docs - JSONSerialization](https://developer.apple.com/documentation/foundation/jsonserialization)
6. [Apple Docs - JSONDecoder](https://developer.apple.com/documentation/foundation/jsondecoder)

### Objectives

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

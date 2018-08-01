## Persistence using Codable

## Objectives 
1. Encoding an Object to the Persistence store 
2. Decoding an Object to Persistence

## Resources 
1. [Review on the Codable class introduced in Swift 4](https://developer.apple.com/documentation/swift/codable)

## Further Reading 
1. [Networking and Persistence with JSON in Swift 4 (Part 1)](https://medium.com/@sdrzn/networking-and-persistence-with-json-in-swift-4-c400ecab402d)

## Exercises 
1. Refactor the NSKeyedArchiver Project to use Swift's 4 Codable 

_Making a class Codable for Encoding and Decoding from Persistence_
```swift 
class DSA: Codable {}
```

_Encoding an Ojbect and writing it to the Persistence store using **PropertyListEncoder()**_
```swift
func saveDSAList() {
    let encoder = PropertyListEncoder()
    do {
        let data = try encoder.encode(lists)
        try data.write(to: dataFilePath(withPathName: DataModel.kPathname), options: .atomic)
    } catch {
        print("error encoding items: \(error.localizedDescription)")
    }
}
```
_Decoding an Ojbect to use in our app using **PropertyListDecoder()**_
```swift 
func load() {
    let path = dataFilePath(withPathName: DataModel.kPathname)
    let decoder = PropertyListDecoder()
    do {
        let data = try Data.init(contentsOf: path)
        lists = try decoder.decode([DSA].self, from: data)
    } catch {
        print("error decoding items: \(error.localizedDescription)")
    }
}
```

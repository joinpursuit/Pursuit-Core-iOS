# Standards
* Master Dictionaries
* Master Collections

# Objectives
Students will be able to:
* Declare and use Dictionaries 
* Understand common uses of Dictionaries
* Contrast and compare Dictionaries with Arrays

### Vocabulary: dictionary, hash, collection, key, value, mutable, immutable

# Resources
Swift Programming: The Big Nerd Ranch Guide, Chapter 10

Apple's [Swift Language Reference, Collections](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html#//apple_ref/doc/uid/TP40014097-CH8-ID105)

# Lecture
## Warm up

Dictionaries can be thought of like arrays where you use an index other than an int to 
access data. For this reason they're sometimes called associative arrays. Most often the key is a String. 
They're also called hash maps or hashes for short. This is because the key processed by
an algorithm called "hashing" to convert it to a unique-ish index.

## Creating and Populating a Dictionary

Again, politely ignore the book's old take on creating Dictionaries.

```swift
var baseballTeamsById = [Int:String]()
var baseballTeamsByCode: [String:String]

// check order in output
baseballTeamsById = [1001:"Mets", 1002:"Yankees", 1003:"Devil Rays", 1004:"Marlins"]
baseballTeamsByCode = ["NYN":"Mets", "NYA":"Yankees", "TB":"Devil Rays", "MIA":"Marlins"]
print(baseballTeamsByCode)
baseballTeamsByCode = [:]
```

**Question**: Compare ```baseballTeamsById``` to its array storage equivalent. What advantage
do we have with Dictionaries?

```
Since Dictionaries keys don't have to be represented in contiguous memory we can use integer 
keys that are either very large or far apart, or both without wasting space. This kind of array is
called a 'sparse array'.
```

## Accessing and Modifying a Dictionary

### Using count

```swift
print(baseballTeamsByCode.count)
```

### Reading a value from the dictionary

```swift
print(baseballTeamsByCode["NYN"])
```

Note how looking up by key returns an optional of the value type.

**Question**: Why is this?



### Modifying a value
```swift
baseballTeamsByCode["TB"] = "Rays"
```

Using ```updateValue(_:forKey:)``` allows us to check the return to see if 
the "updated" value existed already. If it didn't it will be created, but
```nil``` will be returned from updateValue.

```swift
baseballTeamsById[1003] = "Rays"
let newInstance = baseballTeamsByCode.updateValue("Rays", forKey: "TB")
print(newInstance)
print(baseballTeamsByCode)

if let instance = baseballTeamsByCode.updateValue("Rays", forKey: "TB") {
    print("Updated \(instance)")
}
else {
    print("Added")
}
```

## Adding and Removing Values

### Adding a value

```swift
baseballTeamsByCode["PIT"] = "Pirates"
baseballTeamsById[1005] = "Pirates"
```

### Removing a value

```swift
baseballTeamsByCode["PIT"] = nil
baseballTeamsById.removeValueForKey(1005)
```

```removeValueForKey(_:)``` offers the same functionality as ```updateValue(_:forKey:)```.

## Looping

```swift
for (key, value) in baseballTeamsByCode {
    print(key, value)
}

for v in baseballTeamsByCode.values {
    print(v)
}

for k in baseballTeamsByCode.keys {
    print(k)
}
```

### Can also capture a dictionary's keys into an array

```swift
var codes = Array(baseballTeamsByCode.keys)
```

## Immutable Dictionaries

As with Arrays, Dictionaries can be declared as constants and are more efficient that way.

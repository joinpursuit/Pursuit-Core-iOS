### Dictionaries
---

### Objectives
* Declare and use Dictionaries 
* Understand common uses of Dictionaries
* Contrast and compare Dictionaries with Arrays

### Readings
1. Swift Programming: The Big Nerd Ranch Guide, Chapter 10
1. Apple's [Swift Language Reference, Collections](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html#//apple_ref/doc/uid/TP40014097-CH8-ID105)

#### Vocabulary
1. **Dictionary** - an unordered collection of key-value associations.
1. **Hash** - a number generated from a string of text. (More info: [What exactly is a Hash?](https://cs.stackexchange.com/questions/55471/what-exactly-and-precisely-is-hash/55472))
1. **Key** - a hashable type (i.e. string) that is used to retrieve a corresponding value (which can be of any type). -[Apple Docs - Dictionary](https://developer.apple.com/documentation/swift/dictionary)
1. **Value** - the content/object being stored in the dictionary.

---

### 1. Warm up

Dictionaries can be thought of like arrays where you use an index other than an `Int` to access data. For this reason, they're sometimes called associative arrays. Most often the key is a `String`. 

They're also called hash maps or hashes for short. This is because the key is processed by an algorithm called "hashing" to convert it to a unique-ish index.

### 2. Creating and Populating a Dictionary

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

**Question**: Compare ```baseballTeamsById``` to its array storage equivalent. What advantage do we have with Dictionaries?

<details>
<summary><b>Solution</b></summary>

>Since Dictionaries keys don't have to be represented in contiguous memory we can use integer keys that are either very large or far apart, or both without wasting space. This kind of array is called a 'sparse array'.

</details>

### 3. Accessing a Dictionary

#### Using `.count()`

```swift
print(baseballTeamsByCode.count)
```

#### Reading a value from the dictionary

```swift
print(baseballTeamsByCode["NYN"])
```

Note how looking up by key returns an optional of the value type.

**Question**: Why is this?

<details>
<summary><b>Solution</b></summary>

>Looking up a value by key in a dictionary returns an optional because there is no guarantee that a value exists at the given key.

</details>

### 4. Modifying a Value
```swift
baseballTeamsByCode["TB"] = "Rays"
```

Using ```updateValue(_:forKey:)``` allows us to check the return to see if the "updated" value existed already. If it didn't it will be created, but
```nil``` will be returned from `updateValue`.

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

### 5. Adding and Removing Values

#### Adding a value

```swift
baseballTeamsByCode["PIT"] = "Pirates"
baseballTeamsById[1005] = "Pirates"
```

#### Removing a value

```swift
baseballTeamsByCode["PIT"] = nil
baseballTeamsById.removeValueForKey(1005)
```

```removeValueForKey(_:)``` offers the same functionality as ```updateValue(_:forKey:)```.

### 6. Looping

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

### 7. Create Array from a Dictionary's Keys 

```swift
var codes = Array(baseballTeamsByCode.keys)
```

### 8. Immutable Dictionaries

As with Arrays, Dictionaries can be declared as constants and are more efficient that way.

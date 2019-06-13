### Dictionaries
---

### Objectives
* Declare and use Dictionaries
* Understand common uses of Dictionaries
* Contrast and compare Dictionaries with Arrays

### Readings
1. Apple's [Swift Language Reference, Collections](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html#//apple_ref/doc/uid/TP40014097-CH8-ID105)

#### Vocabulary
1. **dictionary** - an unordered collection of key-value associations.
1. **hash** - a number generated from a string of text. (More info: [What exactly is a Hash?](https://cs.stackexchange.com/questions/55471/what-exactly-and-precisely-is-hash/55472))
1. **key** - a hashable type (i.e. string) that is used to retrieve a corresponding value (which can be of any type). -[Apple Docs - Dictionary](https://developer.apple.com/documentation/swift/dictionary)
1. **value** - the content/object being stored in the dictionary.

---

### 1. Introduction

A dictionary is a data structure that can be thought of as an array that is indexed by any value, not just `Int`. For this reason, dictionaries are sometimes called _associative arrays_: they associate a key value with another value. It's possible to use many different types as keys but in practice, most often the key is a `String`.

Dictionaries are also called hash maps. A map is created between two values by hashing a key,  generating an index from it that is used to store and look up a value. A hashing algorithm is a process that can quickly convert a non-numerical key into a hidden numerical index that is used to look up the value.

#### Keys are unique

Every key appears only once in a dictionary. It is unique.

#### Keys are unordered

Unlike an array keys are unordered

#### Use cases

Some motivations for indexing by key instead of number

* Index on natural data such as a name, zip code or airport code instead of
* Means to discover and enforce uniqueness
* Means to aggregate data associated with a key, e.g. a histogram

### 2. Creating and Populating

#### Declaration

```swift
var baseballTeamsByCode: [String:String] // 1
var baseballTeamsById = [Int:String]() // 2
var metsPlayers = [12:"Juan Lagares", 4:"Wilmer Flores", 7:"Jose Reyes"] // 3
```

There are a variety of ways to declare a dictionary. Consider the three above. In the first line `baseballTeamsByCode` is declared by type annotation. It is declaring the dictionary but not initializing it. It's taking no memory and the compiler will not allow it to be accessed until it is initialized.

In the second line, the type of `baseballTeamsById` is inferred from the initialization of an empty `[Int:String]` dictionary. Being initialized, this dictionary can be accessed. Compare these first two declarations closely as they look similar but are not exactly equivalent.

The third dictionary `metsPlayers` is being declared, initialized, and populated by a dictionary literal all at once.

As with arrays or any other Swift, dictionaries can be declared as constants and are more efficient that way.

#### Population

One way to populate a dictionary is to initialize, or re-initialize it with a dictionary literal.

```swift
var baseballTeamsByCode: [String:String]
var baseballTeamsById = [Int:String]()
baseballTeamsByCode = ["NYN":"Mets", "NYA":"Yankees", "TB":"Rays", "MIA":"Marlins"] // 1
baseballTeamsById = [1001:"Mets", 1002:"Yankees", 1003:"Rays", 1004:"Marlins"] // 2
```

At comment 1 `baseballTeamsByCode` is being initialized for the first time. At comment 2 `baseballTeamsById` is being reinitialized from the empty dictionary it was assigned during its declaration.

**Question**: If ```baseballTeamsById``` were stored in an array instead of a dictionary, using the same ids, what impact would that have on the amount of memory needed?

<details>
<summary><b>Solution</b></summary>

>Since Dictionaries keys don't have to be represented in contiguous memory we can use integer keys that are either very large or far apart, or both without wasting space. An array with a few indices over a large range is is called a _sparse array_.

</details>

### 3. Accessing values

#### Count dictionary elements

The `count` property on an array reports the number of key/value pairs stored in the dictionary.

```swift
print(baseballTeamsByCode.count)
```

#### isEmpty

The `isEmpty` property reports if the dictionary is empty. It is a more expressive way to find out if the dictionary is empty or has any elements.

#### Value by key

Dictionaries use the subscript operator `[]`, like arrays to access elements.

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

Using `updateValue(_:forKey:)` allows us to check the return to see if the "updated" value existed already. If it didn't it will be created, but
`nil` will be returned from `updateValue`.

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

We can add keys to an existing mutable dictionary at any time by assigning the value at an index.

```swift
baseballTeamsByCode["PIT"] = "Pirates"
baseballTeamsById[1005] = "Pirates"
```

#### Removing a value

```swift
baseballTeamsByCode["PIT"] = nil
baseballTeamsById.removeValue(forKey: 1005)
```

`removeValue(forKey:)` has the same  functionality as ```updateValue(_:forKey:)```.

We can remove all values by re-initializing to an empty dictionary.

```swift
baseballTeamsByCode = [:]
```

### 6. Iterating over a dictionary

A dictionary can be iterated over, getting a key and value on each iteration, or by keys or values alone.

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

#### Array from keys

A dictionary's indices are its keys. They can be captured into a separate array, the elements of which can be used to index the dictionary.

```swift
var codes = Array(baseballTeamsByCode.keys)
```

We can iterate over a dictionary we using its keys to access the value at each key with the subscript operator `[]`.

```swift
for c in codes {
    print(baseballTeamsByCode[c])
}
```

One reason to capture the keys of a dictionary into an array might be to change the keys before indexing the dictionary. For example we may want to access the dictionary in the order of its keys. This is done by sorting the keys and iterating over the dictionary with the ordered keys.

```swift
var codes = Array(baseballTeamsByCode.keys.sorted)

for c in codes {
    print(baseballTeamsByCode[c])
}
```

#### Standards

IOS: IOS.1

Language Fundamentals: LF.3, LF.3.c

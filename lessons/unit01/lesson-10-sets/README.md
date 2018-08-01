### Sets
---

### Objectives
* Declare and use Sets 
* Understand common uses of Sets
* Contrast and compare Sets with Dictionaries

### Readings
1. Swift Programming: The Big Nerd Ranch Guide, Chapter 11
1. Apple's [Swift Language Reference, Collections](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html#//apple_ref/doc/uid/TP40014097-CH8-ID105)

#### Vocabulary
1. **dictionary** - an unordered collection of distinct instances.
1. **hash** - a number generated from a string of text. (More info: [What exactly is a Hash?](https://cs.stackexchange.com/questions/55471/what-exactly-and-precisely-is-hash/55472))
1. **element** - a hashable type (i.e. string) that can be stored in a set.

---

### 1. Introduction

A Set is an unordered collection of distinct instances. This definition sets it apart from an Array, which is ordered and can accommodate repeated values. For example, an array could have the content [2,2,2,2], but a set cannot.

A Set has some similarities to a Dictionary, but it is also a little different. Like a dictionary, a set’s values are unordered within the collection. Similar to the requirement that a dictionary’s keys must be unique, Set does not allow repeated values. To ensure that elements are unique, Set requires that its elements conform to the protocol Hashable, as a dictionary’s keys do. However, while dictionary values are accessed via their corresponding key, a set only stores individual elements, not key-value pairs.

#### Elements are unique

Every element appears only once in a set. It is unique.

#### Elements are unordered

Unlike an array elements are unordered

#### Use cases

Some motivations...

* Means to discover and enforce uniqueness
* Means to remove duplicates from an array

### 2. Creating and Populating

#### Declaration

```swift

var accountNumbers: Set<Int> = []
var accountNumbers2 = Set<Int>()

```

Swift cannot use type inference on a set as it uses similar syntax to arrays. Instances must be declared with type annotation. 


#### Population

Sets, like arrays, can be populated with a literal on declaration.

```swift

var accountNumbers3: Set<Int> = [103456, 103761, 103764, 102778]

```

Sets can also be populated from an array. This will remove any duplicates.

```swift
let tas = ["Gabe", "Marcel", "Tom", "Gabe", "Karen"]
var uniqueTAs = Set(tas)
```

### 3. Accessing values

#### Count elements

The `count` property on a set reports the number of elements, just like arrays.

```swift
print(uniqueTAs.count)
```

#### isEmpty

The `isEmpty` property reports if the set is empty. It is a more expressive way to find out if the dictionary is empty or has any elements.

#### Accessing Elements

Because sets are unordered, there is no way to access a specific element. You can use the .contains method to see if an element is contained in the set.

```swift
uniqueTAs.contains("Tom")  // this will return true
```
You can loop through a set, just like arrays, to access all of its elements but you will not know the order with which they will be accessed, not like arrays. 

```swift
for name in uniqueTAs {
    print(name)
}
```

### 5. Adding and Removing Values

Add values using the .insert method on a set. This will return a tuple containing a bool to show whether the insertion was succesful (the value that you're inserting may already exist in the set) and the element you attempted to insert.

```swift
uniqueTAs.insert("Vic")  // returns (inserted: true, memberAfterInsert: "Vic")
```

To remove values from a set, use the .remove method. This returns the element you successfully remove. Notice that the return is optional, why is this?

```swift
uniqueTAs.remove("Vic")  // returns "Vic"
```

### 6. Unions, Intersections and Disjoint

The union of 2 sets contains all the unique elements of both sets. 

```swift
let moreStaff: Set<String> = ["Stefani", "Ben", "Karen", "Vic", "Gabe", "Will"]
let allStaff = moreStaff.union(uniqueTAs)  // returns ["Ben", "Vic", "Karen", "Tom", "Marcel", "Stefani", "Gabe", "Will"]
```

The intersection of 2 sets contains all the elements shared between them.

```swift
let intersectingStaff = moreStaff.intersection(uniqueTAs)  // returns ["Ben", "Gabe"]
```

Disjoint is a method used on 2 sets that returns a bool determining if the 2 sets share any elements. 

```swift
let someMoreNames: Set<String> = ["Dave", "Bill", "Gary", "Will"]
someMoreNames.isDisjoint(with: allStaff)   // returns false
someMoreNames.isDisjoint(with: uniqueTAs)   // returns true
```

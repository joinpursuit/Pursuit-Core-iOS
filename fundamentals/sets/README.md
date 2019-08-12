### Sets
---

### Objectives
* Declare and use Sets
* Understand common uses of Sets

### Readings
1. Apple's [Swift Language Reference, Collections](https://docs.swift.org/swift-book/LanguageGuide/CollectionTypes.html)
1. [Set Documentation](https://developer.apple.com/documentation/swift/set)  

#### Vocabulary
1. **set** -  distinct values of the same type in a collection with no defined ordering  
1. **hash** - a number generated from a string of text. (More info: [What exactly is a Hash?](https://cs.stackexchange.com/questions/55471/what-exactly-and-precisely-is-hash/55472))
1. **element** - a hashable type (i.e. string) that can be stored in a set.

---

### 1. Introduction

A Set is an unordered collection of distinct instances. This definition sets it apart from an Array, which is ordered and can accommodate repeated values. For example, an array could have the content [2,2,2,2], but a set cannot.

A Set has some similarities to a Dictionary, but it is also a little different. Like a dictionary, a set’s values are unordered within the collection. Similar to the requirement that a dictionary’s keys must be unique, Set does not allow repeated values. To ensure that elements are unique, Set requires that its elements conform to the [Hashable protocol](https://developer.apple.com/documentation/swift/hashable), as a dictionary’s keys do. However, while dictionary values are accessed via their corresponding key, a set only stores individual elements, not key-value pairs.

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

`var accountNumbers3: Set<Int> = [103456, 103761, 103764, 102778]`

Sets can also be populated from an array. This will remove any duplicates.

```swift
let fellows = ["Liana", "Ian", "Sunni", "Adam", "Carolina", "Sunni"]
var uniqueFellows = Set(fellows)
```

### 3. Accessing values

#### Count elements

The `count` property on a set reports the number of elements, just like arrays.

```swift
print(uniqueFellows.count)
```

#### isEmpty

The `isEmpty` property reports if the set is empty. It is a more expressive way to find out if the dictionary is empty or has any elements.

#### Accessing Elements

Because sets are unordered, there is no way to access a specific element. You can use the .contains method to see if an element is contained in the set.

`uniqueFellows.contains("Ian")  // this will return true`

You can loop through a set, just like arrays, to access all of its elements but you will not know the order with which they will be accessed, not like arrays.

```swift
for name in uniqueFellows {
    print(name)
}
```

### 4. Adding and Removing Values

Add values using the `.insert` method on a set. This will return a tuple containing a bool to show whether the insertion was successful (the value that you're inserting may already exist in the set) and the element you attempted to insert.

`uniqueFellows.insert("Matthew")  // returns (inserted: true, memberAfterInsert: "Matthew")`

To remove values from a set, use the .remove method. This returns the element you successfully remove. Notice that the return is optional, why is this?

`uniqueFellows.remove("Ian")  // returns "Ian"`

### Fundamental Set Operations

<p align="center">
<img src="https://docs.swift.org/swift-book/_images/setVennDiagram_2x.png" width="700" height="500" />  
</p>

### 5. Unions, Intersections and Disjoint

The union of 2 sets contains all the unique elements of both sets.

```swift
let evenNumbers: Set<Int> = [2, 4, 6, 8, 10]
let numbersFrom1to10: Set<Int> = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
let allNumbers = evenNumbers.union(numbersFrom1to10)  // returns unsorted list
print(allNumbers.sorted()) // will sort allNumbers as expected [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
```

The intersection of 2 sets contains all the elements shared between them.

`let intersectingNumbers = evenNumbers.intersection(numbersFrom1to10)  // returns unsorted list`

Disjoint is a method used on 2 sets that returns a bool determining if the 2 sets share any elements. Note: it returns true if the sets ARE disjointed.

```swift
let staff: Set<String> = ["Istishna", "Olimpia", "David", "Alex", "Alan"]
let teacherAssistants: Set<String> = ["Kaniz", "Maggie", "Jermaine"]
let teachersAssistantsStaffDisjoint = teacherAssistants.isDisjoint(with: staff)   // returns true
let staffFellowsDisjoint = staff.isDisjoint(with: fellows)   // returns false

print("teachersAssistantsStaffDisjoint is \(teachersAssistantsStaffDisjoint)")
print("staffFellowsDisjoint is \(staffFellowsDisjoint)")
```

### 6. Set Membership and Equality

```swift
let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

print(houseAnimals.isSubset(of: farmAnimals)) // true
print(farmAnimals.isSuperset(of: houseAnimals)) // true
print(farmAnimals.isDisjoint(with: cityAnimals)) // true
```

### Practice Problems

#### 1. Does the following compile?

```swift
struct Person {
  let name: String
  let age: String
}
let alex = Person(name: "Tom", age: "29")
let sally = Person(name: "Sally", age: "26")

let names: Set<Person> = [alex, sally]
```
<details>
    <summary>Solution</summary>

    No. The reason is that Person does not conform to the Hashable protocol. The elements in a Set needs to conform to Hashable in order to keep a Set's elements unique.

</details>

Fix the code above so it compiles.

<details>
    <summary>Solution</summary>

```swift
struct Person: Hashable {
  let name: String
  let age: String
}
let alex = Person(name: "Tom", age: "29")
let sally = Person(name: "Sally", age: "26")
```

</details>


#### 2. Perform fundamental set operations on the following lists:

1. Find the intersection and print the result
2. Find the symmetric difference and print the result
3. Find the union and print the result
4. What is the outcome of subtracting list 2 from list1? Print the result

```swift
let list1: Set = [1, 3, 4, 6, 2, 7, 9]
let list2: Set = [3, 7, 13, 10, 4]
```

### Standards

IOS: IOS.1

Language Fundamentals: LF.3, LF.3.b

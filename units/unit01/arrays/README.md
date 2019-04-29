### Arrays
---

### Objectives
* Access and Modify Arrays
* Iterate through arrays
* Use common array methods

### Readings
1. Apple's [Swift Language Reference, Collections](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html#//apple_ref/doc/uid/TP40014097-CH8-ID105)

#### Vocabulary
1. **Array** - stores values of the same type in an ordered list
1. **Collection** - a Foundation framework object whose primary role is to store other objects in the form of arrays, dictionaries, and sets. -[Apple](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Collection.html)
1. **Index** - a number that indicates the position of an element in an ordered collection (i.e. array) [Ray Wanderlich - Seek to Arrays](https://www.raywenderlich.com/123100/collection-data-structures-swift-2)
1. **Subscript** - a symbol or number used to identify an element in an array. Usually, the subscript is placed in brackets following the array name (i.e. `arrayName[0] //accesses first element`)

---

### 1. The case for Arrays

So far, the types we have seen have a fairly straightforward means of storage.

How is a Bool stored in memory?

How is an Int stored in memory?

With the exception of String, we only have to worry about storing a single thing somewhere in the computer.  But what happens when we want to store many Integers instead of just one?  Without using an Array, how could we store multiple Ints?

<details>
<summary>Solutions</summary>

A tuple of Ints, e.g (4, 9, 10)

a Range of Int, e.g 3..<10
</details>

While these are great for some situations, there are certain cases that we can't use them to model.

```swift
var testScores = (97, 93, 95)
//Can we add a new score to the tuple above?  Why or why not?
```

```swift
var availableJerseyNumbers = 3..<31
//Can we remove the number 23 as an available jersey number in the range above?  Why or why not?
```

We'll need something more robust that can keep track of a *collection* of Ints.


### 2. Initalizing an Array

Use the syntax below to intialize an Array with type annotation.

```swift
var bucketList: [String]
```
This is a way to initialize an Array with a literal.

```swift
// initialize with Array literals
var planets: [String] = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
var dwarfPlanets: [String] = ["Pluto"]
```

But with the help of type inference we don't need the annotation.

```swift
var planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
var dwarfPlanets = ["Pluto"]
```

We can also make an Array of repeated objects
```swift
var threeDoubles = [Double](repeating: 0.0, count: 3)
var anotherThreeDoubles = Array(repeating: 0.0, count: 3)
```



### 3. Accessing values inside an array.

Know that we now how to make an array, how can we use it?  One of the common things we want to do is access a particular *element* of an array.

We can use subscript notation for Arrays to access a particular element.


```swift
let thirdRockFromTheSun = planets[2]
```

**Question** Why is the thirdRockFromTheSun at 2 and not 3?

<details>
<summary>Answer</summary>
Because index numbers start at 0
</details>

Let's practice printing some planets:

Print the first planet

Print the last planet

Print the second to last planet

Print the middle planet (What are different ways this can be interpreted?)


### 4. Useful Array Library Methods

Other than accessing characters directly, the Swift Standard Library gives us some powerful tools for manipulating arrays

Properties
- first
- last
- count
- isEmpty

What do you think the above properties will do?  What types will they give us and why?

<details>
<summary>Answer</summary>

let myArr = [3,4,1,3,2,5]
myArr.first //Int?: 3
myArr.last //Int?: 5
myArr.count //Int: 6
myArr.isEmpty //Bool: False

</details>

Methods
- remove(at:)
- append(_:)
- reverse()
- popLast()


### 5. Arrays are Value Types

Arrays copy on assignment because they are value types.
```swift
var planetas = planets
```
**Question**: How can we go about proving this?

<details>
<summary><b>Solution</b></summary>

>Let's make a change to one of the elements in `planets`. Then, we can see if that change had any effect on `planetas`.

```swift
print(planetas == planets) //true

planets.remove(at: 0)

//planets == ["Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
//planetas == ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]

print(planetas == planets) //is now false

```
>Although `planetas` was originally given the value of `planets`, a change to `planets` does not alter `planetas` becuase arrays copy on assignment. 

</details>

---

### 6. Array Modification Methods In Depth

#### Use `.append(_:)` to add new elements to end of array
```swift
var planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
planets.append("Pluto") //Bringing Pluto back
```

The signature of the append method on Array is ```append(_:)```.  What is that thing that looks like a broken smiley? We'll look at it closer when we cover functions. For now it's good to just think of ```_``` as a placeholder, similar to how it was a wildcard/placeholder in ```case``` of a ```switch```statement. Here it means that append takes one argument and that we haven't explicitly renamed it.

#### Append an entire array with `+` or `+=`

```swift
let moonsOfJupiter = ["Io", "Europa", "Callisto", "Ganymede"]
var someHeavenlyBodies = planets + ["Sun", "Moon", "Halley's Comet"]
someHeavenlyBodies += moonsOfJupiter
```

#### Use `.remove(at:)` to remove *(and return)* an element at a specified index

```swift
planets.remove(at: 8)
```

**Question** What's a more general solution for removing the last element of an array?

<details>
<summary><b>Solution</b></summary>

```swift
planets.remove(at: planets.count - 1)
```

</details>

**Question** What might be a performance consideration with ```.remove(at:)```?

<details>
<summary><b>Solution</b></summary>

>Removing any element, except the last one, causes the other elements to shift over to fill in the missing gap in the array.

</details>

---
### 7. Subscript Access in Detail

```swift
// single
let earth = planets[2]
let gasGiants = planets[4...6] 
```

What type is gasGiants (in snippet above)?
<details>
<summary><b>Solution</b></summary>

`gasGiants` is an ArraySlice

</details>


An ArraySlice is basically like an Array, except it keeps the indicies from the original Array.

#### Use Subscripting to Read an Element
```swift
print(planets[2])
```

#### Use Subscripting to Modify an Existing Element
```swift
planets[2] += " (home)"
```

#### Use Subscripting to Replace an Element
```swift
planets[6] = "Urectum" // https://theinfosphere.org/Urectum
```

---

### 8. Iterating through an Array

Just like we wanted to access each Character in a String, we often want to access each element in an Array.  Fortunately, Arrays are much easier to traverse.

We have two main ways that we can iterate through an Array.

```swift

let myFavoriteStrings = ["this one!", "I like this String", "poetry", "bison and camels"]

//Method one: for in loop
for str in myFavoriteStrings {
    print(str)
}

//Method two: Access each index
for index in 0..<myFavoriteStrings.count {
    let currentString = myFavoriteStrings[index]
    print(currentString)
}
```

Practice: Use a while loop to print out each string in ```myFavoriteStrings```





### 9. Array Equality

Arrays support the ```==``` operator.

```swift
let galileanMoons = ["Io", "Europa", "Callisto", "Ganymede"]
let moonsOfJupiter = ["Io", "Europa", "Callisto", "Ganymede"]
galileanMoons == moonsOfJupiter //true
```

Practice: Without using the ```==``` operator to compare Arrays, write code that prints out if galilieanMoons is equal to moonsOfJupiter


### 10. Immutable Arrays

Try to declare arrays as constants (using ```let```) if you know you will not change them.
This allows the Swift compiler to make optimizations.


### 11. Arrays and Strings

Because Arrays are now our favorite type, we can even turn a String into an Array!

```
let myStr = "This could be anything, really."
let myStrAsArray = Array(myStr.characters)
```

Now we don't need to worry about String indexing!

### 12. Arrays can be multidimensional

```swift
let theMatrix = [[1, 2, 3],
                 [4, 5, 6],
                 [7, 8, 9]]

print(theMatrix[2][0]) // 7
```

Practice:  Print out the element in each corner, then print out the element in the middle.

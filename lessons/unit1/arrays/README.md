### Arrays
---

### Objective
* Access and Modify Arrays
* Iterate through arrays
* Use common array methods

### Readings
1. Swift Programming: The Big Nerd Ranch Guide, Chapter 9
1. Apple's [Swift Language Reference, Collections](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html#//apple_ref/doc/uid/TP40014097-CH8-ID105)

#### Vocabulary
1. **Array** - stores values of the same type in an ordered list
1. **Collection** - a Foundation framework object whose primary role is to store other objects in the form of arrays, dictionaries, and sets. -[Apple](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Collection.html)
1. **Index** - a number that indicates the position of an element in an ordered collection (i.e. array) [Ray Wanderlich - Seek to Arrays](https://www.raywenderlich.com/123100/collection-data-structures-swift-2)
1. **Subscript** - a symbol or number used to identify an element in an array. Usually, the subscript is placed in brackets following the array name (i.e. `arrayName[0] //accesses first element`)

---

### 1. Warm up

Note: p.75 of the Big Nerd Ranch book shows an old syntax for creating and initializing an Array. Ignore it. Use this syntax at all times.

```swift
var bucketList: [String]
```

This illustrates a core challenge for all software development that's particularly noticeable in iOS at this time: the need to improve the technology, sometimes at the expense of previous versions.

### 2. Initializing an Array

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

Other initializers:
```swift
var threeDoubles = [Double](repeating: 0.0, count: 3)
threeDoubles = [] // empties the array
threeDoubles.isEmpty
```
### 3. Arrays are Value Types

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

### 4. Array Modification Methods

#### Use `.append(_:)` to add new elements to end of array
```swift
var planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]

// what the heck
planets.append("Pluto")
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

#### Use `.count()` to determine the number of elements in an array


```swift
planets.count
```

---
### 5. Subscript Access

```swift
// single
let earth = planets[2]
let gasGiants = planets[4...6] 
```

What type is gasGiants (in snippet above)?
<details>
<summary><b>Solution</b></summary>

> `gasGiants` is an array.

</details>


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

### 6. Array Equality

Arrays support the ```==``` operator.

```swift
let galileanMoons = ["Io", "Europa", "Callisto", "Ganymede"]
galileanMoons == moonsOfJupiter
```

### 7. Immutable Arrays

Try to declare arrays as constants (using ```let```) if you know you will not change them.
This allows the Swift compiler to make optimizations.


### 8. Arrays can be multidimensional

```swift
let theMatrix = [[1, 2, 3],
                 [4, 5, 6],
                 [7, 8, 9]]

print(theMatrix[2][0]) // 7
```

---
### Exercises

Write a loop to print out `theMatrix`.

<details>
<summary><b>Solution</b></summary>

```swift
for i in 0..<theMatrix.count {
    for j in 0..<theMatrix.count {
        print(theMatrix[i][j])
    }
}

```

</details>

#### Applications of Arrays
Find an element of an array.

<details>
<summary><b>Solution</b></summary>

```swift
let shamrock = "\u{2618}"
let fourLeafClover = "\u{1f340}"

let clovers = [shamrock, shamrock, shamrock, fourLeafClover, shamrock, shamrock]

if clovers.contains(fourLeafClover) {
    print("You've got some good luck! You found a four-leaf clover: \(fourLeafClover)")
} else {
    print("You did not find a four-leaf clover. No good luck for you!")
}
```

</details>

Find a missing number in 0...100

<details>
<summary><b>Solution</b></summary>

```swift
var zeroToOneHundred = Array(0...100)

let randomIndex = Int(arc4random_uniform(100)) //This line creates a random number
print(randomIndex)
let removedNumber = zeroToOneHundred.remove(at: randomIndex) //Now, we are able to remove a random element in the array

var i = 0
while i+1 < zeroToOneHundred.count {
    
    if zeroToOneHundred[i+1] - zeroToOneHundred[i] > 1 {
        print("Found missing number between \(zeroToOneHundred[i+1]) & \(zeroToOneHundred[i])")
        print("Missing Number: \(zeroToOneHundred[i] + 1)")
        break
    } else if removedNumber == 0 {
        print("Missing Number: \(removedNumber)")
        break
    }
    i += 1
}
```

</details>

Find the largest number.

<details>
<summary><b>Solution</b></summary>

```swift
let arrayOfNumbers = [3, 50, 28, 35, 17, 9, 0, 91, 63, 2]

var maxInArrOfNums = Int.min

for num in arrayOfNumbers {
    if num > maxInArrOfNums {
        maxInArrOfNums = num
    }
}

print(maxInArrOfNums)
```

</details>

Find the second smallest number.

<details>
<summary><b>Solution</b></summary>

```swift
var smallestInArrOfNums = Int.max
var secondSmallestInArrOfNums = Int.max

for num in arrayOfNumbers {
    if num < smallestInArrOfNums {
        secondSmallestInArrOfNums = smallestInArrOfNums
        smallestInArrOfNums = num
    } else if num >= smallestInArrOfNums && num < secondSmallestInArrOfNums {
        secondSmallestInArrOfNums = num
    }
}

print(secondSmallestInArrOfNums)
```

</details>

#### Strings as Arrays
Copy the characters of a string into an array.

<details>
<summary><b>Solution</b></summary>

```swift
let thisString = "Today is a wonderful day to learn about arrays!"
var thisStringChars: [Character] = []

for char in thisString.characters {
    thisStringChars.append(char)
}
```

</details>

Find a character in that array.

<details>
<summary><b>Solution</b></summary>

```swift
let characterToFind = "a"
var characterNotFound = true
var iterations = 0

while characterNotFound {
    for char in thisString.characters {
        iterations += 1
        
        if String(char) == characterToFind {
            characterNotFound = false
            print("The character `\(characterToFind)` was found in \(iterations) iterations.")
            break
        }
    }
}
```

</details>

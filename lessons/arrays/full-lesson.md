# Standards
Use collections to organize information and solve problems

# Objectives
Students will be able to:
* Access and Modify Arrays
* Iterate through arrays
* Use common array methods

### Vocabulary: array, collection, mutable, immutable

# Resources
Swift Programming: The Big Nerd Ranch Guide, Chapter 9

Apple's [Swift Language Reference, Collections](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/CollectionTypes.html#//apple_ref/doc/uid/TP40014097-CH8-ID105) *Seek to Optionals* in right hand menu.

# Assessment Materials
## Midday Check-in and solutions

# Lecture
## Warm up

# Creating an Array

Note: p.75 of the Big Nerd Ranch book shows an old syntax for creating and initializing an
Array. Ignore it. Use this syntax at all times.

```swift
var bucketList: [String]
```

This illustrates a core challenge for all software development that's particularly noticeable 
in iOS at this time: the need to improve the technology, sometimes at the expense of previous versions.

## Initializing an Array

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

Other initializers.


```swift
var threeDoubles = [Double](count: 3, repeatedValue: 0.0)
threeDoubles = [] // empty the array
threeDoubles.isEmpty
```
# Accessing and Modifying Arrays

## Arrays copy on assignment
```swift
var planetas = planets
```
**Question**: How can we go about proving this?

## append
```swift
var planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]

// what the heck
planets.append("Pluto")
```

The signature of the append method on Array is ```append(_:)```.  What is that thing that
looks like a broken smiley? We'll look at it closer when we cover functions. For now it's 
good to just think of ```_``` as a placeholder, similar to how it was a wildcard/placeholder
in ```case``` of a ```switch``` statement. Here it means that append takes one argument
and that we haven't explicitly renamed it.

### Append an entire array

```swift
let moonsOfJupiter = ["Io", "Europa", "Callisto", "Ganymede"]
var someHeavenlyBodies = planets + ["Sun", "Moon", "Halley's Comet"]
someHeavenlyBodies += moonsOfJupiter
```

## removeAtIndex

```swift
planets.removeAtIndex(8)
```

**Question** What's a more general solution for removing the last element of an array?

**Question** What might be a performance consideration with ```removeAtIndex(_:)```?

## count

```swift
planets.count
```

## Subscript access

```swift
// single
let earth = planets[2]
let gasGiants = planets[4...6] // what type is gasGiants?
```

### read
```swift
print(planets[2])
```

### append
```swift
planets[2] += " (home)"
```

### replace
```swift
planets[6] = "Urectum" // https://theinfosphere.org/Urectum
```

## Array Equality

Arrays support the ```==``` operator.

```swift
let galileanMoons = ["Io", "Europa", "Callisto", "Ganymede"]
galileanMoons == moonsOfJupiter
```

## Immutable Arrays

Try to declare arrays with ```let``` if you know you will not change them.
This allows the Swift compiler to make optimizations.


## Arrays can be multidimensional

```swift
let theMatrix = [[1, 2, 3],
                 [4, 5, 6],
                 [7, 8, 9]]

print(theMatrix[2][0])
```
## NYT
Write a loop to print out the matrix.

## Applications of Arrays
1. Find an element of an array.
2. Find a missing number in 0...100
3. Find the largest number.
4. Find the second smallest number.

### Strings as Arrays
1. Copy the characters of a string into an array.
2. Find a character in that array.

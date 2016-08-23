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
var planets: [String] = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
var dwarfPlanets: [String] = ["Pluto"]
```

But with the help of type inference we don't need the annotation.

```swift
var planets = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune"]
var dwarfPlanets = ["Pluto"]
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

## Immutable Arrays

Immutable and constant are somewhat exchangeable. 

Uses let. 



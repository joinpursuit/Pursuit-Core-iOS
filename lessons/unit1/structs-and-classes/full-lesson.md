# Standards
Solve problems with Enumerations, Structures and Classes

# Objectives
Students will be able to:
* Create structs and classes
* Understand the differences between structs and classes
* Understand when to use a struct vs a class
* Initialize structures
* Understand that structures are value types and what this implies

# Resources
Swift Programming: The Big Nerd Ranch Guide, Chapter 15, Structs and Classes

Apple's [Swift Language Reference, Classes and Structures](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/ClassesAndStructures.html#//apple_ref/doc/uid/TP40014097-CH13-ID82)

And [Swift Language Reference, Methods](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Methods.html#//apple_ref/doc/uid/TP40014097-CH15-ID234)


## Warm up

I'm choosing to focus on specific topics about ```struct```s and ```class```es to reflect 
what I believe is essential. We'll return to the topics we skip or touch lightly as they
come up in our applications.

## Lecture

From the Apple documentation:

> An instance of a class is traditionally known as an object. However, Swift classes and structures are 
> much closer in functionality than in other languages, and much of this chapter describes functionality 
> that can apply to instances of either a class or a structure type. Because of this, the more general 
> term instance is used.

## Structures and Classes

From the Apple documentation:

> ###Comparing Classes and Structures
>
> Classes and structures in Swift have many things in common. Both can:
> 
> * Define properties to store values
> * Define methods to provide functionality
> * Define subscripts to provide access to their values using subscript syntax
> * Define initializers to set up their initial state
> * Be extended to expand their functionality beyond a default implementation
> * Conform to protocols to provide standard functionality of a certain kind
> For more information, see Properties, Methods, Subscripts, Initialization, Extensions, and Protocols.
> 
> Classes have additional capabilities that structures do not:
> 
> * Inheritance enables one class to inherit the characteristics of another.
> * Type casting enables you to check and interpret the type of a class instance at runtime.
> * Deinitializers enable an instance of a class to free up any resources it has assigned.
> * Reference counting allows more than one reference to a class instance.


### Properties

Properties are constants and variables encapsulated inside classes and structures.

> From Apple:

```swift
struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

let someResolution = Resolution()
let someVideoMode = VideoMode()

print("The width of someResolution is \(someResolution.width)")
```

#### Classes are Reference types

> From Apple:

```swift
let hd = Resolution(width: 1920, height: 1080)
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "1080i"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0

print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")

```

## Project

### Movie as an Object

Let's create a movie object based on the data structure we used in Homework #2. 

1. Make a Movie.swift file.
2. Create a Movie class using variables as existing types with default values.
3. Populate an array of Movie objects converted from the familiar array of dictionaries.

### Inheritance

In my opinion there's a little too much fascination with inheritance. It is necessary to learn
but you spends more time simply modeling one thing than you do developing a hierarchy.
To get started, **encapsulation** is the more important concept to understand than inheritance is.

1. Create a Person class.
2. Create an Actor class with Person as its parent. Add two fields, ```breakoutYear``` and  ```breakoutRole```. 

3. Create a President class with Person as its parent. Add two fields, ```yearEnteredOffice```
and ```yearLeftOffice```.

### Instance method

Let's create a President class to illustrate an instance method ```inOffice(Int) -> Bool```.

### Type Methods

```static``` in ```struct```s and ```class``` in ```class```.

### Review and Wrapup
* Compare and contrast the use of ```struct``` and ```class```.
* What are type methods?

## Exercises

1. Work Actor class into the Movie class by making ```cast``` type [Actor] and populating it.
2. Make the ```genre``` field in Movie of type ```Genre```, an enumeration.
3. Build a ```presidents``` array (of type [President])by processing this array of Strings:
```swift
presidentData = ["1993, 2000, Bill Clinton", "2001, 2008, George W. Bush", "2009, 2016, Barack Obama"]
```
4. Rebuild the ```presidentsByYear``` dictionary based on the ```presidents``` array:
Your output dictionary should contain a key for every relevant year and use the ```inOffice``` method
on ```President```.
5. Re-work the original homework based on our "array of dictionaries" to work with the new
array of objects. Here are the problems

> WARM UPS
> 
> 1. Print the name of the first movie.

> 2. Print a list of all movie names, preferably on one line.

> 3. Print a list of all movie years and names as follows:
> 2015: Minions
> 2001: Shrek
> .
> .
> .

> 4. Iterate over all movies. Inside the loop use switch on genre. Print each title
> and add an appropriate emoji to represent its genre

> 5. In code, not by literal initialization, create a new dictionary called moviesByName of type
> [String:[String:Any]]. Copy the elements of movies, adding each to moviesByName
> with the name as key. Sort by name.

> 6. Do the same thing as in (5) for year and genre, creating a new dictionary for each one.
> What happens, and why? How might you change your approach?

> THE PROJECT
>
> Iterate over all movies and print a formatted blurb about each one. Use this out put of the
> first movie as a guide:

> Minions came out in 2015. It was an animation staring Sandra Bullock, Jon Hamm, and Michael Keaton.
> Barack Obama was president that year.


> Note how it should generate "an animation" in contrast to "a drama"
> Similarly notice the "and" before the last member of the cast listed.
> Get it to work any which way you can but try your best to follow these guidelines
>   * Don't use forced unwrapping
>   * Use multiple bindings in one "if let" (no pyramid of doom)


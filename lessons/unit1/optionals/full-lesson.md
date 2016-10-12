# Standards
Master optionals
Master error prevention and handling constructs

# Objectives
Students will be able to:
* Understand the purpose of optionals
* Declare optionals
* Unwrap optionals
* Bind optionals
* Chain optionals
* Write idiomatic Swift

### Vocabulary: optional, initialize, nil, binding, let, set, idiomatic, nested, diagnostic, lifecycle

# Resources
Swift Programming: The Big Nerd Ranch Guide, Chapter 8

Apple's [Swift Language Reference, The Basics](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309) *Seek to Optionals* in right hand menu.

# Assessment Materials
## Midday Check-in and solutions

# Lecture
## Warm up
Thought experiment and problem. Imagine we’re writing code that interfaces with a digital thermometer. 

Given:
* We store the temperature in a variable. 
* There is a function we can call called getTemperatureFromSensor()
* Sometimes the thermometer is broken.

In plain English, state how we know the reading is valid. How would our solution work in the kitchen? 
In deep space? On the sun?

### Exercise 

Declare and initialize a variable of type Double called temperature

```swift
var temperature = 0.0
```

How would you re-initialize it?

```swift
temperature = 0.0
```

## Optionals 
Optionals in situations where we know a value may be absent. An absent value is known as nil.

An optional says:
There is a value, and it equals x **or** there isn’t a value at all. Let's declare an optional

```swift
temperature: Double?
```

Note we no longer have to initialize it. In addition to having the technical value of making code
safer, it also makes it clearer to the reader. We know that an optional may or may not have a value.

# Exercises

Declare an optional String, Int, and Double.

```swift
// imagine a book selling app
// a book may or may not have a dedication, reviews or a discount
var bookDedication: String?
var bookReviewCount: Int?
var bookDiscount: Double?
```

Print an assigned optional. What do you see?

```swift
print(bookDedication)

// prints 'nil'
```

Declare a non-optional without assigning it and print it
```swift
var bookTitle: String
print(bookTitle)
// error: variable 'bookTitle' used before being initialized
```

Declare two variables, one as a non-Optional and another as an Optional of that type. 
Try assigning them to one another.

```swift
var bookTitle: String = "The Hobbit"
var secondTitle: String?
//secondTitle = "There and Back Again"
print(bookTitle)

secondTitle = bookTitle // this works
print(secondTitle)

bookTitle = secondTitle // this doesn't

// we need to unwrap secondTitle
bookTitle = secondTitle! // ! force-unwraps (not the best way in _most_ cases)
```

## Exercises

Force unwrap an optional and print.

Force unwrap an unset optional and print.

Observe how Force unwrapping can trigger runtime errors (crash).

**Questions**: 

* What is the difference between a compile time error and a run time error. 
* Which is better?
* How do optionals protect us from run time errors?

Force unwrapping essentially disables this protection.

## Optional Binding
Binding to the rescue. Binding allows us to query an optional for set/nil status. 

```swift
var bookTitle: String = "The Hobbit"
var secondTitle: String?
secondTitle = "There and Back Again"

if let title = secondTitle {
    print("Full title: \(bookTitle) or \(title)")
}
else {
    print("Full title: \(bookTitle)")
}
```
### Unwrapping multiple optionals

Consider this nested unwrapping of optionals:

```swift
var bookReviewCount: Int?
var avgStarRating: Double?
var bookTitle: String = "The Hobbit"

bookReviewCount = 28
avgStarRating = 2.9
if let count = bookReviewCount {
    if let rating = avgStarRating {
        if (rating > 3) {
            print("\(bookTitle): \(rating) stars")
        }
        else {
            print("\(bookTitle)")
        }
    }
}
else {
    print("\(bookTitle)")
}
```

```swift
var bookReviewCount: Int?
var avgStarRating: Double?
var bookTitle: String = "The Hobbit"

bookReviewCount = 28
avgStarRating = 2.9
if let count = bookReviewCount, rating = avgStarRating {
    if (rating > 3) {
        print("\(bookTitle): \(rating) stars")
    }
    else {
        print("\(bookTitle)")
    }
}
else {
    print("\(bookTitle)")
}
```

### Optional Binding with a ```where``` clause

The example above can be reduced further with a ```where``` clause, if applicable.

```swift
if let count = bookReviewCount,
    rating = avgStarRating where rating > 3 {
    print("\(bookTitle): \(rating) stars")
}
else {
    print("\(bookTitle)")
}
```

## Exercises

Bind an optional and print its value, include an else block with a message.

```swift
var bookEndorsement: String?

if let endorsement = bookEndorsement {
	print("Endorsement: \(endorsement)")
}
else {
	print("There was no endorsement.")
}
```

Bind two optionals, first nested and then in one binding ```if```.

```swift
var firstName: String?
var lastName: String?

// comment/uncomment these two lines to test the bindings below
firstName = "Isabel"
lastName = "Archer"

// nested implementation
// note how we reuse the identifier; that's ok
if let firstName = firstName {
	if let lastName = lastName {
		print("Name: \(firstName) \(lastName)")
	}
	else {
		print("First Name: \(firstName)")
	}
}
else {
	print("Neither name was set.")
}

// same-line implementation
if let firstName = firstName, lastName = lastName {
	print("Name: \(firstName) \(lastName)")
}
else {
	print("Neither name was set.")
}
```
Note how the same line implementation is shorter. 

**Questions**: 

Are the two blocks logically equivalent?

```
No.
```

Can they be made to be?

```
No.
```

What's the difference?

```
The nested version allows us to treat the case where the first name is set but the last name is not.
The same line only branches to two directions: both are set or neither is set. 
```

Can the first option detect if the specific case where lastName is set but firstName is not?

```
No, it cannot. This reveals an inherent limitation of optional binding in the context of cross
dependent variables. This is a case where testing for nil on an optional results in clearer code.
```

## Exercises

Build a pyramid of doom (three nested optionals) and a multiply bound version.

```
TODO: ANSWER
```

### Implicitly Unwrapped Optionals

Implicitly unwrapped optionals don't need to be unwrapped when used. This seems odd, and at this point
before we've dealt with writing our own classes it is odd. For now, don't declare implicitly unwrapped 
optionals, but let's be ready to use them when we see them.

```swift
var firstName: String!
firstName = "Caspar"
print(firstName)
```

### Modifying an optional in place

```swift
lastName?.appendContentsOf(", Esq.")
lastName?.removeAll()
```

#### NYT

Explore the String documentation and find other methods that modify the string like 
```appendContentsOf(_:)``` does

### The nil coalescing operator

```swift
let mn = middleName ?? "X."
```
Good to ask yourself whether a feature is for new functionality, clarity, brevity. Many of these have tradeoffs.

## Optional chaining

Optional chaining is a process for querying and calling properties, methods, and subscripts on an optional 
that might currently be nil. If the optional contains a value, the property, method, or subscript call
succeeds; if the optional is nil, the property, method, or subscript call returns nil.
Multiple queries can be chained together, and the entire chain fails gracefully if any link in the chain is nil.

The result of an optional chaining call is always an optional value, even if the property, method, or subscript you are querying returns a non-optional value.

You can also attempt to set a property’s value through optional chaining.

If the type you are trying to retrieve is not optional, it will become optional because of the optional chaining.
If the type you are trying to retrieve is already optional, it will not become more optional because of the chaining.

```swift
var errorCodeString: String?
errorCodeString = "404"
var errorDescription: String?
if let theError = errorCodeString, errorCodeInteger = Int(theError)
	where errorCodeInteger == 404 {
	errorDescription = ("\(errorCodeInteger + 200): request not found")
} 

var upCaseErrorDescription = errorDescription?.uppercaseString
errorDescription
```


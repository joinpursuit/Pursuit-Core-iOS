# Optionals

### Objective

* To understand the purpose of optionals
* To learn how to declare, unwrap, bind and chain optionals
* To understand how optionals contribute to the writing of idiomatic Swift

### Reading

1. Swift Programming: The Big Nerd Ranch Guide, Chapter 8
1. [Swift Language Reference, The Basics - Apple](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/TheBasics.html#//apple_ref/doc/uid/TP40014097-CH5-ID309) *Seek to optionals* in right hand menu.

#### Further Reading

1. [Swift optionals explained simply](https://hackernoon.com/swift-optionals-explained-simply-e109a4297298) This article is in Swift 2 syntax and becomes increasingly difficult but the box metaphor and illustration is useful.

#### Vocabulary

- **optional** - A Swift type that wraps another allowing it to either have a value or be nil.
- **initialize** - To assign a variable or constant its first value.
- **nil** - A special value meaning "no value". Only optionals can be nil in Swift.
- **bind** - The mechanism used to test an optional for a value and assign it to a non-optional.
- **idiomatic** - In the context of a programming language, code written in a way natural way for that language, using its conventions and features. 
- **nest v.** - To place code blocks inside of other code blocks. One could speak of any combination of conditionals, functions, closures being nested within one another.
- **diagnostic n.** - A diagnostic is a piece of code or other mechanism whose purpose is to find the answer to a question or problem, not to accomplish functionality of the application.
- **lifecycle** - The progressive states an object or piece of software can progress through over time.

---

### 1. Introduction

You use optionals in situations where a value may be absent. An optional represents two possibilities: Either there is a value, and you can unwrap the optional to access that value, or there isn’t a value at all.

> Optional is just a type in Swift language, nothing fancy. `Int` and `Int?` [read 'optional Int'] are two different types.  If your variable is of type `Int` you can be absolutely sure it will always have an integer value, and if your variable is of type `Int?` it will have either an `Int` value or it will have no value at all (in other words, it will be nil).
>
> Think of optional as a wrapper. It’s like a gift box which wraps the value inside, and like a real-life box, optional can either contain something or be empty.
> – Lusine Margaryan, Hackernoon


### 2. The Case for optionals 

Thought experiment. Imagine we’re writing code that interfaces with a digital thermometer. This thermometer populates one Swift variable called `temperature`. When we first plug in the thermometer what value should we give it? What value should we set `temperature` to when we detect the physical device is broken?

1. Declare and initialize a variable of type Double called `temperature`.

	<details>
	<summary>Solution</summary>

	```swift
	var temperature = 0.0
	```
	</details>

1. How would you re-initialize `temperature`?

	<details>
	<summary>Solution</summary>	

	```swift
	var temperature = 0.0
	temperature = -273.0
	temperature = 212.0

	// "re-initialize"
	temperature = 0.0
	```

	</details>

1. How might you try to give it no value at all?

	<details>
	<summary>Solution</summary>

	```swift
	// this is allowed
	var temperature: Double

	// but then this won't compile
	if temperature < 10 {
	    print(temperature)
	}
	```

	You could do this:
	```swift
	var temperature: Double
	temperature = 9

	if temperature < 10 {
	    print(temperature)
	}

	// but this isn't doing anything because
	// we're not using temperature in any way
	// until we've assigned it a value
	```
	
	</details>

Let's re-declare temperature as an optional

```swift
var temperature: Double?

// we'll soon learn a better way of checking if an optional is not nil
if temperature != nil {
    print(temperature!)
}
else {
	print("Thermometer has no current valid reading.")
}
```

Note, we no longer have to initialize `temperature`. Or more accurately, `temperature` is automatically initialized to `nil`. In addition to helping us write safer code, which we'll explore later, optionals can make our code easier to read. We know that this variable, an optional, and as such may or may not have a value.

#### Exercise

Declare one each of an optional `String`, `Int`, and a `Double`.
<details>
	<summary>A solution</summary>
```swift
var middleName: String?
var zipCode: Int?
var meters: Double?
```

</details>

### 3. optionals and their wrapped type

Let's imagine a book selling app: BuyBooks. Any book for sale in the app may or may not have a dedication, reviews or a discount. We might declare the following optional variables to store this data:

```swift
var bookDedication: String?
var bookReviewCount: Int?
var bookDiscount: Double?
```

Print these optionals. What do you see?

```swift
print(bookDedication)

// prints 'nil'
```

Let's declare a non-optional without assigning it and print it.

```swift
var bookTitle: String // declaration
print(bookTitle)
// error: variable 'bookTitle' used before being initialized
```

Now, let's declare two variables, one a non-optional and the other an optional wrapping that type. 
Try assigning them to one another.

```swift
var bookTitle: String = "The Hobbit"
var alternateTitle: String?
alternateTitle = "There and Back Again"
print(bookTitle, alternateTitle)

alternateTitle = bookTitle // 😺 this works
print(alternateTitle)

bookTitle = alternateTitle // 💥 this doesn't
```

😺 A `String?` can be assigned a `String` because an optional can hold either nil or its associated type, in this case `String`. 

💥 A `String`, however, cannot be assigned the value of an optional because they are not the same type. 


### 4. Force unwrapping

In order to use the value inside an optional we must unwrap it. The simplest syntax for unwrapping is to force unwrap the optional with the `!` operator. This is also called unconditional unwrapping.

```swift
// String? example
var middleName: String? = "Ronald"
print(middleName!)

// Double? example
var meters: Double? = 2.11
let tripleTheMeters = meters! * 3.0

// Int? example
var zipCode: Int? = 11101
if zipCode! > 11100 {
    print("I think we might be in Queens")
}
```

The simplicity of force unwrapping comes at a price, however. Our app will crash if we force unwrap an optional whose value is `nil`. By using this approach we will be throwing away the saftey feature that optionals give us: the ability to check their values for `nil`.

We can return to the problem above and use force unwrapping to assign the _value inside_ `alternateTitle` to `bookTitle`:

```swift
// we need to unwrap alternateTitle before we assign in to bookTitle
bookTitle = alternateTitle!
```

<details>
	<summary>What would happen if <strong>alternateTitle</strong> were nil?</summary>
The app would crash.
</details>


#### Exercises

Given,

```swift
var mainCharacter: String?
```

1. Force unwrap `mainCharacter` and print it.

	<details>
		<summary>Solution</summary>
	Observe how force unwrapping can trigger a runtime error (crash).

	```swift
	var mainCharacter: String?
	print(mainCharacter!)
	```

	</details>

1. Give `mainCharacter` a value to fix the problem.
	<details>
		<summary>Solution</summary>

	```swift
	var mainCharacter: String?
	mainCharacter = "Bilbo"
	print(mainCharacter!)
	```

	</details>

1. What is the difference between a compile time error and a run time error? 
	<details>
		<summary>Answer</summary>
		A compile time error is found while the compiler is compiling/interpreting your code. Your code is not runnable because it has a syntax error or other invalid code. A run time error, by contrast, happens when code compiles and runs but runs into a problem during execution. E.g. your program attemtps to divide by zero or access memory it doesn't own, or tries to force unwrap a nil optional.
	</details>

1. Which is better, a compile time error or a run time error?
	<details>
		<summary>Answer</summary>
		Compile time errors are better because they're encountered during development and the compiler can often give us more details about the error and solution. This is due, in part to the fact that compile time and run time errors are fundamentally different. By analogy, it's easier to fix spelling or even grammatical errors in an essay than it is to write excellent prose.
	</details>

1. How do optionals protect us from run-time errors?
	<details>
		<summary>Answer</summary>
		They're designed to address a set of run-time errors that arise from data having no valid value. A constant or variable might be `nil` for a variety of reasons, including initialization and failure conditions. optionals give us a mechanism for explicitly testing for `nil`.
	</details>

### 5. Binding

So far we've either force unwrapped optionals, which is dangerous and defeats the purpose of using them, or we explicitly checked for `nil` before force unwrapping, which is clunky, verbose and just not very Swifty. 

Binding to the rescue. Binding allows us to test an optional for `nil` while setting a constant or variable to the unwrapped value, if not `nil`.


```swift
var bookTitle: String = "The Hobbit"
var secondTitle: String?
var author: String = "J.R.R. Tolkien"
var coAuthor: String?
secondTitle = "There and Back Again"

// bind the constant title to the value of secondTitle 
if let title = secondTitle {
    print("Full title: \(bookTitle) or \(title)")
}
else {
    print("Full title: \(bookTitle)")
}
```

#### Exercises

Given:

```swift
var bookTitle: String = "The Hobbit"
var secondTitle: String?
var author: String = "J.R.R. Tolkien"
var coAuthor: String?
secondTitle = "There and Back Again"
```

1. Bind `coAuthor` and print both authors' names when it has a value. Fall back to just the main author otherwise.

	<details>
		<summary>Solution</summary>
	
	```swift
	if let otherAuthor = coAuthor {
		print("Written by \(author) and \(otherAuthor)")
	}
	else {
		print("Written by \(author)")
	}
	```

	</details>

1.  How will you test both conditions?
	<details>
		<summary>Solution</summary>
		By setting and unsetting `coAuthor`.
	</details>

#### Binding more than one optional

Consider the case where we have two optionals, both of which we want to unwrap for a particular path of execution. The following nested unwrapping of optionals requires both `bookReviewCount` and `avgStarRating` to have values.

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

We can decrease the depth of these nested blocks by separating the two bindings by a comma and sharing the block entered when both variables have values.

```swift
var bookReviewCount: Int?
var avgStarRating: Double?
var bookTitle: String = "The Hobbit"

bookReviewCount = 28
avgStarRating = 2.9
if let count = bookReviewCount, 
	let rating = avgStarRating {
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

#### Exercises

1. Given `bookEndorsement` bind it and print its value. Include an else block with a message.

	```swift
	var bookEndorsement: String?
	```

	<details>
		<summary>Solution</summary>

	```swift
	if let endorsement = bookEndorsement {
		print("Endorsement: \(endorsement)")
	}
	else {
		print("There was no endorsement.")
	}
	```

	</details>

1. Bind two optionals, first nested and then in one binding `if`

	```swift
	var firstName: String?
	var lastName: String?
	```

	<details>
		<summary>Solution</summary>

	```swift
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
	
	</details>


1. Are the nested and un-nested versions logically equivalent?

	<details>
		<summary>Solution</summary>
		No.
	</details>


1. Can they be made to be?

	<details>
		<summary>Solution</summary>
		No.
	</details>

1. What's the difference?

	<details>
		<summary>Solution</summary>
		The nested version allows us to treat the case where the first name is set but the last name is not. The same line only branches to two directions: both are set or neither is set. 
	</details>

1. Can the first option detect if the specific case where lastName is set but firstName is not?

	<details>
		<summary>Solution</summary>
	No, it cannot. This reveals an inherent limitation of optional binding in the context of cross dependent variables. This is a case where testing for nil on an optional results in clearer code.
	</details>

1. Build a pyramid of doom (three nested optionals) and a multiply bound version.

#### Combining optional binding with other boolean expressions

We can further condense our dependent bindings by adding in other conditionals unrelated to the binding of optionals. Continuing with the example above, we can rewrite as:

```swift
if let count = bookReviewCount,
    let rating = avgStarRating, 
    rating > 3 {
    print("\(bookTitle): \(rating) stars")
}
else {
    print("\(bookTitle)")
}
```

### 5b Optional Binding with while let

We can use a ```while let``` pattern to continually unwrap a value, and stop when that value is nil.

```swift
var myArr = [4,10,3,2,19]

while let lastVal = myArr.popLast() {
	print(lastVal)
}
//Prints
4
10
3
2
19
```

This isn't a super common pattern, but it can be very powerful.  Take note for when you are able to make sure of it.

### 6. Guard statements

If we are inside of a loop, we can use a special type of binding statement called a ```guard``` statement.  A guard statement is a way of checking to see if a condition is true, and only proceeiding forwards if it is.

```swift
var myArr = [1,4,2,9]
var currentIndex = 0
while true {
	guard currentIndex < myArr.count else {
		break
	}
	print(myArr[currentIndex]
}
```

We can read this to be "make sure that the current index is less than the count of the array.  Otherwise, break out of the loop.

guard can only appear inside of a loop (or function) and must have an else that breaks out of the current scope that you are in.


### 6b. Guard let statements

We can combine the idea of a guard statements and optional binding to create ```guard let``` statements.  A guard let statement can only appear anywhere that a guard statement would be able to appear.  

```swift
var tempRecordings: [Double] = [78, nil, 85, 77, nil, 80]
for temperature in tempRecordings {
	guard let temperature = temperature else {
		continue
	}
	print("We recorded a temperature of \(temperature)")
}
```

In the code above, we are able to use the variable ```temperature``` anywhere below the guard statement that we've written.  Our compiler is happy with us because either (1) we fail to initialize our variable temperature because we found a nil value and then continue our loop or (2) we succeed at unwrapping temperature, then we can use our new variable safely in the rest of our code.

### 7. Implicitly Unwrapped optionals

Implicitly unwrapped optionals don't need to be unwrapped when used. This seems odd, and at this point, before we've dealt with writing our own classes it is a little early to see their purpose. For now, don't declare implicitly unwrapped optionals, but let's be ready to use them when we see them.

```swift
var firstName: String!
firstName = "Caspar"
print(firstName)
```

### 8. The nil coalescing operator

Use the nil coalescing operator to test an optional and supply an alternative if `nil`.

```swift
let mn = middleName ?? "X."
print(mn)

// uncomment one of the following two
secondTitle = nil
secondTitle = "Life in the Woods"
print(secondTitle ?? "(none)")
```

Since `middleName` and `secondTitle` are optionals, they may be nil. We don't want to print nil values or see the "Optional()" description when printing. We also may not want to add the complexity and lines of code involved in unwrapping.

### 9. Testing optionals for equality

We can compare optionals with `==` without unwrapping them.

```swift
var num: Int?
// num = 7 // toggle to test

// compare an optional to its wrapped type
if num == 7 {
    print("I like seven")
}
else {
    print("Whither seven?")
}
```

If the optional is nil the test for equality will evaluate false. If it has a value the boolean comparison will be with the value of the wrapped type. 


Note, if two `nil` optionals are tested for equality, the expression will evaluate true.

```swift
var height: Int?
var width: Int?

if height == width {
    print("A Square!")
}
else {
    print("A Rectangle!")
}
```

This might not be the test you think you're making.

### 10. Optional chaining

Optional chaining is a process for querying and calling properties, methods, and subscripts on an optional that might currently be nil. If the optional contains a value, the property, method, or subscript call succeeds; if the optional is nil, the property, method, or subscript call returns nil. Multiple queries can be chained together, and the entire chain fails gracefully if any link in the chain is nil.

The result of an optional chaining call is always an optional value, even if the property, method, or subscript you are querying returns a non-optional value. If the type you are trying to retrieve is not optional, it will become optional because of the optional chaining. If the type you are trying to retrieve is already optional, it cannot not become _more optional_ because of the chaining.


```swift
var secondTitle: String?
secondTitle = "There and Back Again"

// note how upper is optional even though uppercased() isn't
let upper = secondTitle?.uppercased()
print(upper)
```

You can also attempt to set a property’s value through optional chaining.

#### Modifying an optional in place

If you combine optional chaining with a method that would change the type the optional is wrapping, then you get modification in place. If the optional is `nil` then nothing happens, and the program continues executing.

```swift
lastName?.appendContentsOf(", Esq.")
lastName?.removeAll()

// -AND-

var secondTitle: String?
secondTitle = "There and Back Again"
secondTitle?.append(" AGAIN")
print(secondTitle ?? "")
```



# Objectives
* Define and call functions
* Understand the components of a function signature

## Standards

IOS: IOS.1

Language Fundamentals: LF.5, LF.5.a

Functions.-

LF.5 Understand how functions enable us to call a block of reusable code. Utilize functions effectively to recycle functionalities across modules and keep code DRY.

LF.5.a Define and call functions. Understand the components of a function signature including definition vs. invocation, terminology - e.g. 'argument'.

 

Engineering Foundations.

Critical Thinking and Problem Solving.- 

EF.1 Identify a problem or challenge, conceptualize a way (or multiple ways) to approach it, consider potential effects of additional factors, and test different solutions until they find one that works. Break down complex problems into their component parts, form hypotheses to test them, consider the effects of additional factors, and eliminate potential problems one by one.

### Vocabulary:
1. function
1. argument
1. parameter
1. input
1. output
1. define
1. call

# Resources
Apple's [Swift Language Reference, Functions](https://docs.swift.org/swift-book/LanguageGuide/Functions.html)

**Functions**

Functions are self-contained chunks of code that perform a specific task. You give a function a name that identifies what it does, and this name is used to “call” the function to perform its task when needed.

So far, all of the code we've seen is evaluated by starting at the top of the file and reading down.  Conditional statements allowed us to choose *not* to run certain sections, and loops allowed us to run code repeatedly.

## 1: Function Syntax in Swift

```swift
func myFirstFunction() {
	print("Hello World")
}
```

Just like we are used to defining variables that we can use later, we have defined a **function** above that we can access later in our code.  Here's how we can use it or *call* it:

```swift
myFirstFunction()
```

This will print "Hello World" to the console.  Let's get more into the anatomy of a function with a second example:

```swift
func doubleANumber(number x: Int) -> Int {
	let doubledNumber = 2 * x
	return doubledNumber
}
```

Let's take each piece apart

## 2: Anatomy of a Function

- *func* is the special keyword in swift for defining a function
- *doubleANumber* is the name of our function
- *number* is called the **argument label** or external parameter name.  That's what you type in later when you want to call your function.  This is *optional*.  If you don't include it, the parameter name (see below) will be the argument label.
- *x* is the **parameter name**.  It's how we refer to the input in the body of the function.
- *:Int* is the type annotation of the parameter name.  This means that the function will take an Int as input.
- *-> Int* is the syntax for what the function will **return**.  In this case, it means that the function will return an Int.

Thinking about the return type is a new concept, but we've seen hints of it before.  What does it mean to return something?

Think of a function like a command.  We give it a series of inputs and it will execute code.  The return statement is the function's way of telling us a message after it has finished executing its code.

With the example of `doubleANumber(number:)` the message we get back is an `Int` that represents the doubled number.  


## 3: Creating our Own Functions

Let's try to write a few functions of our own:

**Practice**

Write a function that adds two to a number, then triples it.

Write a function that averages 3 numbers

Write a function that adds an exclamation mark ("!") to a String

<details>
<summary>Answers</summary>

```swift
func addTwoAndTriple(x: Int) -> Int {
	let incrementedByTwo = x + 2
	let tripled = incrementedByTwo * 3
	return tripled
}

func averageThreeNums(x: Int, y: Int, z: Int) -> Int {
	let sum = x + y + z
	let average = sum / 3
	return average
}

func addBang(to str: String) -> String {
	let bangedStr = str.append("!")
	return bangedStr
}
```
</details>

## 4: Using Functions
We've defined some useful functions above.  Let's see how we can make use of them in code.

`let initialNumber = 10`

I want to add two to `initialNumber`, and then triple it.  How can I use the function I've defined above to do that?

`addTwoAndTriple(x: initialNumber)`

Great start!  When we put this into out Playground, we see the correct value of 36 appear on the right hand side.  But that number doesn't show up anywhere else.  We could print it, but then we've lost it in our code.  How can we retain the value that we want?  This question brings us a key understanding about functions:


### A call to a function IS its return type


This line:

`addTwoAndTriple(x: initialNumber)`

And this line:

`36`

Are *exactly* the same to Swift.  When you call a function, it becomes its return type.  If you want to do something with the return value, you'll need to capture it in a variable:

`let modifiedInitialNumber = addTwoAndTriple(x: initialNumber)`

Let's try another problem below.

```swift
let firstTest = 70
let secondTest = 85
let thirdTest = 50
let average = ?
```

I have three test scores and I want to find the average.  How can we use our average function to do this?

**Practice**

<details>
<summary>Solution</summary>

```swift
let average = averageThreeNums(x: firstTest, y: secondTest, z: thirdTest)
```
</details>

</br>

**Practice**

I have a string and I want to add an exclamation mark to the end.  Use the function addBang(to:).

```swift
var myString = "Hello there"
```

<details>
<summary>Solution</summary>

```swift
myString = addBang(to: myString)
```
</details>

</br>

**Practice**

Write a function that returns the sum of the numbers in an array.

<details>
<summary>Solution</summary>

```swift
func addNumbers(numbers: [Int]) -> Int {
  var sum = 0
  for num in numbers {
    sum += num
  }
  return sum
}
addNumbers(numbers: [2, 4, 10, 5]) // returns 21
```

</details>

## 5: Function Parameters as Value Types

In the solution above, we had to reset the variable `myString`.  How would we write the code below to solve our problem?

```swift
var myString = "Hello there"
addBand(to: myString)
print(myString) // is still Hello, there without the !
```

**Turn and talk**

<details>
<summary>Solution</summary>

A String is a Value Type.  That means it gets copied when we run our function.  Changing the copy won't change the original value.

</details>

## 6: Void as a Return Type

We've already seen a function that doesn't return anything.  `myFirstFunction()` just printed out a message.  We wrote the function:

```swift
func myFirstFunction() {
	print("Hello World")
}
```

This is the preferred style.

We also call a function that returns nothing as returning *Void*.  We can represent this using an empty tuple (), or the *Void* keyword.  The following two definitions are equivalent to the one above.

```swift
func myFirstFunction() -> Void {
	print("Hello World")
}

func myFirstFunction() -> () {
	print("Hello World")
}
```

## 7: All Paths Must Return

```swift
func divide(_ dividend: Int, by divisor: Int) -> Int {
	if divisor != 0 {
		return dividend / divisor
	}
}
```

Copy the above into a Playground.  What does it tell you?  Why?

Come up with a way to make the error message go away.


<details>
<summary>One Solution</summary>

```
func divide(_ dividend: Int, by divisor: Int) -> Int {
	if divisor != 0 {
		return dividend / divisor
	} else {
		return 0
	}
}
```
</details>

What are some problems with the result above?  What's a good Swifty way that we could handle this more elegantly?

## 8: Optional Types in Functions

Using Optionals, we can handle the problem of not wanting to return anything, because we had some problem with our input.  We can rewrite the function below:

```
func safeDivide(_ dividend: Int, by divisor: Int) -> Int? {
	if divisor != 0 {
		return dividend / divisor
	} else {
		return nil
	}
}
```

This can be very helpful when we are not sure if we will get a value from the inputs to our function.  We can also have optional types for the parameters.


## 9: Default Values

We can also define a function with a default value.  This is helpful if most of the time we want it to be the same, but want the option to change it later.

```swift
func coffeeOrTea(coffee: Bool, amountOfSugar: Int = 1) {
  let choice = coffee ? "coffee" : "tea"
  print("here is your \(choice) with \(amountOfSugar) sugar(s) added")
}

coffeeOrTea(coffee: false)
coffeeOrTea(coffee: true, amountOfSugar: 3)
```

## 10: Introduction to Problem Solving

We now have seen most of the core types in Swift.  As we start to approach problems now, we will almost always ask you to write functions.  Here are some key steps to follow as you approach writing functions to solve problems:

1. Clarify the Problem
2. Identify Inputs and Outputs
3. Diagram the Problem
4. State a Solution in Words
5. Code A Solution
6. Test
7. Refactor


Let's run it through an example:

Write a function that finds (meaning outputs) the mode of an Array of Ints.


**Practice**

Write a function that converts seconds to hours.


Write a function that finds the longest word in a list of words.


Write a function that finds the average of an Array of Ints.

# Review and Wrapup

* Define function.
* What's the difference between a function definition and a function call?
* Define parameter.
* What's the difference between a parameter and an argument?
* What's the purpose of a function's internal parameter names? Its external parameter names?



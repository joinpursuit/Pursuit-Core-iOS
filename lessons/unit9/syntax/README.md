# Swift vs. Objective-C Syntax

### Quick links
* [Quick Intro](#quick-intro)
* [General Declaration](#general-declaration)
* [Variable Types](#variable-types)
	* [Local Variables](#local-variables)
	* [Pointers](#pointers)
	* [Pass-By-Reference using Pointers](#pass-by-reference-using-pointers)
* [Strings](#strings)
	* [Format Specifier Tokens](#format-specifier-tokens)
	* [String Manipulation](#string-manipulation)
	* [Mutable Strings](#mutable-strings) 
* [Arrays](#arrays)
	* [Mutable Arrays](#mutable-arrays)
* [Control Flow](#control-flow)	 
	* [For loops](#for-loops)
	* [While loops](#while-loops)
	* [Do-While loops](#do-while-loops)
	* [Switch Statements](#switch-statements)


---
## Quick Intro

Here's what we have to look forward to for Objective-C. It's not too bad. With camel-casing and Apple naming conventions, you can identify objects, methods, and variables without too much difficulty. 

Try to guess how the below would look in Swift. 

Before, in Objective-C:

```objc
Calculator *deskCalc; // 1 // 6

deskCalc = [Calculator alloc]; // 2
deskCalc = [deskCalc init]; // 3
        
// 4
[deskCalc setInitialValue: 100.0];
[deskCalc add: 200.0];
[deskCalc subtract: 10.0];

NSLog(@"The result is %g", [deskCalc value]); // 5
```

<details>
<summary>After, in the glory of Swift:</summary>

```swift
let deskCalc = Calculator()

deskCalc.setInitialValue(100.0)
deskCalc.add(200.0)
deskCalc.subtract(10.0)

print("The result is \(deskCalc.value)")
```
*Ok, so it wasn't completely 1:1.*

</details>

Enjoy those semicolons.

There's already a few differences between Swift and objc that you can identify right off the bat. If objc latter seems more verbose, that's because we're been spoiled by the conveniences of a modern language.

<details><summary>Here's a breakdown of the above code, which we'll go into more detail later:</summary>

1. First, we define a variable called `deskCalc`, which stores the **memory address** of the object. This is an important objc distinction.
2. After we have `deskCalc` to store the reference in, we create the object itself by `alloc`ating memory storage space for the object at that address. Calling this **class method** gets back the instance of the `Calculator` class. `alloc` also "zeroes out" all that instance's properties so it can be initialized after.
3. We `init`ialize the `deskCalc`instance here with an **instance method**. As such, notice that the `init` method is called on `deskCalc` **and not** `Calculator` because you want to initialize that specific object. `init` returns a value, which you are storing in `deskCalc`.
4. Well, these are the methods you're calling on `deskCalc`. The brackets should give it away by now. Instead of Swift's `Class.method()` syntax, we go with `[Class method]` for objc.
5. Several things are happening here. There isn't any string interpolation in objc, so we use the fan-favorite `NSLog()` with two arguments: the string with a [`format specifier` token](#format-specifier-tokens) (%s, %d, %@) token within the `NSString`, and a variable or class or instance method return to pass into the token. In this case, we use an **instance method** 
6. The asterisk (**\***) that precedes the variable name denotes that `deskCalc` is actually a reference/pointer to a `Calculator` object. It doesn't actually store any data locally, just a memory address to where the `Calculator` object resides at on the heap.
</details>

## General Declaration
Ever wonder why sometimes you see Swift variables and constants declared with type annotation when it's already inferred?

```swift
var number: Int = 123
var numbers: [Double] = [0.0, 12.3, 65.3]
var phrase: String = "yo fax!"
var validity: Bool = true

```
Yup, that's how you spot an objc user in the wild: Type annotation during declaration.

```objc
int number = 12;
double numbers[3] = {0.0, 12.3, 65.3};
NSString *phrase = @"yo fax!";
BOOL validity = YES;
```
You can initialize variables first and then set their values later with objc. But without optionals, you're more prone to runtime crashes if you forget to set values later.

Swift:

```swift
var setIntLater: Int?
setIntLater = 10

var setStringLater: String?
setStringLater = "Sup?"

var a: Double?
var b: Double?
var c: Double?

a = 1.0
b = 2.0
c = 3.0
```
objc:

```objc
int setLater;
setLater = 10;

NSString *setStringLater;
setStringLater = @"Sup?"

double a, b, c; //Note the multiple initilizations at once!
a = 1.0;
b = 2.0;
c = 3.0;
```
## Variable Types
### Local Variables
In Swift, we've been spoiled with good ol' variable declarations that handle all the memory management for us. This isn't the case with objc.

```objc
int one, two, three;

one = 1;
two = 2;
three = 3;
```

The above variables live in the `stack`, where it is easily accessible within the function they're declared in. 

### Pointers
`Pointers` are basically variables that live in the `stack` that point to a value that lives in the `heap`.

```objc
// These are local variables
int one, two, three;

one = 1;
two = 2;
three = 3;

// These are pointers
int *addressOfOne, *addressOfTwo, *addressOfThree;

addressOfOne = &one;
addressOfTwo = &two;
addressOfThree = &three;

NSLog(@"%d is located at %p", one, addressOfOne); // Prints "1 is located at 0x7ffee6d88fe0"

```
You might notice the ampersand (**&**), which is an operator that represents the address of the variable. 

### Pass-By-Reference using Pointers

Sometimes, though, you want to set multiple values, but you don't have tuples to play with (since this is objc). That's when you can **pass-by-reference**. 

Check out the below function.

```objc
void quickMaths(int first, int second, int *addAnswer, int *subtractAnswer)
{
	// Do all the maths!
	int sum = first + second;
	int difference = first - second;
	
	// Store the answers at the supplied addresses
	*addAnswer = sum;
	*subtractAnswer = difference;
}
```
And now, we can call it.

```objc
int sum, difference;

// Note that we're passing in the addresses that we want to store the values at
quickMaths(1, 2, &sum, &difference); 

NSLog(@"Sum: %d, Difference: %d", sum, difference); // Prints "Sum: 3, Difference: -1"

```

The way we passed in the addresses of `sum` and `difference` is almost the same as how we use `inout` parameters in Swift functions.


## Strings
Strings in objc are class objects, unlike the value types in Swift. As such, you declare the name of your `NSString` as a reference pointer with the asterick (**\***). There are other methods to `init` a string, such as passing a variable into a new string via `stringWithFormat:` or `initWithFormat:`-- which you might need to use if you want some manipulation. 

A string object of class `NSString` is **immutable** by default, but you can set the pointer to reference a new string instead.

```objc
NSString *str1 = @"Hello Testing";
NSString *str2 = str1;

str2 = @"This is a different string";

NSLog(@"str1 = %@, str2 = %@", str1, str2);
//str1 = Hello Testing, str2 = This is a different string
```

### Format Specifier Tokens
Basically a placeholder for a variable to use within `NSLog()`. You will need these to print non-string values or references to your console, or if you want to miss Swift's string interpolation even more. Different types needs different, specific tokens. There are readily identifiable in a string by the `%` symbol.

Here are key ones:

* `%@` for objects, including other strings
* `%d` for signed `int`s
* `%u` for `unsigned int`s
* `%f` for `double`s
* `%%` for the `%` symbol

Read more at [Apple Developers](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html).

### String Manipulation
Strings are harder to play with in objc. You want to concatenate two strings? You have to make an entirely new one. Enjoy playing with `NSString` methods.

```objc
NSString *hString = @"Hello";
NSString *hwString = [hString stringByAppendingString:@", world!"];

// This is a dynamic string!
NSString *myString = @"My string";
myString = [NSString stringWithFormat:@"%@ and another string", myString];
```

### Mutable Strings
So, there's an `NSMutableString`, which inherits from `NSString`. It changes the value of the object that the pointer is referencing, so all others pointer to the same object would reflect the new value at that memory address (passing by reference).

```objc
NSMutableString *str1 = [NSMutableString stringWithString:@"Hello Testing"];
NSMutableString *str2 = str1;

[str2 setString:@"This changes everything"];

NSLog(@"str1 = %@, str2 = %@", str1, str2);
//str1 = This changes everything, str2 = This changes everything

```
Note that to set the pointer towards a mutable string, you must pass in a string as a parameter with the `stringWithString:` or `setString:` methods.

## Arrays

Arrays in objc hold pointers to other objects. An instance of `NSArray` is **immutable**. Once an array has been created, you can never add or remove a pointer from that array. Nor can you change the order of the pointers in that array.

### Mutable Arrays
Stubbin'

## Control Flow

### For loops

Enjoy your C-style loops! You should recall that your for condition should utilize the `initializer, evaluation, incrementer` model, using semicolons to separate the expressions.

```objc
// Iterating through a range
for (int i = 0; i < 10; i++) {
	NSLog(@"%d", i);
}

NSArray *helloArray = @[@"Hello", @"How", @"Are", @"You"];

// Iterating through an array via index
for (int i = 0; i < [helloArray count]; i++) {
	NSLog(@"%@", helloArray[i]);
}

// Iterating through an array's elements
for (NSString *str in helloArray) {
	NSLog(@"%@", str);
}
```


### While loops
Pretty much the same.

### Do-While loops
Pretty much the same as Swift's `repeat-while` loops, since `do` is a reserved keyword for `try`. Since objc doesn't have that, it's called `do-while` here.

### Switch Statements
Generally the same as with Swift with one key difference. The only difference is that `fallthrough` is default in objc for all cases, so you need to `break` unless you intentionally want that.



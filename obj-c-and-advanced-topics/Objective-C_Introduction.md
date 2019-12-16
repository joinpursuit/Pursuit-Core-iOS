# Objective-C

## Objectives

1. Why learn Objective-C?
2. What is Objective-C?
3. Declaring Variables
4. Printing
5. Conditionals
6. Loops


# 1. What is Objective-C?

Objective-C is a thin layout built on top of C, one of the oldest and most widely used languages.  Apple needed a programming language for the NeXTSTEP operating system.  OS X and iOS are derived from NeXTSTEP, and they brought Objective-C along with them.  Objective-C was created in the early 1980s.

# 2. Why learn Objective-C?

Objective-C is still widely used in iOS development.  The last major change to Objective-C was in 2006 with Objective-C 2.0.  Objective-C's stability and long history make it a popular choice for large or old companies.  Updating a codebase from Objective-C to Swift is a large endevour and companies like Spotify and Facebook want to wait for more Swift stability before investing in a codebase update.

Additionally, when looking at online resources, such as Stack Overflow, many of the questions and answers are given in Objective-C.  Some basic knowledge can enable you to better use those resources.

# 3. Declaring Variables

Like Swift, Objective-C is a strongly typed language.  That means that every variable must be defined with a type.  Unlike Swift, there is no type inference to help you out, you must declare the type explicitly.

Objective-C is built on top of C, and has access to all the C types, as well as several more that it created.

```objective-c
int myInt = 5;
unsigned long int bigNum = 18446744073709551615;
float myFloat = 0.5f;
double myDouble = 0.5;
BOOL isEnabled = NO;
char letter = 'a';
```

Note that a semicolon **must** be at the end of every line.

# 4. Printing

In Objective-C, the print() method is called NSLog.  Printing in Swift is fairly straightforward, but there are a few more rules in Objective-C.

### String Literals

In Swift we can create a string literal below:

```swift
let myStr = "Hello world!"
```

In Objective-C, we write:

```objective-c
NSString *myStr = @"Hello world!";
```

The "@" symbol is used to denote a String literal.  The * means that we are creating a *pointer* to an NSString.  We'll see more about that tomorrow.

### String formatting

In Swift, we are able to use String interpolation to print out non-string values.

```swift
let age = 20
let name = "Ann"
let gpa = 3.7
print("Your age is \(age), your name is \(name) and your gpa is \(gpa)")
```

In Objective-C, we use a [String Format Specifier](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html) in our string that needs to match the type of what we want to print.

```objective-c
int age = 20;
NSString *name = @"Ann";
double gpa = 3.7;
NSLog(@"Your age is %d, your name is %@ and your gpa is %f", age, name, gpa);
```

# 5. Conditionals

Conditionals in Objective-C look very similar to conditionals in Swift.  The comparison operators (==, !=, <, >, >=, <=) and logical operators (&&, ||, !) are the same in both languages.  The only difference is that the condition must be surrounded by parentheses.

```swift
var myNumber = 10
if myNumber > 7 {
	print("myNumber is greater than 7")
}
```


```objective-C
int myNumber = 10;
if (myNumber > 7) {
	NSLog(@"myNumber is greater than 7");
}
//For single line conditional statements
if (myNumber < 12)
	NSLog(@"myNumber is less than 12");
```


Switch statements are also supported in Objective-C.  The syntax is the same, except the default behavior is to fallthrough to the next case, so you must break at the end of each case.


```swift 
let errorCode = 1
switch errorCode {
	case 0:
		print("Invalid Username")
	case 1:
		print("Wrong Password")
	case 2:
		print("No Internet")
	default:
		print("Unknown Error")
}
```

```objective-c
void switchTest() {
    int errorCode = 1;
    switch (errorCode) {
    case 0:
        NSLog(@"Invalid Username");
        break;
    case 1:
        NSLog(@"Wrong Password");
        break; //Try removing this line and see what happens
    case 2:
        NSLog(@"No Internet");
        break;
    default:
        NSLog(@"Unknown Error");
    }
}
```


# 6. Loops

### For Loops

There are two types of for loops we can write in Objective-C: (1) C-style loops and for in loops.

### C-style loops

The primary way of creating for loops in Objective-C uses the same syntax that can be found in C.

```objective-c
/*
for (Create a variable; Condition to keep looping; What to do after each loop) {

}
*/
for (int i = 0; i < 5; i++) {
	NSLog(@"The current value of i is %d", i);
}
```

If you don't set a condition, Objective-C will assume that it is true.  You can use this to create an infinite loop.

```objective-c
for (;;) {
	NSLog(@"Loop 4eva");
}
```

We can use this syntax to create many different kind of loops

```objective-c
for (double i = 3.8; i > -0.2; i -= 0.1) {
	NSLog(@"The current value of i is %f", i);
}
```

The same is possible in Swift using the stride(from:to:by:) method

```swift
for val in stride(from: 3.8, to: -0.1; by: -1) {
	print("The current value of i is \(i)")
}
```


### For in Loops

Objective-C 2.0 added the option to use for in loops, much like you are used to using in Swift.

```swift
let nums = [4,6,2,4]
for num in nums {
	print(num)
}
```

```objective-c
NSArray *nums = @[@4,@6,@2,@4];
for (NSNumber *num in nums) {
    NSLog(@"%@", num);
}
```


### While Loops

Objective-C also supports while loops, and do while loops that work identically to Swift.  Just remember to enclose the condition in parentheses.

```swift
var hitPoints = 5
var isEnabled = true
while isEnabled {
	hitPoints -= 1
	if hitPoints == 0 {
		isEnabled = false
	}
}
```

```objective-c
int hitPoints = 5;
BOOL isEnabled = YES;
while (isEnabled) {
	hitPoints--;
	if (hitPoints == 0) {
		isEnabled = NO;
	}
}
```
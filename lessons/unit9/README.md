#Unit 9 - Moving backward to get ahead (with Objective-C)

### Quick links
* [Rude Awakening](#rude-awakening)
* [Syntax](#syntax)
	* [General Declaration](#general-declaration)

---
## Rude Awakening

Here's what we have to look forward to for Objective-C. Try to figure out how it'd look in Swift.

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

</details>

Enjoy those semicolons.

There's already a few differences between Swift and objc that you can identify right off the bat. If objc latter seems more verbose, that's because we're been spoiled by the conveniences of a modern language.

<details><summary>Here's a breakdown of the above code:</summary>

1. First, we define a variable called `deskCalc`. 
2. After we have `deskCalc` to store the reference in, we create the object itself by `alloc`ating memory storage space for the object. Calling this method gets back the instance of the `Calculator` class. `alloc` also "zeroes out" all that instance's properties so it can be initialized after.
3. We `init`ialize the `deskCalc`instance here. Notice that the `init` method is called on `deskCalc` **and not** `Calculator` because you want to initialize that specific object. `init` returns a value, which you are storing in `deskCalc`.
4. Well, these are the methods you're calling on `deskCalc`. The brackets should give it away by now. Instead of Swift's `Class.method()` syntax, we go with `[Class method]` for objc.
5. Several things are happening here. There's not string interpolation in objc, so we use the fan-favorite `NSLog()` with two arguments: the string with a [`format specifier`](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Strings/Articles/formatSpecifiers.html) placeholder within the `NSString`, and the `value` method that returns the value. Note that while Swift has dot syntax to access instance properties, objc doesn't and requires a method to return instance property values.
6. The asterisk (**\***) that precedes the variable name denotes that `deskCalc` is actually a reference/pointer to a `Calculator` object. It doesn't actually store any data, just a memory address to where the `Calculator` object resides at.
</details>

## Syntax

### General Declaration
Ever wonder why sometimes you see Swift variables and constants declared with type annotation when it's already inferred?

```swift
var number: Int = 123
var numbers: [Double] = [0.0, 12.3, 65.3]
var phrase: String = "yo fax!"
var validity: Bool = true
```
Yup, that's how you spot an objc user in the wild. 

```objc
int number = 12;
double numbers[3] = {0.0, 12.3, 65.3};
NSString *phrase = @"yo fax!";
BOOL validity = YES;
```

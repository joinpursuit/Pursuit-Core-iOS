### Strings
---

### Objective
To be able to use the fundamental data type, `String` by performing simple operations like concatenation & character printing, and to be able to understand what Unicode is and how to print and manipulate Unicode Characters.

### Readings
1. Swift Programming: The Big Nerd Ranch Guide, Chapter 7, Strings
1. [Swift Language Reference, Strings and Characters](https://developer.apple.com/documentation/swift/string)
1. [What is Unicode?](http://stackoverflow.com/questions/2241348/what-is-unicode-utf-8-utf-16)
1. [The Absolute Minimum Every Software Developer Absolutely, Positively Must Know About Unicode and Character Sets (No Excuses!)](http://www.joelonsoftware.com/articles/Unicode.html)

#### Further Readings
1. [Basic Multilingual Plane](https://en.wikipedia.org/wiki/Plane_%28Unicode%29#Basic_Multilingual_Plane)
1. [Hexadecimal Refresher](https://en.wikipedia.org/wiki/Hexadecimal)

#### Vocabulary
1. **Concatenation** - the operation of merging two (or more) strings into one string, using the `+` operator
1. **String Interpolation** - a way to construct a new `String` value from a mix of constants, variables, literals, and expressions by including their values inside of a string literal
1. **String Literal** - a sequence of characters surrounded by quotation marks (double quotes)
1. **Value Type** - a type that creates a new instance (copy) when assigned to a variable or constant, or when passed to a function
1. **Reference Type** - a type that once initialized, when assigned to a variable or constant, or when passed to a function, returns a reference to the same existing instance
---

### 1. Warmup 

What have we used Strings and Characters for so far?  What are all the things we can do with them?

<details>
<summary>A solution</summary>

```swift
//Create a String literal "Hello"
//Compare two Strings for equality: "Hello" == "Goodbye" evaluates to false
//See which String is greater: "Hello" > "Goodbye" evaluates to true
//Use String interpolation to put a variable or expression into a String
let time = "3:30"
print("The current time is \(time)")
//Add Strings together: "a" + "b" = "ab"

```
</details>


### 2. Intro to `String`

>A string is a series of characters, such as "hello, world" or "albatross". Swift strings are represented by the String type. The contents of a String can be accessed in various ways, including as a collection of Character values. 
>~Apple

Swift’s `String` and `Character` types provide a fast, Unicode-compliant way to work with text in your code. 

### 3. Initialization
To create an empty String value as the starting point for building a longer string, either (a) assign an empty string literal to a variable, or (b) initialize a new String instance with initializer syntax.

**3a. String Literals**
```swift
let someString = "Some string literal value"
```

**3b. Empty String**
```swift
var emptyString = ""               // empty string literal
var anotherEmptyString = String()  // initializer syntax
// these two strings are both empty, and are equivalent to each other
```

#### Exercise - Initialize a String
Type the following exactly:

```swift
var walden = String(
```

And look for autocomplete options. Take a look at the other initializers, play with them and be ready to present and/or discuss them.


### 4. String Mutability

We already covered the concept of mutability when discussing variables and constants. Variables are mutable and constants are not.

```swift
let favoriteComposer = "J. S. Bach"
var listeningTo = "John Dowland"
```

I don't want to change my favorite but I might want to change the one I'm currently listening to.

```swift
listeningTo = "Miles Davis"
```

### 5. Concatenation

Concatenation is a simple and common way we change strings. It might help to remember the term to know it's related to catena, chain in Latin or Italian (cadena in Spanish). When we concatenate we link two strings together.

```swift
listeningTo += ", Trumpeter"
```

### 6. Strings are Value Types

This means that Strings, when assigned to one another are always copied. This guarantees that you won't be altering the string you copied.

```swift
var watchingMovie = "Toy Story"
var nextMovie = watchingMovie
nextMovie += " Two"
print("Watching: \(watchingMovie), gonna watch \(nextMovie)")
```

**Question**: If Strings weren't copied like this, how else might they behave when assigned?

```
Other objects will be references and alterations made to any reference will be seen by all references.
```
This distinction will become more interesting when we work with references. Don't worry about optimizing this. 


### 7. Working with Characters

The String class is a collection of Characters. You can iterate through a string to access each of its elements:

```swift
for c: Character in nextMovie.characters {
    print("\(c)")
}
```

### 8. String Interpolation

We've been using string interpolation all along as a matter of necessity, when we print to the console. Let's take an explicit look at it for a moment.

```swift
print("Watching: \(watchingMovie), gonna watch \(nextMovie)")

var numMovies = 2
print("There are \(numMovies) in the queue")
```

**Question**: What do you think the following will print?

```swift
let guessNumberOfMoviesInQueue = 4
print("To say there are \(guessNumberOfMoviesInQueue) movies in the queue would be \(numMovies == guessNumberOfMoviesInQueue).")
```

```
To say there are 4 movies in the queue would be false.
```

---

### 9. Intro to Unicode

**Question**: Who speaks a language other than English? That uses characters other than those that are found in English? Or in the Roman alphabet?

Unicode is an international standard created so that characters from all writing systems can be represented on the same computer and even the same document. 

The first plane, plane 0, of the [Basic Multilingual Plane (BMP)](https://en.wikipedia.org/wiki/Plane_%28Unicode%29#Basic_Multilingual_Plane) contains characters for almost all modern languages, and a large number of symbols. 

### 10. Unicode Scalars

Every character is built up from **one or more Unicode scalars**. 

Scalar is a term borrowed from mathematics. In Computer Science, we use it to say an instance is a single or one dimensional thing. It's used in contrast to the term vector which indicates a list or a string of things. 

#### Exercise - Unicode Scalars

Given that the first Unicode values are ASCII Build, some strings using Unicode escapes of the format `\u{xxxx}`. Type "man ascii" in terminal and look at Hex values or Google it. TL;DR?: A=0x41 and a=0x61.

### 11. Combining Scalars

Usually there is one visible character per Unicode scalar. But in some cases they combine.

```swift
aAcute = "\u{0061}\u{0301}"
```
Put in more technical terms we say each character in Swift is an *extended grapheme cluster*. These are sequences of one or more Unicode characters that combine to one human readable character. 

```swift
for s in nextMovie.unicodeScalars {
    print("Scalar: \(s) (\(s.value))")
}
```

#### Exercise - Combining Scalars

Do the same as the previous exercise, except try some combining scalars, like tilde, umlaut and accents.
Use this list of [Combining Diaritical Marks](http://www.fileformat.info/info/unicode/block/combining_diacritical_marks/list.htm) as a reference guide.

### 12. Canonical Equivalence

Unicode has already-combined scalars that represent the equivalent multi-character compositions.

```swift
let aAcutePrecomposed = "\u{00E1}"
(aAcute == aAcutePrecomposed)

// another example 
let precomposed: Character = "\u{D55C}"                  // 한
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ
```

This is called *canonical equivalence*. If two characters are *linguistically* the same they are considered equal. This is certainly what we want in most applications.

#### Exercise - Canonical Equivalence

Do the same as the previous exercise, except find combining scalars and their pre-composed equivalents.

---

### More on Strings

### 10. Counting Charcters

```swift
var word = "cafe"
print("the number of characters in \(word) is \(word.characters.count)")
// Prints "the number of characters in cafe is 4"
 
word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301
 
print("the number of characters in \(word) is \(word.characters.count)")
// Prints "the number of characters in café is 4"
```

NB: The book says (correctly) that "```count``` iterates over a string's Unicode scalars to determine its length" but we should add that as it iterates over the scalars it may count more than one scalar into the same character.

**Question**: Are e and é canonically equivalent?

```
No, because they are linguistically different.
```

Because of canonical equivalence and in the same spirit of getting what we would expect linguistically, the **character** count is the same because the linguistic meaning of both compositions of café.

#### Exercise - Counting Characters

Compare character counts on combined scalars and their pre-composed equivalents. How about their unicodeScalars count?

### 11. Accessing & Modifying a String

Because of the complexities of Unicode we've been discussing, Swift can't use a direct Int subscript to access a character/element. Use indices (String.Index) and ranges to access characters in a string.

**Index**
```swift
let start = nextMovie.startIndex
let toPosition = 4
let end = start.advancedBy(toPosition)
print(nextMovie[end])
```
#### Exercise - Accessing & Modifying a String

Print out a string using a ```for``` loop, ```String.startIndex``` and ```String.endIndex```.
Print out a string using a ```while``` loop, ```String.startIndex``` and ```String.advancedBy```.

**Range**
```swift
let start = nextMovie.startIndex
let toPosition = 2
let end = start.advancedBy(toPosition)
let range = start...end
let firstWord = nextMovie[range]
print(firstWord)
```

#### Exercise - Accessing & Modifying a String

Pull out ranges of strings.

### 12. Comparing Strings

As mentioned previously, two `String` values (or two `Character` values) are considered equal if their extended grapheme clusters are canonically equivalent.

For example, `LATIN SMALL LETTER E WITH ACUTE (U+00E9)` is canonically equivalent to `LATIN SMALL LETTER E (U+0065)` followed by `COMBINING ACUTE ACCENT (U+0301)`. Both of these extended grapheme clusters are valid ways to represent the character é, and so they are considered to be canonically equivalent:

```swift
// "Voulez-vous un café?" using LATIN SMALL LETTER E WITH ACUTE
let eAcuteQuestion = "Voulez-vous un caf\u{E9}?"
 
// "Voulez-vous un café?" using LATIN SMALL LETTER E and COMBINING ACUTE ACCENT
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}?"
 
if eAcuteQuestion == combinedEAcuteQuestion {
    print("These two strings are considered equal")
}
// Prints "These two strings are considered equal"
```

Conversely, `LATIN CAPITAL LETTER A (U+0041, or "A")`, as used in English, is not equivalent to `CYRILLIC CAPITAL LETTER A (U+0410, or "А")`, as used in Russian. **The characters are visually similar, but do not have the same linguistic meaning**:

```swift
let latinCapitalLetterA: Character = "\u{41}"
 
let cyrillicCapitalLetterA: Character = "\u{0410}"
 
if latinCapitalLetterA != cyrillicCapitalLetterA {
    print("These two characters are not equivalent.")
}
// Prints "These two characters are not equivalent."
```









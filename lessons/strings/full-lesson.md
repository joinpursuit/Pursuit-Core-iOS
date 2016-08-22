# Standards
Understand and use fundamental data types

# Objectives
Students will be able to:
* Concatenate strings
* Print the characters from a string
* Understand what Unicode is and how to print and manipulate Unicode characters

# Resources

Swift Programming: The Big Nerd Ranch Guide, Chapter 7, Strings

Apple's [Swift Language Reference, Strings and Characters](https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/StringsAndCharacters.html#//apple_ref/doc/uid/TP40014097-CH7-ID285)

http://stackoverflow.com/questions/2241348/what-is-unicode-utf-8-utf-16

* Read: [Joel on Software
The Absolute Minimum Every Software Developer Absolutely, Positively Must Know About Unicode and Character Sets (No Excuses!)
by Joel Spolsky](http://www.joelonsoftware.com/articles/Unicode.html)
* Look at: https://en.wikipedia.org/wiki/Plane_%28Unicode%29#Basic_Multilingual_Plane

## Warm up
Hexadecimal is back. 

https://en.wikipedia.org/wiki/Hexadecimal

**Question**: What is a standard?

## Strings

### String Literals
```swift
let someString = "Some string literal value"
```

### Initialize an Empty String
```swift
var emptyString = ""               // empty string literal
var anotherEmptyString = String()  // initializer syntax
// these two strings are both empty, and are equivalent to each other
```

### NYT 
Type the following exactly:

```swift
var walden = String(
```

And look for autocomplete options. Take a look at the other initializers, play with them and be 
ready to present and/or discuss them.

### String Mutability

We already covered the concept of mutability when discussing variables and constants. Variables
are mutable and constants are not.

```swift
let favoriteComposer = "J. S. Bach"
var listeningTo = "John Dowland"
```

I don't want to change my favorite but I might want to change the one I'm currently listening to.

```swift
listeningTo = "Miles Davis"
```

### Concatenations

Concatenations are a simple and common way we change strings. It might help to remember the term
to know it's related to catena, chain in Latin or Italian (cadena in Spanish). When we concatenate
we link two strings together.

```swift
listeningTo += ", Trumpeter"
```

### Strings are Value types

This means that Strings, when assigned to one another are always copied. This guarantees that
you won't be altering the string you copied.

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

This distinction will become more interesting when we work with references.

Don't worry about optimizing this. 


### Working with Characters

The String class is a collection of Characters. 

```swift
for c: Character in nextMovie.characters {
    print("\(c)")
}
```

### String interpolation

We've been using string interpolation all along as a matter of necessity, when we print
to the console. Let's take an explicit look at it for a moment.

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
## Unicode

**Question**: Who speaks a language other than English? That uses characters other than are found in English? Or in the Roman alphabet?

Unicode is an international standard created so that characters from all writing systems can be
represented on the same computer and even the same document. 

The first plane, plane 0, the Basic Multilingual Plane (BMP) contains characters for almost all modern languages, and a large number of symbols. 

### Unicode Scalars

Every character is built up from **one or more Unicode scalars**. 

Scalar is a term borrowed from mathematics. In Computer Science we use it to say an instance
is a single or one dimensional thing. It's used in contrast to the term vector which indicates a 
list or a string of things. 

#### NYT

Given that the first Unicode values are ASCII Build some strings using Unicode escapes of the format
\u{xxxx}. Type "man ascii" in terminal and look at Hex values or Google it. TL;DR?: A=0x41
and a=0x61.

#### Combining scalars

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

#### NYT

Do the same as the previous exercise, except try some combining scalars, like tilde, umlaut and accents.
See, http://www.fileformat.info/info/unicode/block/combining_diacritical_marks/list.htm


#### Canonical Equivalence

Unicode has already-combined scalars that represent the equivalent multi-character compositions.

```swift
let aAcutePrecomposed = "\u{00E1}"
(aAcute == aAcutePrecomposed)

// another example 
let precomposed: Character = "\u{D55C}"                  // 한
let decomposed: Character = "\u{1112}\u{1161}\u{11AB}"   // ᄒ, ᅡ, ᆫ
```

This is called *canonical equivalence*. If two characters are *linguistically* the same 
they are considered equal. This is certainly what we want in most applications.

#### NYT

Do the same as the previous exercise, except find combining scalars and their pre-composed equivalents.

###Counting Characters

```swift
var word = "cafe"
print("the number of characters in \(word) is \(word.characters.count)")
// Prints "the number of characters in cafe is 4"
 
word += "\u{301}"    // COMBINING ACUTE ACCENT, U+0301
 
print("the number of characters in \(word) is \(word.characters.count)")
// Prints "the number of characters in café is 4"
```

NB: The book says (correctly) that "```count``` iterates over a string's Unicode scalars to determine
its length" but we should add that as it iterates over the scalars it may count more than one scalar
into the same character.

**Question**: Are e and é canonically equivalent?

```
No, because they are linguistically different.
```

Because of canonical equivalence and in the same spirit of getting what we would expect
linguistically, the **character** count is the same because the linguistic meaning of both compositions of café.

#### NYT

Compare character counts on combined scalars and their pre-composed equivalents. How about their unicodeScalars
count?

### Accessing and modifying ```String```

Because of the complexities of Unicode we've been discussing Swift can't use a direct Int subscript to
access a character/element. Use indices (String.Index) and ranges to access characters in a string.

**Index**
```swift
let start = nextMovie.startIndex
let toPosition = 4
let end = start.advancedBy(toPosition)
print(nextMovie[end])
```
#### NYT

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

#### NYT

Pull out ranges of strings.


### Comparing Strings

In addition to equality can also compare prefix and suffix.

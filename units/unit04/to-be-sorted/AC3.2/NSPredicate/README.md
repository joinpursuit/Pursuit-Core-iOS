# Standards

* Use ```NSPredicate``` to perform queries on data

# Objectives

* Filter and query collections with ```NSPredicate```.
* Understand ```NSPredicate``` as preparation for its use with Core Data.

# Resources

1. [NSPredicate - NSHipster](http://nshipster.com/nspredicate/) -- Beware it's Swift 2.0 syntax
but the NSPredicate stuff is good. 
2. [NSPredicate - Apple Doc](https://developer.apple.com/reference/foundation/nspredicate)

## Overview

> From Apple's [Predicate Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Predicates/AdditionalChapters/Introduction.html#//apple_ref/doc/uid/TP40001789)
>
> In Cocoa, a predicate is a logical statement that evaluates to a Boolean value (true or false). 
> There are two types of predicate, known as comparison and compound:
> 
> A comparison predicate compares two expressions using an operator. The expressions are referred
> to as the left hand side and the right hand side of the predicate (with the operator in the middle).
> A comparison predicate returns the result of invoking the operator with the results of evaluating 
> the expressions.
> A compound predicate compares the results of evaluating two or more other predicates, or 
> negates another predicate. Cocoa supports a wide range of types of predicate, including the following:
> 
> Simple comparisons, such as grade == 7 or firstName like 'Mark'
> Case or diacritic insensitive lookups, such as name contains[cd] 'citroen'
> Logical operations, such as (firstName beginswith 'M') AND (lastName like 'Adderley')
> You can also create predicates for relationships—such as group.name matches 
> 'work.*', ALL children.age > 12, and ANY children.age > 12—and for operations such as @sum.items.price < 1000.
> 
> Cocoa predicates provide a means of encoding queries in a manner that is independent of the 
> store used to hold the data being searched. You use predicates to represent logical conditions
> used for constraining the set of objects retrieved by Spotlight and Core Data, and for in-memory filtering of objects.
> 
> You can use predicates with any class of object, but a class must be key-value coding compliant 
> for the keys you want to use in a predicate.> 

## Why?

Depending on the backend we could offload this kind of work to api but that might be too
much data or too chatty. The API might not support the same type, granularity or combinatorial
querying ability.

## Key-Value Coding compliant

For our scope of work with predicates this simply means that the properties of an object
can be looked up by string representations. And the easiest way to do this is to subclass
NSObject. 

# SQL

SQL is referred to as a a non-procedural or a declarative language. ```NSPredicate``` is described
as being SQL-like. This is in part because it simply is non-procedural but also because it is used
to query a SQLite database when used with Core Data, even though it is data store agnostic.

## Declarative Language

> From [Wikipedia's Declarative Programming](https://en.wikipedia.org/wiki/Declarative_programming)
> 
> Declarative programming is often defined as any style of programming that is not imperative. A number 
> of other common definitions exist that attempt to give the term a definition other than simply 
> contrasting it with imperative programming. For example:
> 
> A program that describes what computation should be performed and not how to compute it
> Any programming language that lacks side effects (or more specifically, is referentially transparent)
> A language with a clear correspondence to mathematical logic.[4]

# Key Path

Part of key-value-coding, a key path allows for indexing deeply into nested dictionaries with one
lookup. It's actually not built into Swift's ```Dictionary``` and ```Array``` so we need to
cast to ```NSDictionary``` and ```NSArray```.

```swift
for dict in movies {
    if let nm = (dict as NSDictionary).value(forKeyPath: "locations") as? [String] {
        print(nm)
    }
}

if let locs = (movies as NSArray).value(forKeyPath: "locations") as? NSArray {
    for loc in locs  {
        if let location = loc as? [String] {
            print("Location array:", location)
        }
    }
}

for dict in movies {
    if let nm = (dict as NSDictionary).value(forKeyPath: "nested_movie.locations") as? [String] {
        print(nm)
    }
}

// can even search over an array of dictionaries; returns one return per array element 
let castArray = (movies as NSArray).value(forKeyPath: "nested_movie.cast")
print(castArray)
```

### Exercises

2. Find all movies named 'Titanic'.

2. Knights who say "ni!": Find all movies with 'ni' in their titles.

3. Find all 21st century dramas.

3. Find all movies between 2007 and 2009, inclusively.


## ANY

```ANY``` is probably the most common aggregate operation. It allows you to search into collections within
the data.

```swift
let tokyo = NSPredicate(format: "ANY locations == 'Tokyo'")
let tokyoMovies = movies.filter { tokyo.evaluate(with: $0) }
print (tokyoMovies)
```

### Exercises

1. Find all movies starring Sigourney Weaver.

2. Brought to you by the letter J. Find all movies who have an actor whose first name starts with the letter "J".

## Subqueries

> From [some blogger person](http://funwithobjc.tumblr.com/post/2726166818/what-the-heck-is-subquery)
> 
> Now that we get what the various bits of a subquery expression are, let’s ask the real question: when is this ever useful?
> 
> To be honest, the answer to this is “not often”. However, when you need it, it’s incredibly useful.
> 
> Rule of thumb
> The general rule of thumb on when you should consider using SUBQUERY is this:

If you have a collection (A) of objects, and each object has a collection (B) of other objects, and you’re trying to filter A based on some varying attributes (at least 2) of the objects in B, then you should probably be using SUBQUERY.

```
let tokyoSubquery = NSPredicate(format: "SUBQUERY(locations, $location, $location contains 'Tokyo').@count > 0")
let tokyoBySubquery = movies.filter { tokyoSubquery.evaluate(with: $0) }
print(tokyoBySubquery)
```

### Exercises

1. Find all movies starring Sigourney Weaver (subquery syntax).

1. Find all movies starring Sigourney Weaver with a location "Los Angeles".

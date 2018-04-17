# Protocols, POP, Generics and Delegation

### Past Lesson Links

- [Protocols and Delegation](https://github.com/C4Q/AC-iOS/tree/master/lessons/unit2/ProtocolsAndDelegation)
- [Delegation with text fields](https://github.com/C4Q/AC-iOS/tree/master/lessons/unit2/DelegationThroughTextFields)
- [Generics Intro](https://github.com/C4Q/AC-iOS/blob/a0f88e0f968099222aa99c634b552c936b95061f/lessons/dsa/LinkedLists/README.md)

### Key Interview Questions

1. What is a Protocol?  Why can Swift be described as a Protocol-Oriented Language?
2. What is delegation and why is it useful?
3. What is a generic?  Give an example in Swift for when generics are used.


# 1. Protocols


### What is a protocol?

A protocol is a collection of properties and methods.  Protocols can be *adopted* by classes, structs and enums.  In order for another class to adopt/conform to a protocol, it must provide its own implementation for **all** of the properties and methods defined inside of the protocol.  


When you define a protocol, you define **only** the properties and methods you want the implementing types to have, and not their values. If using properties, their read-write or read-only permissions have to be specified.

```swift
protocol SomeProtocol {
    var someString: String { get set }
    var someInt: Int { get }

    func someMethod()
    mutating func someMutatingMethod()
}
```

Whenever we want a type to conform to SomeProtocol, it must have its own implementation of someString, someInt, someMethod() and someMutatingMethod().


Because types can conform to more than one protocol, they can be decorated with default behaviors from multiple protocols. Unlike multiple inheritance of classes which some programming languages support, protocol extensions do not introduce any additional state.


### Why can Swift be described as a Protocol-Oriented Language?

The fundemental building blocks of Swift are built on top of protocols.  Here are some main ones that you see:

- Equatable
- Comparable
- Hashable
- Collection
- Sequence
- CustomStringConvertible

Conforming to `CustomStringConvertible`, for example, means that you can control what the print() function does.

```
class Person: CustomStringConvertible {
    var age: Int
    var occupation: String
    var description: String {
    	return "Person: age: \(age), occupation: \(occupation)"
    }
    init(age: Int, occupation: String) {
        self.age = age
        self.occupation = occupation
    }
}

let person = Person(age: 40, occupation: "Pilot")
print(person)
```

Swift is **not** built on top of Arrays or Ints, but rather SequenceType and Comparable.  Arrays (and ranges and dictionaries) are iterable because they conform to a protocol, and you can see if an Int is greater than another Int not because they are Ints, but because Int conforms to Comparable.


## [Further Protocol Readings](https://github.com/C4Q/AC-iOS/tree/master/lessons/unit2/ProtocolsAndDelegation)


# 2. Delegation

### What is delegation?


>Delegation is a design pattern that enables a class or structure to hand off (or delegate) some of its responsibilities to an instance of another type. This design pattern is implemented by defining a protocol that encapsulates the delegated responsibilities, such that a conforming type (known as a delegate) is guaranteed to provide the functionality that has been delegated. Delegation can be used to respond to a particular action, or to retrieve data from an external source without needing to know the underlying type of that source.

 - [Swift Docs](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html#//apple_ref/doc/uid/TP40014097-CH25-ID276)

 
### Why is it useful?

If a class has a delegate, we can assign its delegate to whatever we want, as long as we add the methods it needs to conform.  This means that instead of having to subclass, we can just add a couple functions.

```
protocol CustomCellDelegate: class {
	func upvote(post: Post)
}
class MyCustomCell: UITableViewCell {
	weak var delegate: CustomCellDelegate?
	var post: Post?
	lazy var myButton: UIButton = {
		let but = UIButton()
		but.addTarget(self, action:#selector(handleTap), for: .touchUpInside)
		return but
	}()
	@objc func handleTap(sender: UIButton) {
		if let delegate = delegate, let post = post {
			delegate.upvote(post: post)
		}
	}
}

```

### [Further Delegate Readings](https://github.com/C4Q/AC-iOS/tree/master/lessons/unit2/ProtocolsAndDelegation)
### [Text Fields and Delegation](https://github.com/C4Q/AC-iOS/tree/master/lessons/unit2/DelegationThroughTextFields)

# 3. Generics

### What is a generic?

When creating a struct, class or function, you can declare that an object will not be of a specific type, but could be any one type.  This is different than Any, because each type in an array of Any can be different.

```swift
func printAllElements1(in arr: [Any]) {
	for element in arr {
		print(element)
	}
}

func printAllElements2<T: CustomStringConvertible>(in arr: [T]) {
	for element in arr {
		print(element)
	}
}

let anyArr: [Any] = [4, "a", [1,2,3]]
let strArr = ["a", "b", "c"]
let intArr = [1,2,3]

printAllElements1(in: anyArr) //Prints
printAllElements1(in: strArr) //Prints
printAllElements1(in: intArr) //Prints

printAllElements2(in: anyArr) //Compile Error.  This is good!  It means that we know the array isn't of a single type.
printAllElements2(in: strArr) //Prints
printAllElements2(in: intArr) //Prints

```


### Give an example in Swift for when generics are used

Creating an instance of an array:

```swift
let myArr: Array<String>
myArr = ["a", "sdf", "d"]
```

[Swift Documentation](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html)



# 4. DSA Practice

### Linked Lists (Practice with generics)

- [https://www.codewars.com/kata/linked-lists-get-nth-node](https://www.codewars.com/kata/linked-lists-get-nth-node)
- [http://www.codewars.com/kata/linked-lists-append](http://www.codewars.com/kata/linked-lists-append)
- [http://www.codewars.com/kata/linked-lists-insert-nth-node](http://www.codewars.com/kata/linked-lists-insert-nth-node)
- [http://www.codewars.com/kata/linked-lists-remove-duplicates](http://www.codewars.com/kata/linked-lists-remove-duplicates)
- [http://www.codewars.com/kata/linked-lists-sorted-insert](http://www.codewars.com/kata/linked-lists-sorted-insert)
- [http://www.codewars.com/kata/linked-lists-insert-sort](http://www.codewars.com/kata/linked-lists-insert-sort)
- [http://www.codewars.com/kata/linked-lists-recursive-reverse/swift](http://www.codewars.com/kata/linked-lists-recursive-reverse/swift)


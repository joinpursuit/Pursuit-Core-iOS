# Stacks

A Stack is an abstract data structure we use in storing data.

A stack like in real life is a piled structure of items, such as a stack of plates as pictured below.  You can only add or take away dishes at the top of the stack (pile).

![Dishes Stack](http://www.dabillgh.com/wp-content/gallery/kitchen-and-crockery/DbillGH2343466.jpg)

A more traditional representation looks like:

![CS Stack](http://stanford.edu/class/archive/cs/cs106b/cs106b.1158/images/stack-figure.png)

## Last In First Out (LIFO)

Because we can only interact with the top of the stack, the last thing we put into the stack is the first thing that will come out.  This is called Last In First Out or LIFO.

In our dish stack above, the last dish that we put away will be the first one we pick back up when need to use another dish.

## Methods

A stack has the following methods:

**push()** : Adds a new element to the top of the stack

**pop()** : Removes and returns the top element of the stack

**peek()** : Returns the top element of the stack without removing it

**isEmpty()** : Returns whether or not the stack has any elements inside of it

## Performance 

<details>
	<summary>Access an element</summary>
	O(n)
</details>	

<details>
	<summary>Find an element</summary>
	O(n)
</details>	

<details>
	<summary>Insert an element </summary>
	O(1)
</details>	

<details>
	<summary>Delete an element</summary>
	O(1)
</details>

## Use cases

1. Back button in a browser
2. Undo feature in a text editor
3. Navigation Stack in a Navigation Controller

## Implementations

We can implement a stack two different ways.

1. Using the built-in Array structure
2. Using a custom linked list

This illustrates the difference between an *abstract data type* and a *data structure*

An **abstract data type** speaks only to the conceptual behavior and not to the specific implementation.

A **data structure** is talking about how information is actually stored in memory.

More reading: [Stack Overflow](http://stackoverflow.com/questions/13965757/what-is-the-difference-between-an-abstract-data-typeadt-and-a-data-structure)

## Implement a stack using an array

```swift 
struct Stack<T> {
  private var arr: [T] = []
  
  public var peek: T? {
    return arr.last
  }
  
  public var isEmpty: Bool {
    return arr.count == 0
  }

  mutating func push(_ newElement: T) {
    arr.append(newElement)
  }
  mutating func pop() -> T? {
    return arr.popLast()
  }
}
```

## Implement a stack using a linked list

<details> 
	<summary><b>Node and LinkedList implementations</b></summary> 
	
```swift 
class Node<T: Comparable>: CustomStringConvertible, Equatable {
  public var value: T
  public var next: Node?
  
  var description: String {
    guard let next = next else { return "\(value) -> nil" }
    return "\(value) -> \(next)"
  }
  
  static func ==(lhs: Node, rhs: Node) -> Bool {
    return
      lhs.value == rhs.value &&
      lhs.next == rhs.next
  }
  
  init(value: T) {
    self.value = value
  }
}

struct LinkedList<T: Comparable>: CustomStringConvertible {
  private var head: Node<T>?
  private var tail: Node<T>?
  
  var description: String {
    guard let head = head else { return "empty list" }
    return "\(head)"
  }
  
  public var first: Node<T>? {
    return head
  }
  
  public var last: Node<T>? {
    return tail
  }
  
  public var isEmpty: Bool {
    return head == nil
  }
  
  public mutating func append(_ value: T) {
    let newNode = Node(value: value)
    if let lastNode = tail {
      lastNode.next = newNode
    } else {
      head = newNode
    }
    tail = newNode
  }
  
  public mutating func removeLast() -> Node<T>?  {
    guard !isEmpty else { return nil }
    var removedNode: Node<T>?
    if head == tail {
      removedNode = head
      head = nil
      tail = nil
    }
    var currentNode = head
    while currentNode != nil {
      if currentNode?.next == tail {
        removedNode = currentNode?.next
        currentNode?.next = nil
        tail = currentNode
      }
      currentNode = currentNode?.next
    }
    return removedNode
  }
}

``` 

</details>

```swift
struct Stack<T: Comparable>: CustomStringConvertible {
  private var items = LinkedList<T>()

  public var isEmpty: Bool {
    return items.first == nil
  }

  public var peek: T? {
    return items.last?.value
  }
  
  public var top: Node<T>? {
    return items.last
  }
  
  public var bottom: Node<T>? {
    return items.first
  }

  var description: String {
    guard !items.isEmpty else { return "empty list" }
    var str = "["
    var currentNode = items.first
    while currentNode != nil {
      if let currentNode = currentNode {
        str += currentNode.next == nil ? "\(currentNode.value)" : "\(currentNode.value), "
      }
      currentNode = currentNode?.next
    }
    return str + "]"
  }

  public mutating func push(_ value: T) {
    items.append(value)
  }

  public mutating func pop() -> T? {
    return items.removeLast()?.value
  }
}
```

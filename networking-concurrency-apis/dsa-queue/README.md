# Queues

[Queue Repo](https://github.com/joinpursuit/Pursuit-Core-iOS-Queue)  

A **Queue** is another way to organize and store data. A queue is an [abstract data type](https://en.wikipedia.org/wiki/Abstract_data_type). 

A queue is like a line of people.  When someone enters the line, they enter at the back.  When someone leaves the line, they leave from the front.

![Line of people](http://pythonschool.net/data-structures-algorithms/images/queue.jpg)

In computer science, the following image models the abstract data type:

![Queue ADT](https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Data_Queue.svg/1200px-Data_Queue.svg.png)

**Enqueue** means enter the queue

**Dequeue** means leave the queue

# First In First Out (FIFO)

In a queue, the first element to enter the queue is also the first one to leave it.  This is because we always remove from the front of the queue and insert at the back of the queue.  This order is called **First In First Out**, or **FIFO**.

As soon as we dequeue, we are dequeuing the element that has been in line the longest.  Just like if you were queueing at a bank, if you are the first person in the queue, you will be the first one helped.

## Methods

A queue has the following methods:

- **enqueue(_:)** : Adds an element to the back of the queue.

- **dequeue()** : Removes and returns the first element in the queue.

- **peek()** : Returns the element at the front of the queue without removing it

And the property

- **isEmpty** : Returns whether or not the queue has any elements inside of it

## Performance 

<details>
	<summary>Access an element at index n</summary>
	O(n)
</details>	

<details>
	<summary>Find an element</summary>
	O(n)
</details>	

<details>
	<summarys>Insert an element (by enqueueing)</summary>
	O(1)
</details>	

<details>
	<summary>Delete an element (by dequeueing)</summary>
	O(1)
</details>

## Use Cases:

1. Managing calls at a help desk ("Your call will be answered in the order it was received")
2. Order list at a fast food restaurant
3. IT reapair tickets


## Implementation:

Just like with stacks, we can implement a queue using a variety of different data structures.  Common implementations include:

1. Using an array
2. Using a linked list
3. Using two stacks


## Implementation - Array

Conceptually, it is fairly simple to model a Queue using an Array.

The code below creates a Linked List where we enqueue by appending to the Array, and dequeue by removing the first element.

```swift
struct Queue<T> {
  private var items = [T]()
  
  public var isEmpty: Bool {
    return items.isEmpty
  }
  
  public var peek: T? {
    return items.first
  }
  
  public mutating func enqueue(_ item: T) {
    items.append(item)
  }
  
  public mutating func dequeue() -> T? {
    return items.removeFirst()
  }
}
```

<details>
<summary>Why is this not a good way to create a queue?
</summary>

In the implementation above, dequeueing is a *linear* operation.  We'll need to shift everything in the array back to the left to fill in any gaps.

</details>

To see an example of how to model an efficient Queue with an array, check out the resource [here](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Queue)


## Implementation - Linked List

A more standard implementation of a queue is using a linked list.  We will need to keep track of both the *head* and the *tail* of our linked list.  When we **enqueue**, we will add the new element to end and reset the tail to it.  When we **dequeue**, we will move the head one node forwards and return the old head value.  An empty queue will be represented by having both the head and the tail be nil.

```swift
class LLNode<T: Equatable>: Equatable, CustomStringConvertible {
  public var value: T
  public var next: LLNode?
  
  var description: String {
    guard let next = next else { return "nil <- \(value)" }
    return "\(next) <- \(value)"
  }
  
  init(value: T) {
    self.value = value
  }
  
  static func ==(lhs: LLNode, rhs: LLNode) -> Bool {
    return lhs.value == rhs.value &&
      lhs.next == rhs.next
  }
}

struct Queue<T: Equatable>: CustomStringConvertible {
  private var head: LLNode<T>? // could be nil
  private var tail: LLNode<T>? // could be nil
  
  var description: String {
    guard let head = head else { return "empty" }
    return "(Back) \(head) (Front)"
  }
  
  public var isEmpty: Bool {
    return head == nil
  }
  
  public var peek: T? { // read-only property
    return head?.value
  }
  
  public mutating func enqueue(_ value: T) {
    let newNode = LLNode(value: value)
    guard let lastNode = tail else {
      head = newNode
      tail = newNode
      return
    }
    lastNode.next = newNode
    tail = newNode
  }
  
  // reminder: check for empty state first
  // remove item from the front of the queue
  // modify the head next value
  // return the value removed (T?)
  @discardableResult
  public mutating func dequeue() -> T? {
    var valueRemoved: T?
    guard !isEmpty else { return valueRemoved }
    valueRemoved = head?.value
    if head == tail { tail = nil }
    head = head?.next
    return valueRemoved
  }
}
```

**Excersie: Write a function that prints out all elements in a Queue**   

## Implementation - Two Stacks

A Queue is an Abstract Data Type.  As such, we can chose to have any any data structure  underlying our queue.  We saw implementations with both an Array and a Linked List above.  

A common interview problem is to use two stacks to represent a Queue.  This is less for its usefulness as a way of modeling information, but more to demonstrate familiarity with Stacks and Queues.

As such, this implementation is not meant to be particularly efficient.

```swift
struct Stack<T: Equatable> {
  private var items = [T]()
  
  public var isEmpty: Bool {
    return items.isEmpty
  }
  
  public var count: Int {
    return items.count
  }
  
  public var peek: T? {
    return items.last
  }
  
  public mutating func push(_ item: T) {
    items.append(item)
  }
  
  @discardableResult
  public mutating func pop() -> T? {
    guard !isEmpty else { return nil }
    return items.removeLast()
  }
}

struct Queue<T: Equatable> {
  private var enqueueStack = Stack<T>()
  private var dequeueStack = Stack<T>()
  
  public var isEmpty: Bool {
    return enqueueStack.isEmpty && dequeueStack.isEmpty
  }
  
  public mutating func enqueue(_ value: T) {
    while let popElement = dequeueStack.pop() {
      enqueueStack.push(popElement)
    }
    enqueueStack.push(value)
  }
  
  public mutating func dequeue() -> T? {
    while let popElement = enqueueStack.pop() {
      dequeueStack.push(popElement)
    }
    return dequeueStack.pop()
  }
  
  public mutating func peek() -> T? {
    while let popElement = enqueueStack.pop() {
      dequeueStack.push(popElement)
    }
    return dequeueStack.peek
  }
}
```

# Exercises

[Link](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/units/unit03/whiteboarding/Queue-Exercises.md) to exercises for pair whiteboarding.

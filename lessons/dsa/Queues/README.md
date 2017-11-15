# Queues

A **Queue** is another way to organize and store data.

A queue is like a line of people.  When someone enters the line, they enter at the back.  When someone leaves the line, they leave from the front.

![Line of people](http://pythonschool.net/data-structures-algorithms/images/queue.jpg)

In computer science, the following image models the abstract data type:

![Queue ADT](https://upload.wikimedia.org/wikipedia/commons/thumb/5/52/Data_Queue.svg/300px-Data_Queue.svg.png)

**Enqueue** means enter the queue

**Dequeue** means leave the queue

# First In First Out (FIFO)

In a queue, the first element to enter the queue is also the first one to leave it.  This is because we always remove from the front of the queue and insert at the back of the queue.  This order is called **First In First Out**, or **FIFO**.

As soon as we dequeue, we are dequeuing the elemnt that has been in line the longest.  Just like if you were queueing at a bank, if you are the first person in the queue, you will be the first one helped.

## Methods

A queue has the following methods:

- **enQueue(_:)** : Adds an element to the back of the queue.

- **deQueue()** : Removes and returns the first element in the queue.

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
3. IT Repear tickets


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
    private var arr = [T]()
    var isEmpty: Bool {
        return arr.isEmpty
    }
    mutating func enQueue(_ newElement: T) {
        arr.append(newElement)
    }
    mutating func deQueue() -> T? {
        return arr.removeFirst()
    }
    func peek() -> T? {
        return arr.first
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

A more standard implementation of a queue is using a linked list.  We will need to keep track of both the *head* and the *tail* of our linked list.  When we **enqueue**, we will add something to end and reset the tail to it.  When we **dequeue**, we will move the head one node forwards and return the old head value.  An empty queue will be represented by having both the head and the tail be nil.

```swift
class Node<Key> {
    let val: Key
    var next: Node?
    init(val: Key) {
        self.val = val
    }
}

struct Queue<T> {
    private var head: Node<T>?
    private var tail: Node<T>?
    var isEmpty: Bool {
        return head == nil
    }
    mutating func enQueue(_ newElement: T) {
        let newNode = Node(val: newElement)
        guard let tail = tail else {
            self.head = newNode
            self.tail = newNode
            return
        }
        tail.next = newNode
        self.tail = newNode
    }
    mutating func deQueue() -> T? {
        guard let oldHead = head else {
            return nil
        }
        self.head = oldHead.next
        return oldHead.val
    }
    func peek() -> T? {
        return self.head?.val
    }
}
```

#### Exercise - Print all elements in a Queue



## Implementation - Two Stacks

A Queue is an Abstract Data Type.  As such, we can chose to have any any data structure  underlying our queue.  We saw implementations with both an Array and a Linked List above.  

A common interview problem is to use two stacks to represent a Queue.  This is less for its usefulness as a way of modeling information, but more to demonstrate familiarity with Stacks and Queues.

As such, this implementation is not meant to be particularly efficient.

```swift
struct Stack<T> {
    private var arr = [T]()
    var isEmpty: Bool {
        return arr.isEmpty
    }
    mutating func push(_ newElement: T) {
        arr.append(newElement)
    }
    mutating func pop() -> T? {
        return arr.popLast()
    }
    func peek() -> T? {
        return arr.last
    }
}

struct Queue<T> {
    private var enQueueStack = Stack<T>()
    private var deQueueStack = Stack<T>()
    var isEmpty: Bool {
        return enQueueStack.isEmpty && deQueueStack.isEmpty
    }
    mutating func enQueue(_ newElement: T) {
        while !deQueueStack.isEmpty {
            enQueueStack.push(deQueueStack.pop()!)
        }
        enQueueStack.push(newElement)
    }
    mutating func deQueue() -> T? {
        while !enQueueStack.isEmpty {
            deQueueStack.push(enQueueStack.pop()!)
        }
        return deQueueStack.pop()
    }
    mutating func peek() -> T? {
        while !enQueueStack.isEmpty {
            deQueueStack.push(enQueueStack.pop()!)
        }
        return deQueueStack.peek()
    }
}
```

# Exercises

1-5: [AC-iOS Repo](https://github.com/C4Q/AC-iOS-QueueProblems/tree/startingBranch)

6: [Two Stacks](https://www.hackerrank.com/challenges/ctci-queue-using-two-stacks/problem)

7: [Interleave a Queue](http://www.geeksforgeeks.org/interleave-first-half-queue-second-half/)


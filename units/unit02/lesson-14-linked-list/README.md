
## Linked List


A linked list is a way of storing information.  A linked list consists of a series of nodes.  Each node contains data, as well as a pointer to the next node in the series.

![Linked list picture](https://upload.wikimedia.org/wikipedia/commons/6/6d/Singly-linked-list.svg)


## Common Operations

### Access an element

![Linked List Access](https://upload.wikimedia.org/wikipedia/commons/6/6d/Singly-linked-list.svg)

<details>
<summary>Runtime</summary>
O(n)
</details>

<details>
<summary>Explanation</summary>
In order to access the node at index 2, we need to   visit every node before it.
</details>  

### Insert an element

![Linked List Insertion](https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/CPT-LinkedLists-addingnode.svg/474px-CPT-LinkedLists-addingnode.svg.png)


<details>
<summary>Runtime</summary>
O(1)
</details>


<details>
<summary>Explanation</summary>
We can insert a node in constant time by changing the   pointer of the previous node to point to the new   node.
</details>  


### Find an element

![Linked List Find](https://upload.wikimedia.org/wikipedia/commons/6/6d/Singly-linked-list.svg)

<details>
<summary>Runtime</summary>
O(n)
</details>


<details>
<summary>Explanation</summary>
In order to find an element, we have to look at each   node in the linked list.
</details>


### Delete an element

![Linked List Delete](http://www.tech-faq.com/wp-content/uploads/2009/05/deleting-an-element-from-a-linear-linked-list.jpeg)


<details>
<summary>Runtime</summary>
O(1)
</details>


<details>
<summary>Explanation</summary>
We need to change the pointer of a node to the node   after the node we want to delete.
</details>


### Node Implementation

We can make a functional linked list of Ints with only a Node class.

```swift
class Node {
    var value: Int
    var next: Node?

    init(value: Int, next: Node? = nil) {
        self.value = value
    }
}
```

But what if we want to be able to make our Linked List Node not limited just to Ints?

### Generics

[Swift Documenation](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html)

Generics are a powerful tool in Swift that lets us extend code to multiple different types.  The symbol: 'T' indicates a generic type.  Let's rewrite the code from above:

```swift
class Node<T> {
    var value: T
    var next: Node?

    init(value: T, next: Node? = nil) {
        self.value = value
    }
}
```

The 'T' in angle brackets indicates that the class will use generics.  We can make the generic Node type conform to a protocol as well:

```swift
class Node<T: Equatable> {
    var value: T
    var next: Node?

    init(value: T, next: Node? = nil) {
        self.value = value
    }
}
```

More on generics can be found [here](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/mvc-view-lifecycle/generics/README.md)

**Exercise**:  Create a series of nodes that matches the diagram below:

```
4 -> 9 -> 2 -> nil
```

**Exercise**:  Create a series of nodes that matches the diagram below:

```
"d" -> "a" -> "c" -> "p" -> nil
```

**Exercise**:  Create a series of nodes that matches the diagram below:

```
[1,2,3] -> [2] -> [6,8,2] -> [] -> nil
```


**Exercise**: Iterate through each linked list and print out every element.


### Linked List Implementation

We might want to build a little more structure on top of our Node class.  Let's make a LinkedList class that will wrap the function

**Exercise**: Write a function that checks if two linked lists are the same

```
Sample Input 1:
3 -> 8 -> 4 -> 1 -> nil

1 -> 4 -> 8 -> 3 -> nil

Sample Output 1: false

Sample Input 2:

3 -> 8 -> 4 -> 1 -> nil

3 -> 8 -> 4 -> 1 -> nil

Sample Output 2: true
```

**Exercise**: Write a function that reverses a linked list

```
Sample Input 1:

3 -> 8 -> 4 -> 1 -> nil

Sample Output 1:

1 -> 4 -> 8 -> 3 -> nil
```

**Linked List Implementation**  
  
```swift 
class Node<T: Equatable>: CustomStringConvertible, Equatable {
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

class LinkedList<T: Equatable>: CustomStringConvertible {
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
  
  public func append(_ value: T) {
    let newNode = Node(value: value)
    if let lastNode = tail {
      lastNode.next = newNode
    } else {
      head = newNode
    }
    tail = newNode
  }
  
  public func removeLast() -> Node<T>?  {
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

## Doubly Linked List

A doubly linked list is very similar to a singly linked list. The only distinction is that each Node has both a next Node as well as a previous Node.

The main advantage to using a doubly linked list is that we can iterate through in either direction.

We'll need to rewrite our Node to include a previous Node.

```swift
class Node<T: Equatable> {
  var value: T
  var next: Node?
  var previous: Node?

  init(value: T, next: Node? = nil) {
    self.value = value
  }
}
```

**Exercise**: Reverse a doubly linked list

```
Sample Input 1:
[3, 8, 4, 1]


Sample Output 1:

[1, 4, 8, 3]
```





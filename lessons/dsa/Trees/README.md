# Trees

So far, we have looked at the following ways of storing information:

- Array
- Linked List
- Stack
- Queue
- Hashmap

Today, we will look at a new data structure called a *Tree*

# 1. The case for trees

How would you model the diagram below?

![move](https://eight2late.files.wordpress.com/2016/02/7214525854_733237dd83_z1.jpg?w=700)

This information is presented in a new way then what we have seen before.  Instead of a straightforward list, there are branching possibilities.  Each element is linked not only to one element, but two different possibilities.  Arrays and Linked lists only operate in one dimension (a line).  Hashmaps can track groupings, but don't have any order.  We are looking for a structure that can represent one object being linked to multiple objects AND keeping a sequence.

# 2. Defining a Tree

Trees are comprised of nodes, and are very similar to Linked Lists.  Just like a LinkedListNode, a TreeNode has a value.  While a LinkedListNode has only one `next` Node, a TreeNode can have any number of `next` Nodes.  The most common type of tree is called a *Binary Tree* where each TreeNode can have up to two `next` Nodes.

```
class TreeNode {
   let val: Int
   let left: TreeNode?
   let right: TreeNode?
   init(_ val: Int) {
      self.val = val
   }
}
```

Just like a LinkedListNode might not have a `next` Node, a TreeNode might not have a `left` or a `right`.  Before we go on to traversing a tree, let's take a look at some key terminology.

# 3. Key Terminology

<details>
<summary>Example One</summary>

![treeOne](http://msoe.us/taylor/tutorial/cs2852/bstTreeNames.png)

(source: http://msoe.us/taylor/tutorial/cs2852/bst)

</details>


<details>
<summary>Example Two</summary>

![treeTwo](http://2.bp.blogspot.com/-CApCcTOe1A0/TwppaUWiQsI/AAAAAAAABX4/sJv92_ZJzhE/s1600/Tree+Term.gif)

(source: http://anandabhisheksingh.me/tree-terminology-data-structure/)

</details>


- The top of any tree is called the `root`
- The left and right nodes are called `children`
- The left and right nodes are `siblings` to each other
- The node the holds the children is called the `parent`
- You can pick any node in a tree and call it the `root` of its own subtree.  We can start to see its recursive structure.
- A node at the bottom of a tree is called a `leaf`
- An `edge` is a line connecting two nodes
- The `height` of the tree is the number of edges in the longest path from the top to the bottom
- The `level` of a node is which row it is on.  The root is at level 0, its children are at level 1, and so on.

# 4. Types of Trees

With this structure, we are able to create a variety of different trees.  It will be helpful to use the following terminology to define what kind of tree we are working with.

### Binary Tree

A Binary Tree is a tree where every node has 0,1 or 2 children.

<details>
<summary>Example</summary>

![bin](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/Binary_tree.svg/1200px-Binary_tree.svg.png)

(source: wikipedia)

</details>


<details>
<summary>Non Example</summary>

![tern](https://upload.wikimedia.org/wikipedia/commons/2/23/Ternary_tree.png)

(source: wikipedia)

</details>


### Full Binary Tree

A Full Binary Tree is a Binary Tree where every node has 0 or 2 children.

<details>
<summary>Example</summary>

![bin](https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Full_binary.pdf/page1-220px-Full_binary.pdf.jpg)

(source: wikipedia)

</details>



<details>
<summary>Non Example</summary>

![bin](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f7/Binary_tree.svg/1200px-Binary_tree.svg.png)

(source: wikipedia)

</details>


### Complete Binary Tree

A Complete Binary Tree is a Binary Tree where every level except possibly the last is completely filled and each node on the last level is as far left as possible.  A Complete Binary Tree is allowed to have a single Node with one child, all others must have 0 or 2.


<details>
<summary>Example</summary>

![bin](https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Complete_binary.pdf/page1-733px-Complete_binary.pdf.jpg)

(source: wikipedia)

</details>



<details>
<summary>Non Example</summary>

![bin](https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Full_binary.pdf/page1-220px-Full_binary.pdf.jpg)

(source: wikipedia)

</details>

### Balanced Binary Tree

A Balanced Binary Tree is a Binary tree where the left and right subtrees height differ by at most 1 and both the left and right tree are balanced.  A balanced Binary Tree is one where the height is O(log(n)), where n is the number of elements.

<details>
<summary>Example</summary>

![bin](https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Complete_binary.pdf/page1-733px-Complete_binary.pdf.jpg)

(source: wikipedia)

</details>


<details>
<summary>Non Example</summary>

![bin](https://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/Full_binary.pdf/page1-220px-Full_binary.pdf.jpg)

(source: wikipedia)

</details>


### Degenerate Tree

A Degenerate tree is a Tree where every parent has, at most, one child.  It's effectively just a Linked List.

<details>
<summary>Degenerate Tree</summary>

![degen](https://secweb.cs.odu.edu/~zeil/cs361/web/website/Lectures/bst/pages/bstdegen.jpg)

Source: https://secweb.cs.odu.edu/~zeil/cs361/web/website/Lectures/bst/pages/bstdegen.jpg

</details>

### Binary Search Tree

A Binary Search Tree is Binary Tree with two conditions:

- Every `left` child must be less than its parent
- Every `right` child must be greater than its parent
- (Generally BSTs are defined to have unique values)

Typically, when people talk about trees they are talking about Binary Search Trees.

<details>
<summary>Example</summary>

![bin](https://upload.wikimedia.org/wikipedia/commons/d/da/Binary_search_tree.svg)

(source: wikipedia)

</details>


<details>
<summary>Non Example</summary>

![bin](https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Max-Heap.svg/1200px-Max-Heap.svg.png)

(source: wikipedia)

</details>


### Min Heap

A Min Heap is a Complete Binary Tree where each parent is smaller than its children.  The root is the smallest value in the tree


<details>
<summary>Example</summary>

![bin](https://upload.wikimedia.org/wikipedia/commons/thumb/6/69/Min-heap.png/240px-Min-heap.png)

(source: wikipedia)

</details>

<details>
<summary>Non Example</summary>

![bin](![bin](https://i-msdn.sec.s-msft.com/dynimg/IC520.gif))

(source: https://msdn.microsoft.com/en-us/library/ms379572(v=vs.80).aspx)

</details>

Source: (https://www.cs.cmu.edu/~adamchik)


### Max Heap

A Max Heap is a Complete Binary Tree where each parent is bigger than its children.  The root is the biggest value in the tree.

<details>
<summary>Example</summary>

![bin](https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Max-Heap.svg/1200px-Max-Heap.svg.png)

(source: wikipedia)

</details>


<details>
<summary>Non Example</summary>

![bin](https://www.tutorialspoint.com/data_structures_algorithms/images/binary_search_tree.jpg)

(source: https://www.tutorialspoint.com)

</details>


# 5. Traversing a Tree

TreeNode class

```swift
class TreeNode {
    var key: Int
    var left: TreeNode?
    var right: TreeNode?
    init(key: Int) {
        self.key = key
    }
}
```
Building a simple tree

![treeImage](placeholder)


```swift
let root = TreeNode(key: 1)
let nodeTwo = TreeNode(key: 2)
let nodeThree = TreeNode(key: 3)
let nodeFour = TreeNode(key: 4)
let nodeFive = TreeNode(key: 5)

root.left = nodeTwo
root.right = nodeThree
nodeTwo.left = nodeFour
nodeTwo.right = nodeFive
```

<details>
<summary>What kind of tree is this?</summary>

A Min Heap

</details>

How can we print out all the values?  Unlike an array, we can't just iterate over it.  And unlike a linked list, it isn't clear which way to go next.  We have *two* nexts and we have to go to both of them.  We have two strategies for how we can look at every node.

1. Look at all of the nodes on a single level before going to the next one (Breadth First Search)
2. Follow a chain all the way to a leaf node before returning back to the top (Depth First Search)

We will look at each in turn.

## Breadth First Search

For a Breadth First Search, we want to look at:

- All the nodes on level 0
- Then all the nodes on level 1
- Then all the nodes on level 2

Here's how we can implement this in code.  First, we'll need a Queue.  Here's one from a few weeks ago:

```swift
class LLNode<Key> {
    let val: Key
    var next: LLNode?
    init(val: Key) {
        self.val = val
    }
}
struct Queue<T> {
    private var head: LLNode<T>?
    private var tail: LLNode<T>?
    var isEmpty: Bool {
        return head == nil
    }
    mutating func enQueue(_ newElement: T) {
        let newNode = LLNode(val: newElement)
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
        if oldHead.next == nil {
            self.tail = nil
        }
        return oldHead.val
    }
    func peek() -> T? {
        return self.head?.val
    }
}

```

Now we can implement our breadth first search

```swift
func bfs<T>(root: TreeNode<T>) {
    var myQueue = Queue<TreeNode<T>>()
    myQueue.enQueue(root)
    while !myQueue.isEmpty {
        let visitedElement = myQueue.deQueue()!
        print(visitedElement.key)
        if let leftChild = visitedElement.left {
            myQueue.enQueue(leftChild)
        }
        if let rightChild = visitedElement.right {
            myQueue.enQueue(rightChild)
        }
    }
}
```

This algorithm visits each node on each level before proceding to the next level.

## Depth First Search

There are three ways in which we can implement a depth first search.  We will see each in turn below.

### Pre-order Depth First Search

```swift
func dfs<T>(root: TreeNode<T>?) {
    guard let root = root else { return }
    print(root.key)
    dfs(root: root.left)
    dfs(root: root.right)
}
```

### In-order Depth First Search

```swift
func dfs<T>(root: TreeNode<T>?) {
    guard let root = root else { return }
    dfs(root: root.left)
    print(root.key)
    dfs(root: root.right)
}
```

### Post-Order Depth First Search

```swift
func dfs<T>(root: TreeNode<T>?) {
    guard let root = root else { return }
    dfs(root: root.left)
    dfs(root: root.right)
    print(root.key)
}
```


### Slightly Fancier Handling

Instead of just printing each node's key, we can have a custom closure that handles it however we want:

```swift
func dfs<T>(root: TreeNode<T>?, process: (T) -> Void = {print($0)}) {
    guard let root = root else { return }
    process(root.key)
    dfs(root: root.left, process: process)
    dfs(root: root.right, process: process)
}
```

### Enum implementation

```swift
enum BinaryTree<T> {
  case empty
  indirect case node(BinaryTree, T, BinaryTree)
}
```


[Further reading from raywenderlich](https://www.raywenderlich.com/139821/swift-algorithm-club-swift-binary-search-tree-data-structure)

# 6. Binary Search Tree Big O

![bigbin](https://i-msdn.sec.s-msft.com/dynimg/IC520.gif)

## Search / Access : O(log(n))

**Search for 27**

![search](https://blog.penjee.com/wp-content/uploads/2015/11/binary-search-tree-sorted-array-animation.gif)

(Source: https://blog.penjee.com/wp-content/uploads/2015/11/binary-search-tree-sorted-array-animation.gif)

## Insert: O(log(n))

![insert](https://blog.penjee.com/wp-content/uploads/2015/11/binary-search-tree-insertion-animation.gif)

## Remove: O(log(n))

Three cases:

<details>
<summary> 1. Node to be removed is a leaf node </summary>

![noChild](http://www.algolist.net/img/bst-remove-case-1.png)

Source: http://www.algolist.net/img/bst-remove-case-1.png

</details>

<details>
<summary> 2. Node to be removed has one child </summary>

![2-1](http://www.algolist.net/img/bst-remove-case-2-1.png)

![2-2](http://www.algolist.net/img/bst-remove-case-2-2.png)

![2-3](http://www.algolist.net/img/bst-remove-case-2-3.png)

Source: http://www.algolist.net

</details>

<details>

<summary>3. Node to be removed has two children</summary>

![3-4](http://www.algolist.net/img/bst-remove-case-3-4.png)

![3-5](http://www.algolist.net/img/bst-remove-case-3-5.png)

![3-6](http://www.algolist.net/img/bst-remove-case-3-6.png)

</details>


### Worst case

The worst case runtime for each of these operations is O(n).  This occurs when you have a degenerate binary search tree that looks like a linked list.

<details>
<summary>
Why are insertion and deletion O(1) on a linked list and O(n) for a degenerate binary search tree?
</summary>

Binary Search Trees have to keep a sorted order, which means it can only insert an element in the place it belongs in the tree, which could be at the bottom.

</details>
## Hash Tables

## References

* https://en.wikipedia.org/wiki/Hash_table
* http://nshipster.com/swift-comparison-protocols/ (Hashable and Equatable sections)

A hash table is a data structure used to implement a collection of key-value pairs, such as Dictionary in Swift. 
Each key appears only once in the collection and can be used as an index much in 
the way an integer is used to index an array. In fact, this gives a hint as to 
part of a common implementation of hashes.

## A Hash Table by any other name...

A Hash Table can also be referred to as:

* a map
* a dictionary
* an associative array

A map in the sense that it allows us to map a single value to any given key. Dictionaries
imply unique terms/works that seek into longer descriptions. And assocciative array makes 
us think of an array as the means by which we can associate two pieces of data.

A Hash table gets its name from the process by which keys are generated, and where they're stored.
Hashing is the process by which a key is converted to an integer. Hash is used both as a verb and
a noun. I hash a key to make a hash of it. Table is just another word for Array.

```swift 
// getting hash values
let swedenHash = "Sweden".hashValue // 3649514877415349888 - this number will vary between launches
let bucket = swedenHash % 5 // bucket 3
let hobbiesHashValues = 4799450060928805186 % 5 // index 1
```

## Operations

* add (insert, set)
* reassign (replace, update, set)
* remove (delete)
* find (lookup)
* isEmpty

Add: add a new (key,value) pair to the collection, binding the new key to its new value. The arguments to this operation are the key and the value.

Reassign: replace the value in one of the (key,value) pairs that are already in the collection, binding an old key to a new value. As with an insertion, the arguments to this operation are the key and the value.

Remove: remove a (key,value) pair from the collection, unbinding a given key from its value. The argument to this operation is the key.

Find: find the value (if any) that is bound to a given key. The argument to this operation is the key, and the value is returned from the operation. If no value is found, some associative array implementations raise an exception.

Often, instead of add and reassign there is a single **set** operation that adds a new (key,value) pair if one does not already exist, and otherwise reassigns it.

> You can't iterate over the table in a meaningful order. This is different from arrays that 
> have deterministic ordering. I.e. the order you put things in is the order they come out.

Q. How is the key converted to a number?

A. Hash function

## Hash Function

A hash table uses a hash function on the key to compute an index (hash) into
an array of buckets or slots, from which the desired value can be
found.

* Ideally, the hash function will assign each key to a unique bucket
(perfect hash function).

* ...but it is possible that two keys will generate an identical hash
  causing both keys to point to the same bucket!

* So... a hash table should assume that hash collisions — different
keys that are assigned by the hash function to the same bucket —
will sometimes occur and must be accommodated in some way

A common pattern is to offload the work of hashing to the given object because it knows best how to 
hash itself. In Swift this is formalized by converting to the ```Hashable```
protocol, which itself extends/requires ```Equatable```. Looking into 
the implementation of hash tables will reveal why any type that is to be
used as a **key** in a hash table must be able to be hased and compared
to others of its type.


### Collision Resolution

There is one problem: because we take the modulo of the hash value with the size of the array, it can happen that two or more keys get assigned the same array index. This is called a collision.

A common way to handle collisions is to use chaining. 


### Load Factor

The load factor of a hash table is the percentage of the capacity that is currently used. If there are 3 items in a hash table with 5 buckets, then the load factor is 3/5 = 60%.

Load factor = n/k 
where n = number of entries
k = number of buckets

When the load factor of the hash table is too high, the hash table is
not as effective

* O(1) lookup is no longer guaranteed
* In this case, we’ll need a bigger table, iterate over the previous table,
and insert the (key, value) pairs into the new table, using the new
hash function
* this takes time…and should occur as little as possible
* O(n) cost is amortized so that it can be ignored

### Analysis

* In a good hash table, the average cost for each lookup
is independent of the number of elements stored in the
table. I.e. O(1)

* Many hash table designs also allow arbitrary insertions
and deletions of key-value pairs, at (amortized) constant
average cost per operation

### Applications

O(1) lookup! Use it for everything!
* more efficient than search trees or any other table
lookup structure
* database indexing
* caches (browser, DNS, ARP caches)
* sets (HashSet)
* Gmail, DropBox attachments

#### Hash function applications

Hashing, without necessarily using a dictionary has applications in encryption. Often passwords 
are "one way" encrypted, meaning that given a password string, the same derived value (read: hash)
will reliably be generated from the same input. But, importantly, the hashed value cannot be
converted back into the original. This makes it possible to test for inputted password matches
without storing passwords.

#### Hash Table Implementation:

[typealias](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html)  

Type Alias Overview
Type aliases define an alternative name for an existing type. You define type aliases with the typealias keyword.
Once you define a type alias, you can use the alias anywhere you might use the original name.

[assert](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html)  

Assert Overview
Assertions and preconditions are checks that happen at runtime. You use them to make sure an essential condition is 
satisfied before executing any further code. If the Boolean condition in the assertion or precondition 
evaluates to true, code execution continues as usual. If the condition evaluates to false, the current state of 
the program is invalid; code execution ends, and your app is terminated.

[subscript](https://docs.swift.org/swift-book/LanguageGuide/Subscripts.html)  

Subscript Overview
Classes, structures, and enumerations can define subscripts, which are shortcuts for accessing the member elements 
of a collection, list, or sequence. You use subscripts to set and retrieve values by index without needing separate 
methods for setting and retrieval. For example, you access elements in an Array instance as someArray[index] 
and elements in a Dictionary instance as someDictionary[key].
You write subscript definitions with the subscript keyword, and specify one or more input parameters and a return type, 
in the same way as instance methods. Unlike instance methods, subscripts can be read-write or read-only. 
This behavior is communicated by a getter and setter in the same way as for computed properties


```swift
struct HashTable<Key: Hashable, Value> {
  
  // element in the chain
  // here we use a typealias to refer to the type - (key: Key, value: Value)
  private typealias Element = (key: Key, value: Value)
  
  // the chain
  private typealias Bucket = [Element]
  
  // array that makes up the hash table
  private var buckets: [Bucket]
  
  private var itemCount = 0
  
  // count of items in hash table
  public var count: Int {
    return itemCount
  }
  
  // empty state
  public var isEmpty: Bool {
    return itemCount == 0
  }
  
  init(capacity: Int) {
    // will fail if less than 0
    assert(capacity > 0)
    
    // create buckets with specified capacity
    buckets = Array<Bucket>(repeating: [], count: capacity)
  }
  
  // after hashing the key we return the index if will be in using the mod of the buckets count
  private func index(forKey key: Key) -> Int {
    return abs(key.hashValue) % buckets.count
  }
  
  // search
  public func value(forKey key: Key) -> Value? {
    // first find the index for the hashvalue of the key
    let index = self.index(forKey: key)
    
    // search for the element in the hash table
    for element in buckets[index] {
      if element.key == key {
        return element.value
      }
    }
    return nil
  }
  
  // update
  public mutating func updateValue(value: Value, forKey key: Key) -> Value? {
    // first find the index for the hashvalue of the key
    let index = self.index(forKey: key)
    
    // search if element is already in hash table
    for (i, element) in buckets[index].enumerated() {
      if element.key == key {
        let oldValue = element.value
        buckets[index][i].value = value
        return oldValue
      }
    }
    
    // add element if it was not found
    buckets[index].append((key: key, value: value))
    itemCount += 1
    return nil
  }
  
  // delete
  public mutating func removeValue(forKey key: Key) -> Value? {
    // first find the index for the hashvalue of the key
    let index = self.index(forKey: key)
    
    // remove element
    for (i, element) in buckets[index].enumerated() {
      if element.key == key {
        buckets[index].remove(at: i)
        itemCount -= 1
        return element.value
      }
    }
    return nil
  }
  
  // currently we can't subscript
  // Type 'HashTable<String, String>' has no subscript members
  // if we want to use subscripting syntax we have to define a subscript method and implemnt the functionality
  public subscript(key: Key) -> Value? {
    get {
      return value(forKey: key)
    } set {
      if let value = newValue {
        updateValue(value: value, forKey: key)
      } else {
        removeValue(forKey: key)
      }
    }
  }
}

// testing the hash table
var hashTable = HashTable<String, String>(capacity: 8)

print(hashTable)
// HashTable<String, String>(buckets: [[], [], [], [], [], [], [], []], itemCount: 0)

// insert
// currently we can't subscript
// Type 'HashTable<String, String>' has no subscript members
// if we want to use subscripting syntax we have to define a subscript method and implemnt the functionality
hashTable["5.1"] = "Full Stack Web"
hashTable["5.2"] = "Full Stack Web"
hashTable["5.3"] = "iOS Development"
hashTable["5.4"] = "Android Development"

print(hashTable.count) // 4

print(hashTable)
// HashTable<String, String>(buckets: [[], [], [], [], [], [], [(key: "5.1", value: "Full Stack Web")], []], itemCount: 1)

// update
hashTable["5.1"] = "Full Stack Web Development"

print(hashTable)
// HashTable<String, String>(buckets: [[(key: "5.1", value: "Full Stack Web Development")], [], [], [], [], [], [], []], itemCount: 1)

// search
if let foundCohort = hashTable["5.4"] {
  print("cohort is \(foundCohort)") // cohort is Android Development
}

// remove
hashTable["5.2"] = nil

print(hashTable)
// HashTable<String, String>(buckets: [[], [], [], [(key: "5.1", value: "Full Stack Web Development"), (key: "5.3", value: "iOS Development")], [], [(key: "5.4", value: "Android Development")], [], []], itemCount: 4)

print(hashTable.count) // 3
```



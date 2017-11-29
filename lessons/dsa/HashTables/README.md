# Hash Tables

## References

* https://en.wikipedia.org/wiki/Hash_table
* http://nshipster.com/swift-comparison-protocols/ (Hashable and Equitable sections)

A hash table is a data structure used to implement a collection of key-value pairs. 
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

### Hash Function Implementation

> From http://www.cse.yorku.ca/~oz/hash.html
> This hash function appeared in K&R (1st ed.) but at least the reader was warned: "This is not the best possible algorithm, but it has the merit of extreme simplicity." This is an understatement; It is a terrible hashing algorithm, and it could have been much better without sacrificing its "extreme simplicity." [see the second edition!] Many C programmers use this function without actually testing it, or checking something like Knuth's Sorting and Searching, so it stuck. It is now found mixed with otherwise respectable code, eg. cnews. sigh.
   	
> ```c
> unsigned long hash(unsigned char *str) {
>     unsigned int hash = 0;
> 	  int c;
> 
>     while (c = *str++)
> 	      hash += c;
> 
>     return hash;
> }
> ```
>
> A good implementation
>	```c
> 	unsigned long hash(unsigned char *str) {
> 	    unsigned long hash = 5381;
> 	    int c;
> 
> 	    while (c = *str++)
> 	        hash = ((hash << 5) + hash) + c; /* hash * 33 + c */
> 
> 	    return hash;
> 	}
	```

### Collision Resolution

* Open Addressing
	* Linear Probing
	* Double hashing

* Separate Chaining

![Separate chaining][separate]
> Image by Jorge Stolfi - Own work, CC BY-SA 3.0, https://commons.wikimedia.org/w/index.php?curid=6471238

### Load Factor

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

#### Implementation:

<details>
<summary>Swift struct</summary>

```swift
struct Hashmap<Key: Hashable, Value> {
    init(buckets: Int) {
        self.numberOfBuckets = buckets
        self.arr = Array(repeatElement([], count: buckets))
    }
    var keys: [Key] {
        return self.toArr().map{$0.0}
    }
    var values: [Value] {
        return self.toArr().map{$0.1}
    }
    
    private var numberOfBuckets: Int
    private var arr: [[(Key, Value)]]
    
    subscript(_ lookupKey: Key) -> Value? {
        get {
            let hashValue = lookupKey.hashValue
            let bucket = hashValue % numberOfBuckets
            let innerArr = self.arr[bucket]
            for (k,v) in innerArr {
                if k.hashValue == hashValue {
                    return v
                }
            }
            return nil
        }
        set(newValue) {
            let hashValue = lookupKey.hashValue
            let bucket = hashValue % numberOfBuckets
            let innerArr = self.arr[bucket]
            for (index, (k, _)) in innerArr.enumerated() {
                print("at index: \(index)")
                if k.hashValue == hashValue {
                    if let newValue = newValue {
                        self.arr[bucket][index] = (k, newValue)
                    } else {
                        self.arr[bucket].remove(at: index)
                    }
                }
            }
            if let newValue = newValue {
                self.arr[bucket].append((lookupKey, newValue))
            }
        }
    }
    func toArr() -> [(Key, Value)] {
        var arr = [(Key, Value)]()
        for innerArr in self.arr {
            for element in innerArr {
                arr.append(element)
            }
        }
        return arr
    }
}
```
</details>

### Exercises

1. Given a list of integers, i.e., {1, 1, 1, 1, 2, 2, 3,
	3, 5}, count how many times a given integer
	occurs, e.g.,
	{1, 4}, {2, 2}, {3, 2}, {5, 1}

2. Given a block of text find the 5 most common words.  [Sample text](https://www.usconstitution.net/const.txt)

3. Given two strings, check if they’re anagrams or not. Two strings are
anagrams if they are written using the same exact letters, ignoring
space, punctuation and capitalization. Each letter should have the
same count in both strings. For example, ‘eleven plus two’ and
‘twelve plus one’ are meaningful anagrams of each other.

4. Find the first non-repeated character in a string.


5. [iOS Hashmap Project](https://github.com/C4Q/AC3.2-Frankentable)
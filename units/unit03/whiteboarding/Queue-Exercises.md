## Queue Exercises

<pre>
1. Find the smallest element in a queue
</pre> 

```swift
func smallestElement<T: Comparable>(queue: Queue<T>) -> T? {
  return nil
}
```

</br></br>

<pre>
2. Find the sum of a queue of Ints
</pre>

```swift 
func sum(queue: Queue<Int>) -> Int {
  return 0
}
```

</br></br>

<pre> 
3. Find out whether or not a queue is in sorted order from smallest to biggest

Sample intput / output
(Back) 8 <- 7 <- 3 (Front) // true
(Back) 3 <- 7 <- 8 (Front) // false
</pre>

```swift 
func isQueueSortedAscending<T: Comparable>(queue: Queue<T>) -> Bool {
  return false
}
```

</br></br>

<pre>
4. Given a Queue as input, return a reversed queue. (Hint: A stack can be helpful here)

Sample Input:   (Back) 9 - 16 - 2 - 31 (Front)
Sample Output:  (Back) 31 - 2 - 16 - 9 (Front)
</pre> 

```swift 
func reverseQueue<T>(queue: Queue<T>) -> Queue<T> {
  return queue
}
```
  
</br></br>

<pre>
5. Determine if two Queues are equal
</pre> 

```swift 
func areQueuesEqual<T: Equatable>(queueOne: Queue<T>, queueTwo: Queue<T>) -> Bool {
  return false
}
```

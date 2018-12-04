## Queue Exercises

<pre>
Find the smallest element in a queue
</pre> 

```swift
func smallestElement<T: Comparable>(queue: Queue<T>) -> T? {
  return nil
}
```

</br></br>

<pre>
Find the sum of a queue of Ints

func sum(queue: Queue<Int>) -> Int {
  return 0
}
</pre>

</br></br>

<pre> 
Find out whether or not a queue is in sorted order from smallest to biggest

Sample intput / output
(Back) 8 <- 7 <- 3 (Front) // true
(Back) 3 <- 7 <- 8 (Front) // false

func isQueueSortedAscending<T: Comparable>(queue: Queue<T>) -> Bool {
  return false
}
</pre>

</br></br>

<pre>
Given a Queue as input, return a reversed queue. (Hint: A stack can be helpful here)

Sample Input:   (Back) 9 - 16 - 2 - 31 (Front)
Sample Output:  (Back) 31 - 2 - 16 - 9 (Front)

func reverseQueue<T>(queue: Queue<T>) -> Queue<T> {
  return queue
}
</pre> 
  
</br></br>

<pre>
Determine if two Queues are equal

func areQueuesEqual<T: Equatable>(queueOne: Queue<T>, queueTwo: Queue<T>) -> Bool {
  return false
}
</pre> 

# Binary Search 

Swift collection arr.index { $0.id == item.id } is a linear search algorithm where the worst case runtime is O(n). 

Linear search example 
```swift 
func linearSearch<T: Comparable>(inputArray: [T], searchKey: T) -> Int? {
  for i in 0..<inputArray.count {
    if inputArray[i] == searchKey {
      return i
    }
  }
  return nil
}
let someInput = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
linearSearch(inputArray: someInput, searchKey: 16) // runtime O(n)
```

Binary Search however uses divide and conquer approach. The method speeds up the search algorithm and has a worst case runtime of O(log n). 

Using a log [calculator](https://www.rapidtables.com/calc/math/Log_Calculator.html) on a binary search of say 100_000 elements the search will run approximately 20 times. 

A Binary Search works on a sorted array. So first we need to ensure that the array is sorted. 

**How a Binary Search works:**   

- first split the array and determine if the search key is in the left or right half of the split. 
- a comparison is used to determine which side to keep search in, so the search item needs to conform to _comparable_ 
- depending on which side the passes the comparison that half is further divided in half and the search process continues
- the process is continued until the key is found or the array can't be divided in halves any further (in this scenario the key is not found) 

## Binary Search Implementation 

```swift 
// return an optional Int? for the found index as the key may not be in the array
func binarySearch<T: Comparable>(inputArray: [T], searchKey: T, range: Range<Int>) -> Int? {
  if range.lowerBound >= range.upperBound {
    return nil
  } else {
    let middleIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
    if inputArray[middleIndex] > searchKey {
      return binarySearch(inputArray: inputArray, searchKey: searchKey, range: range.lowerBound..<middleIndex)
    } else if inputArray[middleIndex] < searchKey {
      return binarySearch(inputArray: inputArray, searchKey: searchKey, range: middleIndex + 1..<range.upperBound)
    } else {
      return middleIndex
    }
  }
}
let input = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
binarySearch(inputArray: input, searchKey: 16, range: 0..<input.count)

```

## Reading 

[More on Binary Search from Ray Wenderlich](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Binary%20Search)  

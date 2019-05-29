# Quick Sort and Merge Sort

Resources:

1. [Ray Wenderlich Merge Sort](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Merge%20Sort)
2. [Ray Wenderlich Quicksort](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Quicksort)
3. [Wikipedia Merge Sort](https://en.wikipedia.org/wiki/Merge_sort)
4. [Wikipedia Quicksort](https://en.wikipedia.org/wiki/Quicksort)



So far, we've looked at sorts that take O(n<sup>2</sup>) time.  Those were:

- Insertion Sort
- Bubble Sort

Both of the algorithms are helpful for learning how sorting works, but aren't actually used because they are too slow.

Today we will look at two recursive sorting algorithms, QuickSort and MergeSort. 

## Quicksort

Quicksort splits an unsorted array based on a **pivot**. There are a few ways to determine the pivot such as _Lomuto's partitioning scheme_, _Hoare's_ or _the Dutch Flag_ partitioning scheme. More here [Quicksort](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Quicksort) 

Given a pivot, the elements less than the pivot are partitioned into an array, elements equal to the pivot are partitioned into a second array and elements more than the pivot are partitioned into a third array. Recursion is used to split the arrays into smaller partitions until the base case if reached and the sorted array is reached. 

Here's how it works:

1. If the array has only one element, return it.
2. Find the middle element of the array and name it <i>pivot</i>.
3. Move all the elements smaller than the pivot into an array called <i>less</i>.
4. Move all the elements equal to the pivot into an array called <i>equal</i>.
5. Move all the elements greater than the pivot into an array called <i>greater</i>
6. Return the following:
 
This function passing in <i>less</i> as input + <i>equal</i> + this function passing in <i>greater</i> as input.

Let's go through some examples:
 
### Example One:
 
var arr1 = [8,4,2]
 
 1. Skip this step as arr1 has 3 elements.
 2. pivot = 4
 3. less = [2]
 4. equal = [4]
 5. greater = [8]
 6. return quicksort([2]) + [4] + quicksort([8])
 
 quicksort([2]) and quicksort([4]) hit the basecase in step one and return the input.  Therefore, the function returns [2,4,8]
 
### Example Two:
 
 var arr2 = [11,8,15,10,4,14,2]
 
  1. Skip this step as arr2 has 7 elements.
  2. pivot = 10
  3. less = [8,4,2]
  4. equal = [10]
  5. greater = [10,15,14]
  6. return quicksort([8,4,2]) + [10] + quicksort([11,15,14])

 quicksort([8,4,2]) = [2,4,8] as we saw in example one
  
### quicksort([11,15,14]) :
  
  1. Skip this step as the array has 3 elements
  2. pivot = 15
  3. less = [11,14]
  4. equal = [15]
  5. greater = []
  6. return quicksort([11,14]) + [15] + []
  
### quicksort(11,14) :
  
  1. Skip this step as the array has 2 elements
  2. pivot = 11
  3. less = []
  4. equal = [11]
  5. greater = [14]
  6. return [] + [11] + [14] = [10,14]

  Therefore, quicksort([11,15,14]) = [11,14,15]
  
  And so quicksort([8,4,2]) + [10] + quicksort([11,15,14]) = [2,4,8,10,11,14,15]


### In Code:


```swift
// first we need to partition the array using a partitioning scheme
// other partitioning schemes include Hoare's and Dutch Flag scheme
public func partitionLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) -> Int {
  let pivot = a[high]
  var i = low
  for j in low..<high {
    if a[j] <= pivot {
      a.swapAt(i, j)
      i += 1
    }
  }
  a.swapAt(i, high)
  return i
}

// we are making sure only types that are comparable work with quicksort
public func quicksortLomuto<T: Comparable>(_ a: inout [T], low: Int, high: Int) {
  if low < high {
    let pivot = partitionLomuto(&a, low: low, high: high)
    quicksortLomuto(&a, low: low, high: pivot - 1)
    quicksortLomuto(&a, low: pivot + 1, high: high)
  }
}

var list = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
partitionLomuto(&list, low: 0, high: list.count - 1)
print(list)

var list2 = [12, 0, 3, 9, 2, 21, 18, 27, 1, 5, 8, -1, 8]
quicksortLomuto(&list2, low: 0, high: list2.count - 1) // [-1, 0, 1, 2, 3, 5, 8, 8, 9, 12, 18, 21, 27]
print(list2)
```

### Time Complexity:

Given an ideal pivot the runtime for Quicksort in O(n log n)   
If a bad pivot is choosen the worst case could easily become O(n ^ 2)


## Merge Sort

Merge sort uses a **divide and conquer** approach to sorting. The unsorted array is first **splitted** up into smaller arrays until one element remains. At this point the single element arrays are **merged** back into a final sorted array. This approach like Quick sort always uses recursion. 

Assume you need to sort an array of n numbers in the right order. The merge-sort algorithm works as follows:
- Put the numbers in an unsorted pile.
- Split the pile into two. Now, you have two unsorted piles of numbers.
- Keep splitting the resulting piles until you cannot split anymore. In the end, you will have n piles with one number in each pile.
- Begin to merge the piles together by pairing them sequentially. During each merge, put the contents in sorted order. This is fairly easy because each individual pile is already sorted.

Here's how it works:

1. If the array only has one element, return it
   
2. Call this function on the left side and the right side.  Set these calls equal to variables <i>left</i> and <i>right</i>

3. Merge <i>left</i> and <i>right</i> together (assuming that <i>left</i> and <i>right</i> are sorted) and return that array

This can be a little tricky, so let's go through some examples.

### Example One:

var arr1 = [3,1]

1. Skip this as there are two elements
2. This call will return [3] and [1]
3. Merge [3] and [1] to make [1,3] and return it


### Example Two:

var arr2 = [3,1,8,2]

1. Skip this as there are four elements
2. We set <i>left</i> equal to this function passing in [3,1] and <i>right</i> equal to this function passing in [8,2] .  As we see from example one, <i>left</i> = [1,3].  We can deduce that <i>right</i> = [2,8]

3. Merge [1,3] and [2,8] to make [1,2,3,8] and return it


### Example Three:

var arr3 = [3,1,8,2,10,4,6,5]

1. Skip this as there are eight elements
2. We set <i>left</i> equal to this function passing in [3,1,8,2] and <i>right</i> equal to this function passing in [10,4,6,5] .  As we see from example two, <i>left</i> = [1,2,3,8].  We can deduce that <i>right</i> = [4,5,6,10]

3. Merge [1,2,3,8] and [4,5,6,10] to make [1,2,3,4,5,6,8,10] and return it

### In Code:

```swift
public func mergeSort<Element>(_ array: [Element]) -> [Element] where Element: Comparable {
  guard array.count > 1 else { return array }
  let middle = array.count / 2
  let left = mergeSort(Array(array[..<middle]))
  let right = mergeSort(Array(array[middle...]))
  return merge(left, right)
}

private func merge<Elememnt>(_ left: [Elememnt], _ right: [Elememnt]) -> [Elememnt] where Elememnt: Comparable {
  var leftIndex = 0
  var rightIndex = 0
  var result: [Elememnt] = []
  while leftIndex < left.count && rightIndex < right.count {
    let leftElement = left[leftIndex]
    let rightElement = right[rightIndex]
    if leftElement < rightElement {
      result.append(leftElement)
      leftIndex += 1
    } else if leftElement > rightElement {
      result.append(rightElement)
      rightIndex += 1
    } else {
      result.append(leftElement)
      leftIndex += 1
      result.append(rightElement)
      rightIndex += 1
    }
  }
  if leftIndex < left.count {
    result.append(contentsOf: left[leftIndex...])
  }
  if rightIndex < right.count {
    result.append(contentsOf: right[rightIndex...])
  }
  return result
}

var list = [10, 0, 3, 9, 2, 14, 8, 27, 1, 5, 8, -1, 26]
print(mergeSort(list)) // [-1, 0, 1, 2, 3, 5, 8, 8, 9, 10, 14, 26, 27]
```

### Time complexity

Merge sort has a best, worst and average runtime of O(n * log(n))

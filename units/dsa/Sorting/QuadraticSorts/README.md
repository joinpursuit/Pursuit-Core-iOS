# Binary Search

Given a sorted list, we are able to find what we are looking for in **logarithmic time**.  How does this algorithm work?  Think of a sorted list like a phone book, sorted alphabetically by last name.  If you wanted to find someone inside the phone book, how would you find them?

Binary search operates on the same principles.  Start looking at an element in the middle, and see if it matches the element you are looking for.  If what you are looking for comes later, then  repeat the process in the second half.  Otherwise, repeat the process in the first half.

```swift
func binarySearch(arr: [Int], target: Int) -> Bool {
    guard !arr.isEmpty else { return false }
    let midIndex = arr.count / 2
    let midElement = arr[midIndex]
    if midElement == target { return true }
    if target > midElement {
        let elementsGreaterThanMid = Array(arr[(midIndex + 1)...])
        return binarySearch(arr: elementsGreaterThanMid, target: target)
    } else {
        let elementsLessThanMid = Array(arr[..<midIndex])
        return binarySearch(arr: elementsLessThanMid, target: target)
    }
}
```



# Sorting

### What we know so far

```swift
let myArr = [6,21,3,100]
let myArrSmallestToBiggest = myArr.sorted(by: <)
let myArrBiggestToSmallest = myArr.sorted(by: >)
```

### But how does it actually work?

There are two main types of sorting algorithms.  

- Algorithms that work in O(n * log(n)) time.

- Algorithms that work in O(n<sup>2</sup>) time

*Remember that in computer science, log(n) = log<sub>2</sub>(n)

We will begin by reviewing two common O(n<sup>2</sup>) algorithms because they are easier to understand.

|Sorting function|Runtime|
|---|---|
|Insertion Sort| O(n<sup>2</sup>)
|Bubble Sort| O(n<sup>2</sup>)
|Merge Sort| O(nlog(n))
|Quicksort | O(nlog(n))

## Bubble Sort

[Bubble Sort Sounds](http://www.caseyrule.com/projects/sounds-of-sorting/)


What buble sort does is look at at each pair of numbers.  If they are ordered correctly, we keep them in the same order.  Otherwise, we swap them.  Then, we keep going until the array is sorted.

```swift
func bubbleSort(arr: [Int]) -> [Int] {
    var arr = arr
    var madeSwapInLastPass = false
    repeat {
        madeSwapInLastPass = false
        for index in 0..<arr.count - 1 {
            if arr[index] > arr[index + 1] {
                let temp = arr[index]
                arr[index] = arr[index + 1]
                arr[index + 1] = temp
                madeSwapInLastPass = true
            }
        }
    } while madeSwapInLastPass
    return arr
}
```

##Insertion Sort

###Resources:
- [Khan Academy](https://www.khanacademy.org/computing/computer-science/algorithms/insertion-sort/a/insertion-sort)
- [Wikipedia](https://en.wikipedia.org/wiki/Insertion_sort)
- [Swift Algorithm Club](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Insertion%20Sort)

Insertion sort is a fairly intuitive algorithm for sorting a list.

Let's see what it looks like:

[![Insertion Sort](http://img.youtube.com/vi/8oJS1BMKE64/0.jpg)](https://www.youtube.com/watch?v=8oJS1BMKE64 "Insertion Sort")

Looks cool!  What does it do?

In plain English, we keep a sorted list on the left and everything else on the right.  We then iterate through the array, and everytime we hit an element, we move it to where it fits in the sorted part on the left.

We could also use a new array.  In that case, we will append every element in turn to a new array, then move it to the correct position.

Here's a step by step process for how that would work:

- Create a new array called sortedArr
- Iterate through the input array
- For every element:
  - Append that element to sortedArr
  - For every index starting from the last index in sortedArr:
     
     - Check to see if the value at that index is greater than the one directly to the left.
     - If it is, swap with it.  Otherwise break out of this loop and look at the next value.

     
```swift
func insertionSort(arr: [Int]) -> [Int] {
    var arr = arr
    var firstUnsortedElementIndex = 0
    while firstUnsortedElementIndex < arr.count {
        var currentIndex = firstUnsortedElementIndex
        while currentIndex > 0 {
            if arr[currentIndex] < arr[currentIndex - 1] {
                let temp = arr[currentIndex]
                arr[currentIndex] = arr[currentIndex - 1]
                arr[currentIndex - 1] = temp
            }
            currentIndex -= 1
        }
        firstUnsortedElementIndex += 1
    }
    return arr
}
```


# Exerises

0. [Binary Search](https://leetcode.com/problems/find-smallest-letter-greater-than-target/description/)
1. [Hackerrank Format](https://www.hackerrank.com/challenges/tutorial-intro/problem)
2. [Insertion Sort Part 1](https://www.hackerrank.com/challenges/insertionsort1/problem)
3. [Insertion Sort Part 2](https://www.hackerrank.com/challenges/insertionsort2/problem)
4. [Counting Bubble Sort](https://www.hackerrank.com/challenges/ctci-bubble-sort/problem)
5. [Codewars Bubble Sort](https://www.codewars.com/kata/bubble-sort)
5. [Sort a linked list](https://leetcode.com/problems/insertion-sort-list/description/)

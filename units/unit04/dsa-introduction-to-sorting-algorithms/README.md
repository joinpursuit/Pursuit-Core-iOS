
# Introduction to Sorting Algorithms

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

We will begin by reviewing two common O(n<sup>2</sup>) algorithms because they are easier to understand.

|Sorting function|Runtime|
|---|---|
|Insertion Sort| O(n<sup>2</sup>)
|Bubble Sort| O(n<sup>2</sup>)
|Merge Sort| O(nlog(n))
|Quicksort | O(nlog(n))

## Bubble Sort

What buble sort does is look at at each pair of numbers.  If they are ordered correctly, we keep them in the same order.  Otherwise, we swap them.  Then, we keep going until the array is sorted.

## Bubble Sort Implementation 

```swift
// [3, 1, -5, 10, 8] => [-5, 1, 3, 8, 10]
func bubbleSort(inputArray: inout [Int]) -> [Int] {
  for i in 0..<inputArray.count { // n
    for j in 1..<inputArray.count - i { // n
      if inputArray[j] < inputArray[j - 1] {
        let tmp = inputArray[j - 1]
        inputArray[j - 1] = inputArray[j]
        inputArray[j] = tmp
      }
    }
  }
  return inputArray
}
var input1 = [3, 1, -5, 10, 8]
bubbleSort(inputArray: &input1) // [-5, 1, 3, 8, 10]
```

## Insertion Sort

Goal: Sort an array from low to high (or high to low).

You are given an array of numbers and need to put them in the right order. The insertion sort algorithm works as follows:

Put the numbers on a pile. This pile is unsorted.
Pick a number from the pile. It doesn't really matter which one you pick, but it's easiest to pick from the top of the pile.
Insert this number into a new array.
Pick the next number from the unsorted pile and also insert that into the new array. It either goes before or after the first number you picked, so that now these two numbers are sorted.
Again, pick the next number from the pile and insert it into the array in the proper sorted position.
Keep doing this until there are no more numbers on the pile. You end up with an empty pile and an array that is sorted.
That's why this is called an "insertion" sort, because you take a number from the pile and insert it in the array in its proper sorted position.

## Insertion Sort Implementation

```swift 
// [3, 1, -5, 10, 8] => [-5, 1, 3, 8, 10]
func insertionSort(inputArray: inout [Int]) -> [Int] {
  for i in 0..<inputArray.count { // iterate array (n) times
    var j = i // for mutability since i is immuatable 
    while j > 0 && inputArray[j - 1] > inputArray[j] { // iterate back from i to 0 to perform swap as needed
      inputArray.swapAt(j - 1, j)
      j -= 1 // decrement to get to base case which is 0
    }
  }
  return inputArray
}
var input2 = [3, 1, -5, 10, 8]
insertionSort(inputArray: &input2) // [-5, 1, 3, 8, 10]
```

## Resources:
- [Khan Academy](https://www.khanacademy.org/computing/computer-science/algorithms/insertion-sort/a/insertion-sort)
- [Wikipedia](https://en.wikipedia.org/wiki/Insertion_sort)
- [Swift Algorithm Club](https://github.com/raywenderlich/swift-algorithm-club/tree/master/Insertion%20Sort)




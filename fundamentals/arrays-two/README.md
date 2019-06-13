### Arrays - Day 2

### Review:


```swift
let myArr = [1,5,2,3,194,-32]
```

1. print out all the numbers in the array
2. print out the length of the array
3. print out the last element in the array
4. print out the first element in the array
5. print out the sum of the array


### Arrays review

[We Heart Swift - Arrays Review](https://www.weheartswift.com/arrays/)  
[Apple Documentation - Arrays Documentation](https://developer.apple.com/documentation/swift/array)

### 13. Let's see some other built-in Array functions

1. contains
1. min / max
1. first / last
1. filter
1. reverse
1. shuffle
1. randomElement

### 14. Arrays can be multidimensional

```swift
let theMatrix = [[1, 2, 3],
                 [4, 5, 6],
                 [7, 8, 9]]

```

We are not limited to one dimension when creating arrays.  Arrays have to take one of the same type, but that type can be another array.  When you have an array of arrays, we call that a 2-dimensional array.  This is because it has both a width (the size of each array) and a height (the total number of arrays).

We can access whole arrays by subscripting the original array:

```
let firstArr = theMatrix[0]
```

We can access individual elements by subscripting the array we get from that

```
let firstElementInFirstArr = firstArr[0]
```


We can combine both of these lines together in a single expression:

```
let firstElementInFirstArr = theMatrix[0][0]
```

Conceptually, the first index corresponds with the *row* and the second index corresponds with the *column*


**Practice**:  Print out the element in each corner, then print out the element in the middle.

### 15. Building Arrays

If you need an array that is preinitialized with a fixed number of default values, use the Array(repeating:count:) initializer.

```swift
// using the array repeating initializer
let newArr = Array(repeating: 9, count: 4)
print(newArr) // output [9, 9, 9, 9]
```

**Practice:**

1. Make an array containing 200 copies of the number 9
1. Make an array containing 20 copies of the string "Hello"
1. Make a 2-dimensional 5 x 5 array of Ints all set to 0
1. Given a square array, print out all elements
```swift
let squareMatrix = [[6, 4, 4],
                    [3, 4, 1],
                    [1, 10, 5]]
```

### Standards

IOS: IOS.1

Language Fundamentals: LF.3, LF.3.a

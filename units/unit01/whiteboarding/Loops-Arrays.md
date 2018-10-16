## Whiteboarding - Loops, Arrays

1. What will the code below print?
```swift 
var myNum = 8
for number in 4..<8{
  if number == 7 {
    break
  } else {
    myNum += number
  }
}
print(myNum)
```

2. How many times will the code below print "Nesting!" ?
```swift 
for _ in 1...10{
  for _ in 1...10{
    print("Nesting!")
  }
}
```

3. Without using Xcode, how many times will the loop below run?  Explain why.
```swift
var i = 5
while (i > 3) {
  i += 1
}
```

4. Print out all the elements of the array
```swift 
let theMatrix = [[1, 2, 3],
                 [4, 5, 6],
                 [7, 8, 9]]
```

5. Find all elements in an array that appear more than once
```swift 
// Input: [1, 4, -2, -9, 2, -2, 1, 10, 4]

// Output: [1, -2, 4]
```

6. Find the sum of all elements in a multidimensional array except for the corners.
```swift
let intArray = [[1, 3, 9, 2],
                [3, 2, 0, 3],
                [2, 8, 1, 4]]
// Output: 29
```

7. Find the sum of the diagonals of a square, two-dimensional array of Ints
```swift 
let theMatrix = [[1, 2, 9],
                 [8, 2, 3],
                 [4, 5, 6]]
                 
// Output: 24 
```

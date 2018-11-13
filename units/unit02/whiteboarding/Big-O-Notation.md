## Big O Notation Lab 

1.  What is the runtime of doStuff(arr:)?

```swift 
func doStuff(arr: [Int]) {
  for num in arr {
    for num in arr {
      for num in arr {
        print(num)
      }
    }
  }
}
```

Your answer here: 

<details>
  <summary>Solution</summary>
  
O(n^3)
  
</details> 

</br></br> 

2. What is the runtime of doOtherStuff(arr:)?

```swift 
func doOtherStuff(arr: [Int]) {
  for num in arr {
    print(num)
  }
  for num in arr {
    for num in arr {
      print(num)
    }
  }
  for num in arr {
    print(num)
  }
}
```

Your answer here: 

<details>
  <summary>Solution</summary>

O(n^2) 

</details> 

</br></br> 

3. a) What is the runtime of foo(myArr:)?

```swift 
func foo(myArr: [Int]) {
  for num in myArr {
    print(num)
  }
}
```

Your answer here: 

<details>
  <summary>Solution</summary>
O(n) 
</details> 

</br>

3. b) What is the runtime of bar(myArr:)?

```swift 
func bar(myArr: [Int]) {
  foo(myArr: myArr)
  for _ in myArr {
    foo(myArr: myArr) 
  }
}
```

Your answer here: 

<details>
  <summary>Solution</summary>
O(n^2) 
</details> 

</br></br> 

4. What is the runtime of secondSmallest(myArr:)?

```swift 
func secondSmallest(myArr: [Int]) -> Int? {
  guard myArr.count > 1 else {
    return nil
  }
  var min = myArr[0]
  var minIndex = 0
  for (index, num) in myArr.enumerated() {
    if num < min {
      min = num
      minIndex = index
    }
  }
  var secondMin = (myArr[0] != min ? myArr[0] : myArr[1])
  for (index, num) in myArr.enumerated() {
    if num < secondMin && index != minIndex {
      secondMin = num
    }
  }
  print(min, minIndex, secondMin)
  return secondMin
}
```

Your answer here: 

<details>
  <summary>Solution</summary>
O(n) 
</details> 

</br></br> 


### Array Exercises
---

### Question 1.
**1a.** Create an array of strings called `colors` that contain "orange", "red", "yellow", "turquoise", and "lavender".

<details>
<summary><b>Solution</b></summary>

```swift
var colors = ["orange", "red", "yellow", "turquoise", "lavender"]
```
</details>

**1b.** Using array subscripting and string interpolation, print out the String "orange, yellow, and lavender are some of my favorite colors".

<details>
<summary><b>Solution</b></summary>

```swift
print("\(colors[0]), \(colors[2]), and \(colors[colors.count - 1]) are some of my favorite colors")
```
</details>


### Question 2.
Remove "Illinois" and "Kansas" from the array below.

```swift
var westernStates = ["California", "Oregon", "Washington", "Idaho", "Illinois", "Kansas"]
```

<details>
<summary><b>Solution</b></summary>

```swift
westernStates.removeLast(2)
```
</details>

### Question 3. 
Iterate through the array below. For each each state, print out whether or not it is in the continental United States.

```swift
let moreStates = ["Hawaii", "New Mexico", "Alaska", "Montana", "Texas", "New York", "Florida"]
```

<details>
<summary><b>Solution</b></summary>

```swift
for state in moreStates {
    switch state {
    case state where state == "Hawaii":
        print("\(state) is not a part of the continental United States.")
    case state where state == "Alaska":
        print("\(state) is not a part of the continental United States.")
    default:
        print("\(state) is a part of the continental United States.")
    }
}
```
</details>

### Question 4. 
a) Print out how many non-whitespace characters are in `myString`.

```swift
let myString = "This is practice for the next problem!"
```

<details>
<summary><b>Solution</b></summary>

```swift
var nonWhiteSpaceCharsInString = 0

for char in myString.characters {
    if char != " " {
        nonWhiteSpaceCharsInString += 1
    }
}

print(nonWhiteSpaceCharsInString)
```
</details>

b) Iterate through the array below. For each sentence, print out how many non-whitespace characters are in it.

```swift
let myFavoriteQuotes = ["To be or not to be, that is the question.", "The only source of knowledge is experience.", "Mr. Gorbachev, tear down this wall!", "Four score and twenty years ago..."]
```

<details>
<summary><b>Solution</b></summary>

```swift
for sentence in myFavoriteQuotes {
    var nonWhiteSpaceCharsInQuote = 0
    for char in sentence.characters {
        if char != " " {
            nonWhiteSpaceCharsInQuote += 1
        }
    }
    print(nonWhiteSpaceCharsInQuote)
}
```
</details>

### Question 5. 
The below array represents an unfinished batting lineup for a baseball team. You, the coach, need to make some last minute changes:

* Add "Suzuki" to the end of your lineup.
* Change "Jeter" to "Tejada".
* Change "Thomas" for "Guerrero"
* Put "Reyes" to bat 8th instead.

```swift
var battingLineup = ["Reyes", "Jeter", "Ramirez", "Pujols","Griffey","Thomas","Jones", "Rodriguez"]
```

<details>
<summary><b>Solution</b></summary>

```swift
battingLineup.append("Suzuki") //Add "Suzuki" to the end of your lineup.
battingLineup[1] = "Tejada" //Change "Jeter" to "Tejada".
battingLineup[5] = "Guerrero" //Change "Thomas" to "Guerrero"
let reyes = battingLineup.remove(at: 0) //Put "Reyes" to bat 8th instead. (this and next line)
battingLineup.append(reyes)
print(battingLineup)
```
</details>


### Question 6.
Iterate through `garden` and place any 🌷 that you find into the basket.  Replace any 🌷 that you pick up with "dirt".  Then print how many 🌷 are in your basket.

```swift
var garden = ["dirt","🌷","dirt","🌷","dirt","dirt","🌷","dirt","🌷","dirt"]
var basket = [String]()
```

<details>
<summary><b>Solution</b></summary>

```swift
for item in garden {
    if item == "🌷" {
        basket.append(item)
    }
}

print(basket.count)
```
</details>

###  Question 7. 
Iterate through `listOfNumbers` and print out the largest element.

```swift
var listOfNumbers = [1, 2, 3, 10, 100, 13, 14, 31]
```

<details>
<summary><b>Solution</b></summary>

```swift
var max = Int.min

for num in listOfNumbers {
    if num > max {
        max = num
    }
}

print(max)
```
</details>


### Question 8.
Iterate through `secondListOfNumbers`, and print out all the odd numbers.

```swift
var secondListOfNumbers = [19,13,14,19,101,10000,141,404]
```

<details>
<summary><b>Solution</b></summary>

```swift
for num in secondListOfNumbers {
    if num % 2 != 0  {
        print(num)
    }
}
```
</details>

### Question 9.
Iterate through `thirdListOfNumbers`, and print out the sum.

```swift
var thirdListOfNumbers = [11, 26, 49, 61, 25, 40, 74, 3, 22, 23]
```

<details>
<summary><b>Solution</b></summary>

```swift
var sum = 0

for num in thirdListOfNumbers {
    sum += num
}

print(sum)
```
</details>


### Question 10. 
Iterate through the array and check to see if there is at least one integer that equals target.  Then, print "YES" if you found a match, and "NO" if you didn't.

```swift
let target = 84
var fourthListOfNumbers = [83, 1, 66, 64, 90, 22, 97, 10, 84, 27]
```

<details>
<summary><b>Solution</b></summary>

```swift
for num in fourthListOfNumbers {
    if num == target {
        print("YES")
    } else {
        print("NO")
    }
}
```
</details>


### Question 11.
Append every Int that appears in both `listOne` and `listTwo` to the `sharedElements` array. Then print how many Ints are shared.

```swift
var listOne = [28, 64, 7, 96, 13, 32, 94, 11, 80, 68]
var listTwo = [18, 94, 48, 6, 42, 68, 79, 76, 13, 7]
var sharedElements = [Int]()
```

<details>
<summary><b>Solution</b></summary>

```swift
for numOne in listOne {
    for numTwo in listTwo {
        if numOne == numTwo {
            sharedElements.append(numOne)
        }
    }
}

print(sharedElements.count)
```
</details>



### Question 12.
Write code such that `noDupeList` has all the same Ints as `dupeFriendlyList`, but has no more than one of each Int.

```swift
var dupeFriendlyList = [4,2,6,2,2,6,4,9,2,1]
var noDupeList: [Int] = []
```

<details>
<summary><b>Solution</b></summary>

```swift
for num in dupeFriendlyList {
    if noDupeList.contains(num) {
        continue
    } else {
        noDupeList.append(num)
    }
}

print(noDupeList)
```
</details>

### Question 13.
Find the second smallest Int in `ages`.

```swift
var ages = [53, 31, 88, 65, 25, 44, 77, 18, 24, 84, 46, 42, 50, 28, 78, 67, 83, 70, 38, 69, 66, 71, 68, 61, 86, 85, 41, 15, 81, 40]
```

<details>
<summary><b>Solution</b></summary>

```swift
var smallest = Int.max
var secondSmallest = Int.max

for age in ages {
    if age < smallest {
        secondSmallest = smallest
        smallest = age
    } else if age > smallest && age < secondSmallest {
        secondSmallest = age
    }
}

print(smallest)
print(secondSmallest)
```
</details>


### Question 14.
Print out the sum of the diagonals of `myMatrix`.

```swift
var myMatrix = [[10, 14, 12], [91, 1, 9], [31, 3, 21]]
```

<details>
<summary><b>Solution</b></summary>

```swift
var sum = 0

for i in 0..<myMatrix.count {
    for j in 0..<myMatrix.count {
    }
    sum += myMatrix[i][i]
}

print(sum14)
```

</details>


### Question 15.
Using `for` loops, rotate `myMatrix` 90 degrees.

```swift
var toRotate = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
```

![alt text](https://sharecode.io/assets/problem_images/2518_5.jpg)



<details>
<summary><b>Solution</b></summary>

```swift

```
</details>

### Question 16.
If we list all the natural numbers below 10 that are multiples of 3 or 5, we get 3, 5, 6 and 9. The sum of these multiples is 23.

Find the sum of all the multiples of 3 or 5 below 1000. 

<details>
<summary><b>Solution</b></summary>

```swift
var sum = 0

for i in 1..<1000 {
    if i % 3 == 0 || i % 5 == 0 {
        print(i)
        sumq += i
    }
}

print(sum16)
```
</details>

### Question 17.
Print the first element that repeats in `someRepeats`.

```swift
var someRepeats = [25,11,30,31,50,28,4,37,13,20,24,38,28,14,44,33,7,43,39,35,36,42,1,40,7,14,23,46,21,39,11,42,12,38,41,48,20,23,29,24,50,41,38,23,11,30,50,13,13,16,10,8,3,43,10,20,28,39,24,36,21,13,40,25,37,39,31,4,46,20,38,2,7,11,11,41,45,9,49,31,38,23,41,16,49,29,14,6,6,11,5,39,13,17,43,1,1,15,25]
```

<details>
<summary><b>Solution</b></summary>

```swift
var elementIsRepeated = false
var dupes: [Int] = []

for elem in someRepeats {
    if dupes.contains(elem) {
        elementIsRepeated = true
        if elementIsRepeated {
            print(elem)
            break
        }
    } else {
        dupes.append(elem)
    }
}
```
</details>

### Question 18.
Make an array that contains all elements that appear more than twice in `someRepeatsAgain`.

```swift
var someRepeatsAgain = [25,11,30,31,50,28,4,37,13,20,24,38,28,14,44,33,7,43,39,35,36,42,1,40,7,14,23,46,21,39,11,42,12,38,41,48,20,23,29,24,50,41,38,23,11,30,50,13,13,16,10,8,3,43,10,20,28,39,24,36,21,13,40,25,37,39,31,4,46,20,38,2,7,11,11,41,45,9,49,31,38,23,41,16,49,29,14,6,6,11,5,39,13,17,43,1,1,15,25]
```

<details>
<summary><b>Solution</b></summary>

```swift
var arrayMoreThanTwice = [Int]()
var arrayOnce = [Int]()
var arrayTwice = [Int]()

for elem in someRepeatsAgain {
    if arrayMoreThanTwice.contains(elem) {
        continue
    } else if arrayTwice.contains(elem) {
        arrayMoreThanTwice.append(elem)
    } else if arrayOnce.contains(elem) {
        arrayTwice.append(elem)
    } else {
        arrayOnce.append(elem)
    }
}
```
</details>

### Question 19.
Identify if there are 3 integers in the following array that sum to 10. If so, print them. If there are multiple triplets, print all possible triplets.

```swift
var tripleSumArr = [-20,-14, -8,-5,-3,-2,1,2,3,4,9,15,20,30]
```

<details>
<summary><b>Solution</b></summary>

```swift
for x in 0..<tripleSumArr.count {
    for y in (x+1)..<tripleSumArr.count {
        for z in (y+1)..<tripleSumArr.count {
            if tripleSumArr[x] + tripleSumArr[y] + tripleSumArr[z] == 10 {
                let sum = tripleSumArr[x] + tripleSumArr[y] + tripleSumArr[z]
            
                print("\(tripleSumArr[x]) + \(tripleSumArr[y]) + \(tripleSumArr[z]) = \(sum)")
            }
        }
    }
}

// More efficient solution:

/*
 1) First, we check to see if the current triplet adds up to 10.
 
 2) We will move all the pointers over one at a time, starting with the one closest to the right. 
 When it reaches the end, we increment the second pointer over and reset the last one to be next 
 to the second.
 
 3) If the second pointer reaches the last pointer, we'll increment the first pointer over and 
 reset the positions of the other two back to the beginning, next to the right side of the first.
 
 4) When the pointers can't be moved any further without overlapping (i.e., when all 3 pointers 
 will be stacked on the right), then we should end the loop
 */

 while x < tripleSumArr.count - 2 {
    
    // 1
    if tripleSumArr[x] + tripleSumArr[y] + tripleSumArr[z] == 10 {
        let whileSum = tripleSumArr[x] + tripleSumArr[y] + tripleSumArr[z]
        
        print("\(tripleSumArr[x]) + \(tripleSumArr[y]) + \(tripleSumArr[z]) = \(whileSum)")
    }
    
    // 2
    z += 1
    
    if z > tripleSumArr.count - 1 {
        y += 1
        z = y + 1
        
        // 3
        if y > tripleSumArr.count - 2 {
            x += 1
            y = x + 1
            z = y + 1
        }
    }
}



```
</details>



### MAKE SOLUTIONS A SEPARATE FILE
### Loop Exercises
---

### Section 1: Printing
For each prompt below, write a for loop that prints out the specified information:

#### Question 1. 
All the numbers from 1 to 150 inclusive

<details>
<summary><b>Solution</b></summary>

```swift
for num in 1...150 {
    print(num)
}
```

</details>

#### Question 2. 
All the numbers from 142 to 159 exclusive

<details>
<summary><b>Solution</b></summary>

```swift
for num in 142..<159 {
    print(num)
}
```

</details>

#### Question 3.
Only the even numbers from 15 to 80 inclusive

<details>
<summary><b>Solution</b></summary>

```swift
for num in 15...80 where num % 2 == 0 {
    print(num)
}
```

</details>

#### Question 4. 
Only the odd numbers from 19 to 51 inclusive

<details>
<summary><b>Solution</b></summary>

```swift
for num in 19...51 where num % 2 != 0 {
    print(num)
}
```

</details>

#### Question 5.
All the numbers that end in a 5 from 1 to 100 exclusive

<details>
<summary><b>Solution</b></summary>

```swift
for num in 1..<100 where num % 10 == 5 {
    print(num)
}
```

</details>

#### Question 6. 
All the numbers that end in a 7 from 1 to 40 inclusive

<details>
<summary><b>Solution</b></summary>

```swift
for num in 1...40 where num % 10 == 7 {
    print(num)
}
```

</details>

---

### Section 2: Printing with Conditions
Given a range of numbers from 20 to 150 print out all the numbers that follows these conditions:

#### Question 7. 
Numbers that are divisible by 3

<details>
<summary><b>Solution</b></summary>

```swift
for num in 20...150 where num % 3 == 0 {
    print(num)
}
```

</details>

#### Question 8.
Numbers that are divisible by 2 and 3

<details>
<summary><b>Solution</b></summary>

```swift
for num in 20...150 where num % 3 == 0 || num % 2 == 0 {
    print(num)
}
```

</details>

#### Question 9.
Unit digit ends with 4

<details>
<summary><b>Solution</b></summary>

```swift
for num in 20...150 where num % 10 == 4  {
    print(num)
}
```

</details>

#### Question 10.
Print out numbers: 31, 35, 40 to 60.

<details>
<summary><b>Solution</b></summary>

```swift
for num in 20...150  {
    switch num{
    case 31:
        print(num)
    case 35:
        print(num)
    case 40...60:
        print(num)
    default:
        continue
    }
}
```

</details>

---

### Section 3. While Loops (NO Xcode)

*Questions 11 - 14 refer to the following snippet:*

```swift
var i = 5

while (i > 3) {
  i += 1
}
```

#### Question 11.
How many times does the while loop execute? 

<details>
<summary><b>Solution</b></summary>

>The while loop above will execute indefinitely because it is an infinite loop. The condition in the while loop will always be true because `i` is set at a value that is already greater than three.

</details>

#### Question 12.
How do you stop the loop when i reaches 9?

<details>
<summary><b>Solution</b></summary>

>In order to stop the loop when it reaches 9, we must first set the condition to check if `i` ___is less than 9___. If we set the condition to see whether `i` is less than _or equal to 9_, we will actually stop at 10. The reason for this is because `i` is incremented each time the condition is true. Since 9 <= 9 == true, `i` will be incremented to 10 if we include the equal sign in the condition, but 9 < 9 == false allowing `i` to be frozen at 9.

```swift
while (i < 9) { //not (i <= 9)
    i += 1
}
```

</details>

#### Question 13.
How would you fix the while loop so that it will only execute 1,000 times?

<details>
<summary><b>Solution</b></summary>

```swift
while (i < 1005) {
    i += 1
}
```

</details>

#### Question 14.
Once the loop can run 1,000 times, print out ONLY the even numbers. 

<details>
<summary><b>Solution</b></summary>

```swift
while (i < 1005) {
    i += 1
    if i % 2 == 0 {
        print(i)
    }
}
```

</details>

#### Question 15.
What's the difference between the following two while loops?

```swift
var i = 1

while i <= 10 {
    print("i = \(i)")
    i += 1
}
```

```swift
var i = 1

repeat {
   print("i = \(i)")
   i += 1
} while i <= 10
```

<details>
<summary><b>Solution</b></summary>

>In the first snippet, the condition of the while loop is evaluated before code block is run. While in the second snippet the condition is evaluated after the code block has been executed at least once. There is a chance that the first while loop will never get executed, but the second loop is guarenteed to run at least one time. 


</details>

#### Question 16. 
If there's a difference in the loops from the previous question, how would you fix it so that both outputs are the same?

<details>
<summary><b>Solution</b></summary>

> The output from both while loops are equivalent.

</details>

---

### Section 4. Short Answer Questions (No Xcode)

#### Question 17.
What's the difference between break vs continue?

<details>
<summary><b>Solution</b></summary>

> Using `break` in a loop stops the execution of the loop completely. Using `continue` stops the current iteration of the loop without exiting the loop as a whole, skipping the remaining statements within the body of the loop.

</details>

#### Question 18.
Without using Xcode explain the result of the following for-in loops.
18a:
```swift
for i in 1...10 {
    if (i >= 4 && i <= 7){
        continue
    }
    print(i)
}
```

<details>
<summary><b>Solution</b></summary>

> This loop iterates through the numbers 1 - 10 (inclusive), and prints every number EXCEPT 4, 5, 6, 7

```swift
//Expected Output:
1
2
3
8
9
10
```
</details>

18b:
```swift
for i in 1...10 {
    if (i >=4 && i <= 7){
        break
    }
    print(i)
}
```

<details>
<summary><b>Solution</b></summary>

> This loop iterates through the numbers 1 - 10 (inclusive), and stops iterating when `i` becomes 4.

```swift
// Expected Output
1
2
3
```
</details>

Bonus:
```swift
outerloop: for x in 1...3 {
    innerloop: for y in 1...3 {
        if y == 2{
            continue outerloop
        }
        print("x = \(x), y = \(y)")
    }
}
```

<details>
<summary><b>Solution</b></summary>

Bonus.
>The first loop iterates through the numbers 1 - 3. For every time `x` is incremented by the outerloop, the innerloop prints to the console the values of `x` and `y`. If the `if` statement were not there, `y` would be incremented all the way to the upperbound (3) before x is incremented. But because of the `if`statement, once `y` reaches 2 the print statement in the innerloop is not executed and the outerloop resumes immediately. The result is that `y` stays at 1 while `x` is able to reach the upperbound of its range.

```swift
//Expected Output:
x = 1, y = 1
x = 2, y = 1
x = 3, y = 1
```


</details>

---

### Section 5: Nested loops
#### Question 19.
Write code that prints out all the points in the area bounded by (0,0), (10,0), (0,10) and (10,10) where x and y are both integers.

<details>
<summary><b>Solution</b></summary>

```swift
for x in (0...10).reversed() {
    for y in 0...10 {
        print("(\(x),\(y))", terminator: " ")
    }
    print()
}
```

</details>

#### Question 20.
Write code that prints out all the points in the area bounded by (0,0), (10,0), (0,10) and (10,10) where x and y are both even numbers.

<details>
<summary><b>Solution</b></summary>

```swift
for x in (0...10).reversed() {
    for y in 0...10 {
        if x % 2 == 0 && y % 2 == 0 {
            print("(\(x),\(y))", terminator: " ")
        }
    }
    print()
}
```

</details>

#### Question 21.
Write code that prints out all the points in the area bounded by (0,0), (10,0), (0,10) and (10,10) where the difference of x and y is at least 5, and x and y are both integers.

<details>
<summary><b>Solution</b></summary>

```swift
for x in (0...10).reversed() {
    for y in 0...10 {
        if x - y >= 5 {
            print("(\(x),\(y))", terminator: " ")
        }
    }
    print()
}
```

</details>

#### Question 22.
Write code that prints out all the points in the area bounded by (0,0), (10,0), (0,10) and (10,10) where the product of x and y is less than 6, and x and y are both integers.

<details>
<summary><b>Solution</b></summary>

```swift
for x in (0...10).reversed() {
    for y in 0...10 {
        if x * y < 6 {
            print("(\(x),\(y))", terminator: " ")
        }
    }
    print()
}
```

</details>

#### Question 23. 
Write code that prints out all the points in the area bounded by (0,0), (10,0), (0,10) and (10,10) where the x is not equal to y and x and y are both integers.

<details>
<summary><b>Solution</b></summary>

```swift
for x in (0...10).reversed() {
    for y in 0...10 {
        if x != y {
            print("(\(x),\(y))", terminator: " ")
        }
    }
    print()
}
```

</details>

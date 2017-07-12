### Conditionals Exercises
#### Do these without a Playground
---

#### Exercise 1a. 
What will following code print?

```swift
let numberOne = 5
let numberTwo = 3
if numberOne > numberTwo {
   print("numberOne is bigger")
}
else if numberTwo > numberOne {
   print("numberTwo is bigger")
}
print("All done!")
```

<details>
<summary><b>Solution</b></summary>

```
numberOne is bigger
All done!
```

</details>

#### Exercise 1b. 
What would be printed if numberOne == numberTwo?

<details>
<summary><b>Solution</b></summary>

```
All done!
```

</details>

#### Exercise 2. 
What is the final value of happyTimes?

```swift
let happyTimes: Int
if 3 < 2 || !true {
   happyTimes = 1
} 
else if 5 + 3 * 2 == 11 {
   happyTimes = 2
} 
else {
   happyTimes = 3
}
```

<details>
<summary><b>Solution</b></summary>

```
2
```

</details>

#### Exercise 3. 
Complete the following code so that "You win!" is printed
```swift
if {
   print("You win!")
} 
else {
   print("You lose!")
}
```

<details>
<summary><b>Solution</b></summary>

```swift
if true {
   print("You win!")
} 
else {
   print("You lose!")
}
```

</details>


#### Exercise 4. 
Complete the following code so that users can only enter if their age is 18 or older.
```swift
let votingAge = 18
let userAge = 13
if { 
   print("You can enter!")
} 
else {
   //What could we print here?
}
```

<details>
<summary><b>Solution</b></summary>

```swift
let votingAge = 18
let userAge = 13
if userAge >= votingAge { 
   print("You can enter!")
} 
else {
    print("None (under \(votingAge)) shall pass!")
}
```

</details>

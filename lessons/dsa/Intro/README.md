# Data Structures and Algorithms

## Objectives:

- What is a data structure?
- What is an algorithm?
- Why are we learning about them?

## Data Structures
A **data structure** is a way of storing and organizing data.

We already have some exposure to using data structures in Swift.  What some examples of data structures?

<details>
	<summary>Example One</summary>
	Dictionary
</details>

<details>
	<summary>Example Two</summary>
	Array
</details>	

<details>
	<summary>Example Three</summary>
	Set
</details>

<details>
	<summary>Example Four</summary>
	Enums, Structs, and Classes
</details>	


Over the course of our class, we will discuss several other data structures including:

 - Linked Lisks
 - Stacks
 - Queues
 - Trees
 - Graphs

## What's the point of using data structures?

If we want to use and access data, we need a way to store it.  Data structures help us answer questions like:

- How would you organize data about an individual's friend network on Facebook?
- How would you implement the back button in a web browser?
- How would you store the taxonomy of several different species?

An understanding of data structures will enable you to write readable, efficient and exentendible code.

Additionally, our programs can be faster or slower depending on how we store and access information.  There is a huge difference between something taking .1 seconds and 1 second!  Knowing which data structures to use can make a huge difference for end users of your app.

## Algorithms

An **algorithm** is a set of step-by-step operations that accomplishes a task.

Here's an example of an algorithm:

```
"Take a slice of bread"
"Put peanut butter on the slice"
"Take a second slice of bread"
"Put jelly on that slice"
"Press the slices of bread together"
```

While people are able to use contextual clues, computers need explicit directions with no ambiguity.

Here is a common algorithm called "FizzBuzz"

```
1. Count from 1 to 100 according to the following rules
2. If the current number is divisible by 3, write "Fizz".
3. If the current number is divisible by 5, write "Buzz".
4. If the current number is divisible by 3 and 5, write "FizzBuzz".
5. Otherwise, write the current number.
```

### Practice:  Write FizzBuzz in Swift

<details>
	<summary>One solution</summary>
	
	for i in 1...100 {
		switch i {
			case _ where i % 15 == 0:
				print("FizzBuzz")
			case _ where i % 3 == 0:
				print("Fizz")
			case _ where i % 5 == 0:
				print("Buzz")
			default:
				print(i)	
		}
	}

</details>

Your solution might look totally diffferent.  There are an infinite amount of ways to solve this problem.   Here's another solution:

<details>
	<summary>Another solution</summary>
	
	if i == 1 { print("1") }
	if i == 2 { print("2") }
	if i == 3 { print("Fizz") }
	if i == 4 { print("4") }
	if i == 5 { print("Buzz") }
	if i == 6 { print("Fizz") }
	if i == 7 { print("7") }
	if i == 8 { print("8") }
	if i == 9 { print("Fizz") }
	if i == 10 { print("Buzz") }
	if i == 11 { print("11") }
	if i == 12 { print("Fizz") }
	if i == 13 { print("13") }
	if i == 14 { print("14") }
	if i == 15 { print("FizzBuzz") }
	if i == 16 { print("16") }
	if i == 17 { print("17") }
	if i == 18 { print("Fizz") }
	if i == 19 { print("19") }
	if i == 20 { print("Buzz") }
	if i == 21 { print("Fizz") }
	if i == 22 { print("22") }
	if i == 23 { print("23") }
	if i == 24 { print("Fizz") }
	if i == 25 { print("Buzz") }
	if i == 26 { print("26") }
	if i == 27 { print("Fizz") }
	if i == 28 { print("28") }
	if i == 29 { print("29") }
	if i == 30 { print("FizzBuzz") }
	if i == 31 { print("31") }
	if i == 32 { print("32") }
	if i == 33 { print("Fizz") }
	if i == 34 { print("34") }
	if i == 35 { print("Buzz") }
	if i == 36 { print("Fizz") }
	if i == 37 { print("37") }
	if i == 38 { print("38") }
	if i == 39 { print("Fizz") }
	if i == 40 { print("Buzz") }
	if i == 41 { print("41") }
	if i == 42 { print("Fizz") }
	if i == 43 { print("43") }
	if i == 44 { print("44") }
	if i == 45 { print("FizzBuzz") }
	if i == 46 { print("46") }
	if i == 47 { print("47") }
	if i == 48 { print("Fizz") }
	if i == 49 { print("49") }
	if i == 50 { print("Buzz") }
	if i == 51 { print("Fizz") }
	if i == 52 { print("52") }
	if i == 53 { print("53") }
	if i == 54 { print("Fizz") }
	if i == 55 { print("Buzz") }
	if i == 56 { print("56") }
	if i == 57 { print("Fizz") }
	if i == 58 { print("58") }
	if i == 59 { print("59") }
	if i == 60 { print("FizzBuzz") }
	if i == 61 { print("61") }
	if i == 62 { print("62") }
	if i == 63 { print("Fizz") }
	if i == 64 { print("64") }
	if i == 65 { print("Buzz") }
	if i == 66 { print("Fizz") }
	if i == 67 { print("67") }
	if i == 68 { print("68") }
	if i == 69 { print("Fizz") }
	if i == 70 { print("Buzz") }
	if i == 71 { print("71") }
	if i == 72 { print("Fizz") }
	if i == 73 { print("73") }
	if i == 74 { print("74") }
	if i == 75 { print("FizzBuzz") }
	if i == 76 { print("76") }
	if i == 77 { print("77") }
	if i == 78 { print("Fizz") }
	if i == 79 { print("79") }
	if i == 80 { print("Buzz") }
	if i == 81 { print("Fizz") }
	if i == 82 { print("82") }
	if i == 83 { print("83") }
	if i == 84 { print("Fizz") }
	if i == 85 { print("Buzz") }
	if i == 86 { print("86") }
	if i == 87 { print("Fizz") }
	if i == 88 { print("88") }
	if i == 89 { print("89") }
	if i == 90 { print("FizzBuzz") }
	if i == 91 { print("91") }
	if i == 92 { print("92") }
	if i == 93 { print("Fizz") }
	if i == 94 { print("94") }
	if i == 95 { print("Buzz") }
	if i == 96 { print("Fizz") }
	if i == 97 { print("97") }
	if i == 98 { print("98") }
	if i == 99 { print("Fizz") }
	if i == 100 { print("Buzz") }

</details>

### Discussion:
- Why is the first solution better than the second one?

## Why is any of this important?
1. It will make you a better programmer
2. It will enable you to pass technical interviews
3. It's interesting!


## Technical Interviews:
Answering technical questions is a necessary part of a technical interview.  Technical questions come in several different forms.

1. iOS/App development Specific topics
  - Explain the life cycle of UIViewController
  - What is MVC design?
  - What is the class hierarchy for a UIButton?

2. Pair programming
 - Live code an app with your interviewer
 - Debug code that is presented to you

3. Take home coding projects:
 - Build an app that recreates the core features of Yelp

4. Livecoding / Whiteboarding Data Structures and Algorithms questions
 - Write an algorithm that returns the second smallest integer in an array of Ints
 - Which data structure would you use to model 

 
## How to solve algorithms 
1. Clarify the problem (if necessary)
2. What are the inputs?
3. What are the outputs?
4. Explain a possible solution
5. Code the solution
6. Test the solution

Example:

**Write a function that returns the sum of all the even numbers in an Array of Ints.**

<details>
	<summary> 1. Clarify the problem</summary>
	
	Is zero even or odd?
	Can negative numbers be even?
	
</details>

<details>
	<summary> 2. What are the inputs?</summary>
	
	An array of Ints as an [Int]
	
</details>	

<details>
	<summary> 3. What are the outputs?</summary>
	
	The sum of the even numbers as an Int.
	
</details>	

<details>
	<summary> 4. Explain a possible solution</summary>
	
	- Initialize a variable Int called "sum" and set sum equal to zero
	- Iterate through the array of Ints
	- Check each Int if even by checking if the Int is divisible by two
	- If the Int is divisible by two, increment sum by the number
	- Return sum after you check each Int
	
</details>	

<details>
	<summary> 5. Code the solution </summary>
	
	func sumAllEven(arr: [Int]) -> Int {
		var sum = 0
		for num in arr {
			if num % 2 == 0 {
				sum += num
			}
		}
		return sum
	}
</details>	

<details>
	<summary> 6. Test the solution </summary>
	
	input: [2,5,7,6]
	output: 8
	
</details>


**You try**: Rewrite the function using higher ordered functions


### **Practice Problem One**

**Write a function that returns how many vowels are in a String**

*Sample Input*: "Hello there!  How's it going?"

*Sample Output*: 8



### **Practice Problem Two**

**Write a function that returns the product of an array of Ints with any zeros taken out**

*Sample Input*: [4,0,8,3,0]

*Sample Output*: 96


### **Practice Problem Three**

**Write a function that multiplies the corresponding elements in two [Int]s of the same size.  Two elements are corresponding if their indicies are the same.**

[Problem link](https://www.codeeval.com/open_challenges/113/)

*Sample input*: [9, 0, 6]  [15, 14, 9]

*Sample output*: [135, 0, 54]

### For Later

## Homework
Your homework will be several more algorithm solving questions.  This homework is due before class **tomorrow** Oct. 18th.  These homework assignments will be checked for completion.  You will use the testing suite in XCode to get immediate feedback if your algorithms are successful.

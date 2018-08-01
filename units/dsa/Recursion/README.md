# Recursion

## Objectives

1. Write recursive functions to solve problems
2. Use dynamic programming to improve runtime efficiency

## Resources


# What is Recursion?
In computer science, recursion basically means a function that calls itself. Recursion can be a little mind bending at first but is actually relatively simple: it's basically just another way to create loops.

In fact, anything that can be done iteratively with a `for` loop or `while` loop can also be solved with recursion, and vice versa. There are some languages (like [Haskell](https://www.haskell.org/)) that do not even have iterative `for`loops or `while` loops at all, and use recursion for all looping instead!

Recursion is often used in functional programming. Mastering recursion can help you do some magical things in code.

Let's dive in.

# How to Use Recursion

A recursive function consists of two things:

1. A recursive call
2. A base case

## The Recursive Call
A recursive function is a function that calls iteself.

```swift
func recurse() {
	print("hi")
	recurse()
}
```
recurse() is a recursive function.  It will print "hi", then call itself, which will print "hi" and then call itself, which will print "hi" and then call itself, and so on.  

<details>
<summary>Recursive Patrick</summary>

![recursive patrick](https://media.giphy.com/media/xlTwaFb20TVjW/giphy.gif)
</details>

<br>
How can we stop this process and have it do something more useful?

## The Base Case
The most important part of any recursive function is the 'base case'. The base case is basically a conditional that tells the function to stop calling itself (the base case is usually just a simple `if` statement):


The function should NOT call itself within the base case. In other words, the base case `if` statement should do the very last thing the function does before ending.

Here's another example of a recursive function without a base case:

```swift
func countDownToZero(from num: Int) {
    print(num)
    countDown(from: num - 1)
}
```



<details>
<summary> When do want this function to stop running? </summary>
        When num is zero
</details>

Let's add that base case:

```swift
func countDownToZero(from currentNum: Int) {
    if currentNum == 0 {
        return
    }
    print(currentNum)
    countDownToZero(from: currentNum - 1)
}
```
Make sure your recursive functions always have a base case!

#### Handling edge cases.

Even though we added a base case to our countDownToZero function above, it still has the possibility to run forever.

<details>
<summary> For what input to countDownToZero(from:) will run forever?</summary>
If the input is less than zero.
</details>

<details>
<summary>How can we resole this issue</summary>

```swift
func countDownToZero(from currentNum: Int) {
    if currentNum <= 0 {
        return
    }
    print(currentNum)
    countDownToZero(from: currentNum - 1)
}
```
</details>

<details>
<summary>Recursive Triangle</summary>
![recursive triangle](http://i.stack.imgur.com/HAEZW.gif)
</details>



## Practice problem 1

Write a function that counts up to a target number.

```swift
func countUp(to target: Int, startingAt currentNum: Int) {
}
```

## Recursive vs Iterative Loops
We just saw an example of how to write a loop recursively. 

We could have done that iteratively pretty easily:

```swift
func countUp(to target: Int, startingAt currentNun: Int) {
   for i in currentNum..<target {
      print(i)
   }
}
```

Anything that we can solve iteratively, we can solve recurseively and vice versa. 

This leads to a natural question.  If recursion looks more confusing, why would we ever want to use it solve problems?

# When to use recursion
In general, you should only use recursion if it would be significantly simpler than the iterative solution. A good rule of thumb is to use recursion when it helps makes your code more readable. In most cases iterative solutions are preferable over recursive solutions because recursion has some added performance costs, like extra function calls.




## Factorial


One simple example of how to practically use recursion is with the factorial algorithm.

*Factorial* (symbol: "!") means to multiply a integer by every integer before it.

```
Example: 5! = 5 * 4 * 3 * 2 * 1 = 120
```

Let's made an iterative solution first, then let's compare it to a recursive solution:

<details>
<summary> Iterative factorial </summary>
func factorial(n: Int) -> Int {
    var product = 1
    for currentNum in 1...n {
        product *= currentNum
    }
    return product
}

func fancyFactorial(n: Int) -> Int {
    return (1...n).reduce(1, *)
}
</details>


<details>
<summary> Recursive Factorial </summary>

```swift
func recursiveFactorial(n: Int) -> Int {
    guard n > 1 else {return 1} //Base Case
    return n * recursiveFactorial(n: n - 1) //Recursive Call
}
```

</details>




## Fibonacci


A common, real world example of when to use recursion is the Fibonacci sequence. Here is an iterative solution for finding the nth number of a Fibonacci sequence:

The Fibonacci sequence is made by adding the two previous numbers together:

0, 1, 1, 2, 3, 5, 8, 13, 21, 34 ...

Let's made an iterative solution first, then let's compare it to a recursive solution:


<details>
<summary> Iterative Fibonacci </summary>

```swift
func iterFib(upTo elements: Int) {
    guard elements != 0 else {return}
    guard elements > 1 else {print(1); return}
    print(1,1,separator: "\n")
    var firstNum: Int = 1
    var secondNum: Int = 1
    for _ in 0..<elements - 2 {
        print(firstNum + secondNum)
        let temp = secondNum
        secondNum = firstNum + secondNum
        firstNum = temp
    }
}
```
</details>


<details> 
<summary> Recursive Fibonacci </summary>

```swift
func recursiveFib(n: Int) -> Int {
    guard n > 1 else { return 1 }
    return recursiveFib(n: n - 1) + recursiveFib(n: n - 2)
}
```

</details>

The advantage of recursive solutions is that they can be much easier to understand.  This code is very dense, so we should take a look at what it's doing.

<details>
<summary> Visual Representation </summary>

![Fib](http://www.introprogramming.info/wp-content/uploads/2013/07/clip_image00525.png)

</details>


<details>
<summary> With stick figures </summary>

![Fib](https://i.stack.imgur.com/6hD41.png)

</details>


<details>

<summary> What might be a downside of using this method? </summary>

It's very slow!  We have to do a lot of the same work over again.

</details>



## Dynamic Programming and Memoization

**Memoization** is the process of storing (taking a memo) information that might be useful again.  For example, say you have a function that does some complicated calculations:

```swift
func isPrime(n: Int) -> Bool {
    for possibleFactor in 2...Int(sqrt(Double(n))) {
        if n % possibleFactor == 0 {
            return false
        }
    }
    return true
}
```

For large ints, this might take a while to run.  If we have already found a prime number, we probably don't want to have to repeat that work.  We can use memoization to make our work more efficient (at the cost of additional space).

```swift
var primeDict = [Int: Bool]()

func isPrime(n: Int) -> Bool {
    if let nIsPrime = primeDict[n] {
        return nIsPrime
    }
    for possibleFactor in 2...Int(sqrt(Double(n))) {
        if n % possibleFactor == 0 {
            primeDict[n] = false
            return false
        }
    }
    primeDict[n] = true
    return true
}
```

**Dynamic Programming** is the combination of **Memoization** and **recursion**.  We can work memoization into our recursive Fibonacci to improve the runtime.

```swift
var fibValues = [Int: Int]()

func recursiveFibDynamicProgramming(n: Int) -> Int {
    guard n > 1 else { return 1 }
    let nthFibNumber = recursiveFibDynamicProgramming(n: n - 1) + recursiveFibDynamicProgramming(n: n - 2)
    fibValues[n] = nthFibNumber
    return nthFibNumber
}
```



# Other tips

## Calculating Big O of Recursive Functions
In iterative loops, we count the number of loops in order to figure out the Big O complexity. Similarly, with recursion, we count the number of times the function is being called.


## Recursive State
In recursive functions, state is passed down through arguments. In other words, you should generally not save variables within your recursive functions. Instead, if you want to keep track of any data, you should pass them down through arguments. In this way the function's arguments basically keep a history of the state of the function. This makes recursive functions immutable, which is one of their advantages.



# Exercises:


1. Find the factorial of a given number (review)

	```
	Factorial definition:
	
	5 factorial = 5! = 5 * 4 * 3 * 2 * 1 = 120
	```

2. Print out all elements in an array recursively

3. Concatenate all the elements in an array of Strings

	```
	Sample Input: ["Hi", "there", ",", " ", "user","!"]
		
	Sample Output: "Hi there, user!"
	```

4. Find the sum of all the numbers in an array

	```
	Sample Input: [3,6,1,3,2]
	
	Sample Output: 15
	```

5. Find the sum of all the even numbers in an array

	```
	Sample Input: [3,6,1,3,2]
	
	Sample Output: 8
	```


6. Multiply two given Ints.  Do not use for/while loops or the * operator.

	```
	Sample Input: 5 * 6
	
	Sample Output: 30
	```

7. Write a recursive function pow that takes two numbers x and y as input and returns x to the power y.  Do not use for/while loops

	```
	Sample Input: 3 ^ 4
	
	Sample Output: 81
	```

8. Reverse a string using recursion

	```
	Sample input: "Hello, World!"
	
	Sample output: "!dlroW ,olleH"
	```
	
9. Count Spaces in A String

	```
	Sample input: "This is a string that I have written : ) "
	
	Sample output: 10
	```
10. Find Last Occurrence of Character in String

	```
	Sample input: "The powerful programming language that is also easy to learn. Swift is a powerful and intuitive programming language for macOS, iOS, watchOS and tvOS.", "a"
	Sample output: 142
	```

11. Write a recursive function harmonicSum(n:) that returns the sum of the first n numbers of the harmoinc series defined below.

	```
	[Harmonic series](https://en.wikipedia.org/wiki/Harmonic_series_(mathematics)) : 1 + 1/2 + 1/3 + 1/4 + 1/5 + ... + 1/n-1 + 1/n
	
	Sample Input: 3
	
	Sample Output: 1.83
	```
	
12. Write a recursive function geometric Sum(n:) that returns the sum of the first n numbers of the geometric series defined below.

	```
	[Geometric series](https://en.wikipedia.org/wiki/Geometric_series) : 1/2 + 1/4 + 1/8 + ... + 1/(2^n)
	
	```
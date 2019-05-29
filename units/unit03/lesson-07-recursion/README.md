# Recursion

## Objectives

1. Write recursive functions to solve problems
2. Use dynamic programming to improve runtime efficiency

## Resources


# What is Recursion?
In computer science, recursion basically means a function that calls itself. Recursion can be a little mind bending at first but is actually relatively simple: it's basically just another way to create loops.

In fact, anything that can be done iteratively with a `for` loop or `while` loop can also be solved with recursion, and vice versa. There are some languages (like [Haskell](https://www.haskell.org/)) that do not even have iterative `for`loops or `while` loops at all, and use recursion for all looping instead!

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
<summary> When do we want this function to stop running? </summary>
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
   for i in currentNum...target {
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

Let's make an iterative solution first, then let's compare it to a recursive solution:

<details>
<summary> Iterative factorial </summary>
func factorial(n: Int) -> Int {
    var product = 1
    for currentNum in 1...n {
        product *= currentNum
    }
    return product
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


A common, real world example of when to use recursion is the Fibonacci sequence. Here is the recursive solution for finding the nth number of a Fibonacci sequence:

The [Fibonacci sequence](https://en.wikipedia.org/wiki/Fibonacci_number) is made by adding the two previous numbers together:

1, 1, 2, 3, 5, 8, 13, 21, 34 ... 

<details> 
<summary> Recursive Fibonacci </summary>

```swift
func recursiveFib(n: Int) -> Int {
    guard n > 2 else { return 1 }
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

**Memoization**    
In computing, memoization is an optimization technique used primarily to speed up computer programs by _storing the results of expensive function calls and returning the cached result_ when the same inputs occur again.

**Dynamic Programming** is the combination of **Memoization** and **recursion**.  We can work memoization into our recursive Fibonacci to improve the runtime.

```swift
var fibValues = [Int: Int]()
func recursiveFibDynamicProgramming(num: Int) -> Int {
  if let fibonacci = fibValues[num] {
    return fibonacci
  }

  guard num > 1 else {
    fibValues[num] = num
    return 1
  }

  let fibonacci = recursiveFibDynamicProgramming(num: num - 1) + recursiveFibDynamicProgramming(num: num - 2)
  fibValues[num] = fibonacci
  return fibonacci // 19 times
}
```



# Other tips

## Calculating Big O of Recursive Functions
In iterative loops, we count the number of loops in order to figure out the Big O complexity. Similarly, with recursion, we count the number of times the function is being called.


## Recursive State
In recursive functions, state is passed down through arguments. In other words, you should generally not save variables within your recursive functions. Instead, if you want to keep track of any data, you should pass them down through arguments. In this way the function's arguments basically keep a history of the state of the function. This makes recursive functions immutable, which is one of their advantages.

**Pair Programming exercises**   
[Recursion Exercises](https://github.com/joinpursuit/Pursuit-Core-iOS/blob/master/units/unit03/whiteboarding/Recursion-Exercises.md)  

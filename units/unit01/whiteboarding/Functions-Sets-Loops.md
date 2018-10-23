## Whiteboarding - Functions, Collection Types 

1.  Write a function checkNums(num1,num2) take both parameters being passed and return the string true if num2 is greater than num1, otherwise return the string false. If the parameter values are equal to each other then return the string -1. 

>Input:3 & num2 = 122  
>Output:"true"  
>
>Input:67 & num2 = 67   
>Output:"-1"   

</br>

2. You are given an array of integers. The frequency of a number is the number of times it appears in the array. Find out the frequency of each one. Print the numbers in ascending order followed by their frequency.

```swift
var numbers = [1, 2, 3, 2, 3, 5, 2, 1, 3, 4, 2, 2, 2]
```

</br>


3. Print the most common letter in the string below:

```swift 
var myString = "We're flooding people with information. We need to feed it through a processor. 
                A human must turn information into intelligence or knowledge. We've tended to forget 
                that no computer will ever ask a new question."
```

</br>


4. Write a function that takes an Int and returns it’s last digit. Name the function lastDigit. Use _ to ignore the external parameter name.

```swift 
// function definition
func lastDigit(_ number: Int) -> Int

// example: lastDigit(12345)
// output: 5 
```

</br>


5. Implement a function named repeatPrint that takes a string message and a integer count as parameters. The function should print the message count times and then print a newline.

```swift 
// function call 
// repeatPrint(message: "+", count: 10)

// output: ++++++++++
```

</br>


6. Write a function named first that takes an Int named n and returns an array with the first n numbers starting from 1.

```swift 
// function definition
func first(_ n: Int) -> [Int]

// example: first(3)

// output: [1, 2, 3]
```

</br>


7. Write a function that prints the numbers from 1 to x, except:

If the number if a multiple of 3, print "Fizz" instead of the number
If the number is a multiple of 5, print "Buzz" instead of the number
If the number is a multiple of 3 AND 5, print "FizzBuzz" instead of the number
Your function should take in one parameter: x (the number to count up to)

</br>

8. Write a function named reverse that takes an array of integers named numbers as a parameter. The function should return an array with the numbers from numbers in reverse order.

```swift 
// function call: 
reverse([1, 2, 3])

// output: [3, 2, 1]
```

</br>


9. Write a function that sums all the even indices of an array of Ints.

</br>

10. Write a function called filterOdd that takes an array of ints and returns it with just the even numbers.

```swift
// example: filterOdd(arr: [1, 2, 3, 4, 5, 6, 7, 8])

// output: [2, 4, 6, 8]
```

</br>

11. The set S originally contains numbers from 1 to n. But unfortunately, due to the data error, one of the numbers in the set got duplicated to another number in the set, which results in repetition of one number and loss of another number.
 
Given an array nums representing the data status of this set after the error. Your task is to first find the number occurs twice and then find the number that is missing. Return them in the form of an array.
 
 Example 1:
 Input: nums = [1,2,2,4]
 Output: [2,3]

 Example 2:
 Input: nums = [1,1]
 Output: [1,2]

 Example 3:
 Input: nums = [2,2]
 Output: [2,1]
 
 </br>
 
 12. Write a function named parse(digit:) that takes a string with one character as parameter. The function should return -1 if the input is not a digit character and the digit otherwise.
 
 ```swift 
// example outputs
parse(digit: "1") // 1
parse(digit: "3") // 3
parse(digit: "a") // -1
 ```
 
 </br>
 
 13.  Write a function questionsMarks(str) take the str string parameter, which will contain single digit numbers, letters, and question marks, and check if there are exactly 3 question marks between every pair of two numbers that add up to 10. If so, then your program should return the string true, otherwise it should return the string false. If there aren't any two numbers that add up to 10 in the string, then your program should return false as well. 

For example: if str is "arrb6???4xxbl5???eee5" then your program should return true because there are exactly 3 question marks between 6 and 4, and 3 question marks between 5 and 5 at the end of the string. 

>Input:"aa6?9"  
>Output:"false"  
>
>Input:"acc?7??sss?3rr1??????5"  
>Output:"true"  

</br> 

14. Write a function greatestCommonFactor(arr) take the array of numbers stored in arr which will always contain only two positive integers, and return the greatest common factor of them

>Input:1, 6  
>Output:1  
>
>Input:12, 28  
>Output:4  

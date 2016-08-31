//: Playground - noun: a place where people can play

import UIKit

// Closures-One-Exercises

//1. Create a closure thats no parameters or values and prints "Hello Closures!". Check by passing closure's return to a variable

//2. Create a closure that takes one Int and returns the doubled value. Check by passing closure's return to a variable.

//3. Create a closure that takes one Int and returns a bool whether or not it's divisible by 3.

//4. Create a closure that takes two strings as input and returns the longest character count of the two strings.

//5a.  Create a closure that takes an array of Int as input and returns the largest element in the array


//5b.  Create a closure that takes an array of Int and variable x: Int as input and returns the xth largest element in the array.  Assume x is always < the count of the array


//5c.  Rewrite 5b and add handling for cases where x >= the count of the array (Hint: Use optionals)


//Higher order functions

let myArray = [34,42,42,1,3,4,3,2,49]

//6a. Sort myArray in ascending order by defining the constant ascendingOrder below.

//let mySortedArray = myArray.sort(ascendingOrder)
//let ascendingOrder =

//6b. Sort myArray in descending order by defining the constant descendingOrder below.

//let mySecondSortedArray = myArray.sort(descendingOrder)
//let descendingOrder =

let arrayOfArrays = [[3,65,2,4],[25,3,1,6],[245,2,3,5,74]]

//7a. Sort arrayOfArrays in ascending order by the 3rd element in each array.  Assume each array will have at least 3 elements

//7b. Sort arrayOfArrays in ascending order by the 3rd element in each array.  Don't assume each array will have at least 3 elements.  Put all arrays that have less than 3 elements at the end in any order.

let letterValues = [
    "a" : 54,
    "b" : 24,
    "c" : 42,
    "d" : 31,
    "e" : 35,
    "f" : 14,
    "g" : 15,
    "h" : 311,
    "i" : 312,
    "j" : 32,
    "k" : 93,
    "l" : 203,
    "m" : 212,
    "n" : 41,
    "o" : 102,
    "p" : 999,
    "q" : 1044,
    "r" : 404,
    "s" : 649,
    "t" : 414,
    "u" : 121,
    "v" : 838,
    "w" : 555,
    "x" : 1001,
    "y" : 123,
    "z" : 432
]

//8a. Sort the string below in descending order according the dictionary letterValues

var codeString = "aldfjaekwjnfaekjnf"


//8b.  Sort the string below in ascending order according the dictionary letterValues

var codeStringTwo = "znwemnrfewpiqn"


//6a. Write a function that returns a Bool of whether or not a function will return an Int


//6b. Write a function that takes a function as input and returns a String that states the type the function will return


//7.  Write a function that takes a function as input and returns a function that doubles the output of the input function
//Input: (Int) -> Int
//Output: (Int) -> Int

//8.  Write a closure tripleNumber that takes no arguments and returns void.  It should multiply the global variable number by 3.

var number = 1

//var tripleNumber =

//9. Create a closure that takes an two arrays of strings as input. Output a new string with the contents of the arrays in alternating order and separated by a space. If one array's length is longer than the other, append the rest of it's contents to the new string.

// eg: input array1: ["Hello", "My", "Friend"] array2: ["Darkness", "Old"]
//      output string: "Hello Darkness My Old Friend

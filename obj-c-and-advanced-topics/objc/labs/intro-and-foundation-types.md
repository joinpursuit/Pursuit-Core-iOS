# Objective-C Intro to Types

## General Instructions

Use your Swift knowledge, introduction to the Objective-C and Foundation types, and problem-solving skills to find answers to the below. Some questions will require that you dig into the Objective-C libraries, so think about how you would solve in Swift first.

## Instructions for lab submission

1. Create your own Github repository and clone to your device
1. Add a new Command Line App to the repository
1. Complete the lab: Create answers to these questions in the `main` function of `main.m`. On the line before the answer to each question, add a comment to indicate which question you are answering.
1. Make commits as you answer each question
1. Push your changes to your repo
1. Paste a link of your repo on Canvas and submit


***
## Question 1

Compare the `int`s 1 and 2, and print out which is larger.

***
## Question 2

Below are two boolean values, `t` and `f`. When compared, they are equal. Change `f` so that it is equal to the `int` 2

```
BOOL t = true;
BOOL f = NO;
f++;
```

***
## Question 3

Below is a pointer to the value saved from the `int` 1. Create a while loop that incremements the int until the pointer's value is `0x33`

`int *pointer = 1`

***
## Question 4

Compare the `double` 6.1 and the `int` 6,  and print the result.

***
## Question 5

Add the `double` 1.5 and the `int` 6,  and print the result as a `float`

***
## Question 6

Below is an NSString created from a string literal. Print the length of the string

`NSString *myString = @"My string is not too long"`

***
## Question 7

Below are two NSStrings. Concatenate them into one string, and print that string.

```
NSString *myFirstString = @"This is a string"
NSString *mySecondString = [NSString stringWithString: @"and so is this!"]
```

***
## Question 8

Using the string created in Question 7, remove the letter `i` every time it appears. You might need to change the type of this string.

```
NSString *myFirstString = @"This is a string"
NSString *mySecondString = [NSString stringWithString: @"and so is this!"]
```

***
## Question 9

Translate the below Swift Array into an `NSArray`. For each state, print out the name of the state, a colon, and whether it is or is not **in the continental United States.**

`let moreStates = ["Hawaii", "New Mexico", "Alaska", "Montana", "Texas", "New York", "Florida"]`

***
## Question 10

Iterate through the `NSArray` you created in Question 2. If the state is in the continental US, add it to a new array, and if it is not, print out the name of the state, followed by a colon, followed by "It ain't from around these parts." Once you've looped through, loop through the new array and print out the states in the continental US, followed by a colon, followed by "It ain't but a hop skip and jump away!"

***
## Question 11

Create an `NSDictionary` that will let a user know whether or not the state they're looking at is in the continent US.

***
## Question 12

Create a set that is initialized with the values 1,2,3,4,5,6,7,1,2,3,4,5,6,6,6,6,6,6.

## Question 13

Insert a new item into the set created in Question 10.

***
## Question 14

Create a range of the numbers 20 to 150 inclusive, and print out all the numbers that follows these conditions:

`Numbers that are divisible by 2 and 3`

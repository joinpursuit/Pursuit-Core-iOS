# Week 3 Homework

## Question One

Exhibit A. (mathStuffFactory)

```swift
func mathStuffFactory(opString: String) -> (Double, Double) -> Double {
    switch opString {
    case "+":
        return {x, y in x + y }
    case "-":
        return {x, y in x - y }
    case "*":
        return {x, y in x * y }
    case "/":
        return {x, y in x / y }
    default:
        return {x, y in x + y }
    }
}
```

### Part 1a: Command Line Math Stuff

Incorporate mathStuffFactory(_:) that we worked on in Closures Two into a command line application. Parse input from the user into operator, and two operands, run the operation and return the answer. Reject non-conforming ops with a message.

For example, your console might look like this:

> 5 + 3
> 
> 5 + 3 = 8
> 
> 5 * 3
> 
> 5 * 3 = 15
> 
> 5 & 3
> 
> Unknown operator: &
> 
> Exit

### Part 1b: Random Math Stuff

Make question mark perform a random operation.

### Part 1c. Random Math Stuff Game

When the question mark operator is used the application will secretly perform the operation and return only the result. The user is then prompted to guess the operator used.

For this, your console might look like this:

> 5 + 3
> 
> 5 + 3 = 8
> 
> 5 ? 3
> 
> 15
> 
> \-
> 
> Nope!
> 
> *
> 
> Correct!
> 
> Exit

## Question Two:
###Add filter, map and reduce to your calculator

### Part 2a: Implement your own filter function

Your filter will need to support:

- Numbers less than a given number
- Numbers greater than a given number


You only need to filter Ints  You will write your **own** filter method (not using the built in one).  Use this as a starting point.

```swift
func myFilter(inputArray: [Int], filter: (Int) -> Bool) -> [Int] {

}
```

Example:

>filter 1,5,2,7,3,4 by < 4
>
>1,2,3


### Part 2b: Implement your own map function

Your map will need to support:

- Multiplying by a given number
- Dividing by a given number

Example:

>map 1,5,2,7,3,4 by * 3
>
>3,15,6,21,9,12


### Part 2c: Implement your own reduce function

Your reduce will need to support:

- Summing an array starting at a given value
- Multiplying an array starting at a given value

>reduce 1,5,2,7,3,4 by + 4
>
>26

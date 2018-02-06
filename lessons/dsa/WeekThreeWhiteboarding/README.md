# iOS Interview Questions

### 1. Given an array of integers, find the highest product you can get from three of the integers.
The input items will always have at least three integers.

### 2. You want to be able to access the largest element in a stack.
You've already implemented this Stack class:

```swift
  class Stack<Item> {
 
    // initialize an empty array
    private var items: [Item] = []
 
    // push a new item to the last index
    func push(_ item: Item) {
        items.append(item)
    }
 
    // remove the last item
    func pop() -> Item? {
 
      // if the stack is empty, return nil
      // (it would also be reasonable to throw an exception)
        if items.count == 0 {
            return nil
        }
        return items.removeLast()
    }
 
    // see what the last item is
    func peek() -> Item? {
        return items.last
    }
}

```
Use your Stack class to implement a new class MaxStack with a method getMax() that returns the largest element in the stack. getMax() should not remove the item.
Your stacks will contain only integers.

### 3. Write a function to reverse a string in-place
An in-place algorithm operates directly on its input and changes it, instead of creating and returning a new object. This is sometimes called destructive, since the original input is "destroyed" when it's edited to create the new output.

Careful: "In-place" does not mean "without creating any additional variables!" Rather, it means "without creating a new copy of the input." In general, an in-place function will only create additional variables that are O(1) space.

### 4. You're working with an intern that keeps coming to you with JavaScript code that won't run because the braces, brackets, and parentheses are off. To save you both some time, you decide to write a braces/brackets/parentheses validator.
Let's say:

```swift
'(', '{', '[' are called "openers."
')', '}', ']' are called "closers."
```
Write an efficient function that tells us whether or not an input string's openers and closers are properly nested.
Examples:

```swift
"{ [ ] ( ) }" should return true
"{ [ ( ] ) }" should return false
"{ [ }" should return false
```


### 5. You have a function rand7() that generates a random integer from 1 to 7. Use it to write a function rand5() that generates a random integer from 1 to 5.
rand7() returns each integer with equal probability. rand5() must also return each integer with equal probability.

### 6. In order to win the prize for most cookies sold, my friend Alice and I are going to merge our Girl Scout Cookies orders and enter as one unit.
Each order is represented by an "order id" (an integer).
We have our lists of orders sorted numerically already, in arrays. Write a function to merge our arrays of orders into one sorted array.

For example:

```swift
let myArray = [3, 4, 6, 10, 11, 15]
let alicesArray = [1, 5, 8, 12, 14, 19]

print(mergeArrays(myArray, alicesArray))
// logs [1, 3, 4, 5, 6, 8, 10, 11, 12, 14, 15, 19]
```

**Solve by NOT concatenating (join together) the two arrays into one and then sort them.**


### 7. You have an array of integers, and for each index you want to find the product of every integer except the integer at that index.
Write a function getProductsOfAllIntsExceptAtIndex() that takes an array of integers and returns an array of the products.
For example, given:
 [1, 7, 3, 4]


your function would return:
 [84, 12, 28, 21]


by calculating:

```swift
 [7 * 3 * 4,  1 * 3 * 4,  1 * 7 * 4,  1 * 7 * 3]
```

***Do not use division in your solution.***

### 8. Writing programming interview questions hasn't made me rich. Maybe trading Apple stocks will.

Suppose we could access yesterday's stock prices as an array, where:

 1. **The indices are the time in minutes past trade opening time, which was 9:30am local time.**
  
 2. **The values are the price in dollars of Apple stock at that time.**

So if the stock cost $500 at 10:30am, stockPricesYesterday[60] = 500.

Write an efficient function that takes stockPricesYesterday and returns the best profit I could have made from 1 purchase and 1 sale of 1 Apple stock yesterday.

For example:


```swift
  let stockPricesYesterday = [10, 7, 5, 8, 11, 9]

getMaxProfit(from: stockPricesYesterday)
// returns 6 (buying for $5 and selling for $11)
```
No "shorting"—you must buy before you sell. You may not buy and sell in the same time step (at least 1 minute must pass). 


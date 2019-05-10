## Functions, Closures, Enums, Classes

<pre> 
1.  Use filter to create an array called numbersEndingIn5 that contains all the 
numbers ending in 5 and then print it.
 
let numbers = [1, 3, 5, 85, 15, 11, 90, 5, 56, 45, 12, 75]

Example
Input:

let numbers = [1, 3, 5, 85, 15, 11, 90, 5, 56, 45, 12, 75]
Expected values:

numbersEndingIn5 = [5, 85, 15, 5, 45, 75]
</pre>
 
 </br> 
 
<pre> 
2. Find the sum of the squares of all the odd numbers from numbers and then print it.

var numbers = [1, 2, 3, 4, 5, 6]
a. Write code that removes all the odd numbers from the array.

b. Write code that squares all the numbers in the array.

c. Write code that finds the sum of the array. 

d. Now use map, filter and reduce to solve this problem.

Example
Input:

var numbers = [1, 2, 3, 4, 5, 6]
Output:

35 // 1 + 9 + 25 -> 35
</pre>
 
 </br> 

<pre> 
3. Create a closure that takes two strings as input and returns the longest character
count of the two strings.
</pre> 
 
 </br> 
 
<pre> 
4. Write a function that takes in an [Int?] and a closure as parameters and returns an [Int]. The closure 
should take in an Int? and return a Bool.

This function should run all the Int?s through the closure, which determines if the value is unwrappable. 
Then unwrap all elements that aren't nil in your main function to return in an Array.

Input:

let optionalIntArray = [1, 2, nil, 4, 5, nil, 7, 8]
Output:

[1, 2, 4, 5, 7, 8]
</pre> 
 
 </br> 

<pre> 
5. Consider this bit of code that uses the Giant class:

class Giant {
  var name: String
  var weight: Double
  let homePlanet: String
  
  init(name: String, weight: Double, homePlanet: String) {
    self.name = name
    self.weight = weight
    self.homePlanet = homePlanet
  }
}

let edgar = Giant(name: "Edgar", weight: 520.0, homePlanet: "Earth")
let jason = edgar
jason.name = "Jason"
What will the value of edgar.name be after those three lines of code are run? What will the value 
of jason.name be? Why?
</pre> 

</br> 
 
<pre>  
6. Given this bit of code that uses the Alien struct:

struct Alien {
  var name: String
  var height: Double
  var homePlanet: String
}
let bilbo = Alien(name: "Bilbo", height: 1.67, homePlanet: "Venus")

var charles = Alien(name: "Charles", height: 2.25, homePlanet: "Pluto")
var charlesFromJupiter = charles
charlesFromJupiter.homePlanet = "Jupiter"

What will the value of charles.homePlanet be after the above code run? 
What about the value of charlesFromJupiter.homePlanet? Why?
</pre> 

 </br> 
 
<pre>  
7. //a. Create a class called Book that has properties for title, author and rating, of type String, 
String, Double respectively. Dont forget the initializer. Create some instances of Book.

//b. Add a method to Book called isGood that returns true if its rating is greater than or equal to 7
</pre> 
 
 </br> 
 
<pre> 
8. // Create a struct called RGBColor that has 3 properties, red, green, blue that are all of type Double.

// Given the below array of color dictionaries, create an array of RGBColor

let colorDictArray: [[String: Double]] = [["red": 1.0, "green": 0.0, "blue": 0.0],
 ["red": 0.0, "green": 1.0, "blue": 0.0],
 ["red": 0.0, "green": 0.0, "blue": 1.0],
 ["red": 0.6, "green": 0.9, "blue": 0.0],
 ["red": 0.2, "green": 0.2, "blue": 0.5],
 ["red": 0.5, "green": 0.1, "blue": 0.9],]
 
</pre> 
 
 </br> 
 
<pre>  
9. You are working on a game in which your character is exploring a grid-like map. You get the original 
location of the character and the steps he will take.

A step .up will increase the y coordinate by 1.
A step .down will decrease the y coordinate by 1.
A step .right will increase the x coordinate by 1.
A step .left will decrease the x coordinate by 1.
Print the final location of the character after all the steps have been taken.

enum Direction {
    case up
    case down
    case left
    case right
}

var location = (x: 0, y: 0)

var steps: [Direction] = [.up, .up, .left, .down, .left]

// your code here
</pre>
 
 </br>
 
<pre> 
10.  //a. Create an enum called MetroLine with cases for the colors of the metro train lines. 
Create an instance of MetroLine

//b. Modify your enum so that each case has an associated value of either Character or Int 
that will represent the train on that line. Create a new instance of MetroLine and give it an appropriate 
train letter or number.

//c. Write code that prints the train letter or number of your instance of MetroLine
</pre> 
 
</br>
 
<pre> 
11. What is the output of the print statment? 
 
func coffeeOrTea(coffee: Bool, sugarAmount: Int = 2) {
 let choice = coffee ? "coffee" : "tea"
 print("here is your \(choice) with \(sugarAmount) sugars")
}
coffeeOrTea(coffee: true, sugarAmount: 3)
</pre> 

</br>

<pre> 
12. What output will be produced by the code below?

var spaceships1 = Set&lt;String&gt;()
spaceships1.insert("Serenity")
spaceships1.insert("Enterprise")
spaceships1.insert("TARDIS")

let spaceships2 = spaceships1

if spaceships1.isSubset(of: spaceships2) {
  print("This is a subset")
} else {
  print("This is not a subset")
}
</pre>

</br>

<pre>
 13. Define an enum called CoinType which describes different coin values (penny, nickle, dime and quarter) with their respective raw values.
 You are given a moneyArray which has tuples(ammount, coinType), amount is the amount of coins and coinType represent the enum case.
 Print the total value of the coins in the array.
 
 let moneyArray:[(Int,CoinType)] = [(10,.penny),
 (15,.nickle),
 (3,.quarter),
 (20,.penny),
 (3,.dime),
 (7,.quarter)]
 
 output: 385
</pre>

</br>

<pre>
 14. Implement a function forEach that takes an array of integers
 and a closure and runs the closure for each element of the array.
 
 Test your function by squaring and printing each element in the test array
</pre>

 

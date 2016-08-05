# Arrays

#### Exercise 1.
Create an array of strings called __colors__ that contain "orange", "red", "yellow", "turquoise", and "lavender".
Create a variable __orange__ and its corresponding input value should be accessed from the __colors__ array.
Do the same for variables __red__, __yellow__, __turquoise__ and __lavender__.

#### Exercise 2.
Create a variable for each string: "Hawaii", "California", "Alaska", "Oregon", "Washington", "Illinois", "Kansas". Declare an array of strings called __westernStates__ and input the above variables. Remove "Illinois" and "Kansas" from the array.

#### Exercise 3.
What do you expect to happen in the code below?
```
let planets: [String] = ["Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune", "Pluto" ]
planets.removeAtIndex(8)
```
Do we need to make any changes?

#### Exercise 4.
Declare an empty variable array of type Int. Practice adding and removing values to the array. Try adding other data types into the array - what happens?

#### Exercise 5.
For the below - change the value of 2 to 1. Change the value of 8 to 9.
```
var numbers: [Int] = [2, 4, 7, 8, 12, 33]
```
What is the output of __numbers__ after the following code?
```
numbers[1...4] = [0, 0, 0, 0]
```

#### Exercise 6.
The below array represents an unfinished batting lineup for a baseball team. You, the coach, need to make some last minute changes.
- Add "Suzuki" to the end of your lineup.
- Change "Jeter" to "Tejada".
- Change "Thomas" for "Guerrero"
- Put "Reyes" to bat 8th instead.
```
var battingLineup = ["Reyes", "Jeter", "Ramirez", "Pujols","Griffey","Thomas","Jones", "Rodriguez"]
```

#### Exercise 7.
Iterate through the __garden__ array picking the 🌷 and place them into a new array __basket__. After removing the 🌷 from the garden array it should be replaced with dirt. Then print how many 🌷are in the basket.
```
var garden = [",","🌷",",","🌷",",","🌷",",","🌷",","]

var basket = [Any]()
```

#### Exercise 8.
Using your knowledge of loops and conditionals, print the lyrics to the song [_"99 Bottles Of Beer"_](http://www.99-bottles-of-beer.net/lyrics.html).

#### Exercise 9.
Print the first 20 numbers of the [_Fibonacci Series_](https://en.wikipedia.org/wiki/Fibonacci_number).

#### Exercise 10.
Iterate from 0 to 100. If the number is a multiple of 3, print "Fizz" instead of the number. If the number is a multiple of 5, print "Buzz". If the number is a multiple of 3 and 5 print, "FizzBuzz" instead of the number. If it meets none of the above criteria, just print the number.

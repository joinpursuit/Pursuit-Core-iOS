# Conditionals

### Question 1.
What is the advantage of a __switch__ over an __if__ statement?
- a. There is no advantage.
- b. A switch statement is very versatile because it lets you use ranges and sequences in a single case statement.

### Question 2.
What's missing from the switch statement below?
- a. Missing case statements from the other month
- b. The code is valid and not missing anything
- c. The above code will not compile because switch statements need case statements for all expected values or a default statement.

```
 let months = 1...12

for month in months {
    switch month {
        case 1:
            print("January")
    }
}
```

### Question 3.
Convert the if/else statement below into a switch statement.

```
temperatureInFahrenheit = 72

if temperatureInFahrenheit <= 40 {
    print("It's cold out.")
} else if temperatureInFahrenheit >= 85 {
    print("It's really warm.")
} else {
    print("Weather is moderate.")
}
```

### Question 4.
Change the below if/else statement into a switch statement.
```
let cards = 1...13

for card in cards {
    if card == 11 {
        print("Jack")
    } else if card == 12 {
        print("Queen")
    } else if card == 13 {
        print("King")
    } else {
        print(card)
    }
}
```

### Question 5.
Create a switch statement that will convert a number grade into a letter grade as shown below:
* 100 -> A+
* 90 - 99 -> A
* 80 - 89 -> B
* 70 - 79 -> C
* 65 - 69 -> D
* Below 65 -> F

### Question 6.
Consider the below switch statement. What should your system currently print? What happens when you change _number_ to 365? 1024? 65? What happens when you remove the __default__ clause?
```
let number = 42

switch number {
case 365:
    print("Days in year")
case 1024:
    print("Bytes in a Kilobyte")
case 0:
    print("Where arrays start")
case 42:
    print("The answer to life, the universe and everything")
default:
    print("Some uninteresting number")
}
```

### Question 7.
Consider the variable below called _population_ and the if-condition.
1. Add an else-if-condition that states if _population_ is less than 10000 but greater than 5000, the message changes to say it's "a medium size town".
2.  Add an else-condition where the message changes to say it's a mid-size town.
3. Convert your final if-else statement to a switch statement.

```
var population: Int = 10000
var message = String()

if population > 10000 {
    message = "\(population) is a large town"
}
```

### Question 8.
The below code is compiling with an error. What's missing?

```
let names  = ["Paul","Stevie","Michael","John","Bono","George","Ringo","Mick"]
for name in names {
  switch {
  case "Paul","George","John","Ringo":
    print("\(name) is a Beatle")
  default:
    print("\(name) is not a Beatle")
  }
}
```

### Question 9.
Complete the switch statement below to print the correct output.

```
let sentence = "You're the best around, nothing's going to ever keep you down!"
var sentenceWithNoVowels = ""

for character in sentence.characters {
    switch character {
        //put code here
    }
}
print(sentenceWithNoVowels)

//Prints "Y'rthbstrnd,nthng'sgngtvrkpydwn!"
```

### Question 10.
Consider the below switch with a tuple.
* Add a case for when _y_ is __double__ the value of _x_
* Add a case for when _y_ is __triple__ the value of _x_

```
switch (x,y) {
case let (x,y) where x==y :
    print("x is equal to y")
case let (x,y):
    print("Nothing is special about this tuple")
}
```

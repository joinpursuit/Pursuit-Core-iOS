import UIKit

//Alex is shitty, hates closures
//Ayoola as well
//Fredlyne says closures can be tricky -

let cities = ["Shanghai", "Beijing", "Delhi", "Lagos", "Tianjin", "Karachi", "Karachi", "Tokyo", "Guangzhou", "Mumbai", "Moscow", "São Paulo"]

//a. Use sortedBy to sort cities in alphabetical order.
// use .sorted(by:) with a closure that compares the strings to each other, using the operator a > b

//b. Use sortedBy to sort cities alphabetical order of the second character of the city name.
// use .sorted(by:) with a closure that uses dropFirst() on each elemet - it eliminates the first character in the string, so the comparison start with the second character. The comparison is $0.dropFirst() < $1.dropFirst()
// or using arrays { x,y in Array(x)[1] < Array(y)[1] }


//c. Use sortedBy to sort cities in order of the length of the city name.
// {x,y in x.count < y.count }
var lengthOfStringArray = cities.map({$0.count})

//sorted(by:)
//sorts the array by parameters -> based on the condition that you give it (using a closure), it will sort and return the result of using that condition on each element. can think of it as iterating through the arrayn and applying the condition to each pair of elements.
//Note: Important to remember there's a difference between sort() (which changes the array and doesnt return anything) and sorted() (which doesn't change the array and does return a new array that is sorted)
//the default sorted() sorts your array in ascending order - from small to big

//map()
//Array method: takes an array and manipulates each value in order and returns a new array with the same changes to each element of the original. ex: array.map({$0 * 3}) would return a new array where each element is 3 times the value of each corresponding element (aka, in the same index) in the original array.


//reduce()
//Array method: takes array in and condenses it to one value.


//filter()
//Array method: takes an array and returns a new array whose elements  meet the given condition.
let numbers = [4, 7, 1, 9, 6, 5, 6, 9]

let filteredNumbers = numbers.filter({a -> Bool in
    return a % 2 == 1
})



//Closures lab Q3:
//Find the largest number from numbers and then print it. Use reduce to solve this exercise.

//Example: Input: let numbers = [4, 7, 1, 9, 6, 5, 6, 9]
//Output: 9

var largest = 0
for num in numbers {
    if num > largest {
        largest  = num
    }
}

let reducedNumbers = numbers.reduce(0, { x , y in
    return x > y ? x : y //compare two values and return largest of x and y
})

//print(reducedNumbers)

if true { // () -> ()
    
}

for i in 0...1 { //(i) in
//    print(i)
}

func aFunction(a: Int) -> Int { //(arguments) -> returnValue
    return a
}

//Closure Lab Q7:
//Sort numbers in ascending order by the number of divisors. If two numbers have the same number of divisors the order in which they appear in the sorted array does not matter.
//
//var numbers = [1, 2, 3, 4, 5, 6]
//
//Example: Input: var numbers = [1, 2, 3, 4, 5, 6]
//Output: numbers = [1, 2, 3, 5, 4, 6]

//Input: an array of Int

//One has one divisor (1). Two  has two divisors (1,2). Three has two divisors (1,3). Four has three divisors (1,2,4). Five has two divisors (1,5). Six has four divisors (1,2,3,6).
//for six, we would look through 1 -> 6 to see if they're divisors for six, checking that six % potentialDivisor == 0 (no remainder means it divides in evenly)
// Use a range 1...numberWeAreDividingInto, loop through, and only keep track of the numbers in that range that DO divide evenly into the numberWeAreDividingInto <-- could use a filter.
//OR
// Use a range 1...numberWeAreDividingInto, loop through, and only add one to our result (increase the frequency) if the number DOES divide evenly into the numberWeAreDividingInto <--- could also use reduce.
//OR -> tomorrow (7/17) Liana will show us how she used sorted(by:)

//Output: an array of Int

// divisor is a modulo, a number that divides another number evenly
// (when a % divisor == 0)
// reminds Aaron of FizzBuzz
// FizzBuzz? An interview question that asks you to look through an array and print "Fizz" if the element you're looking at is divisible by 5, print "Buzz" if the element you're looking at is divisible by 3, and to print "FizzBuzz" if the element you're looking at is divisible by 15







//Enumerations!!!!!! enumnumnum
//Syntax:
//enum Name {
//  case a
//  case b
//}

//name is Capitalized -> Int, String, Double, Result
enum CardinalDirections: String {
    //four situations: north, east, west, south
    //raw values that clarify that we are looking for Strings when we look at a case
    case north = "North"
    case south = "South"
    case east = "East"
    case west = "West"
    
}

//initializes CardinalDirections.north but as an optional
let c = CardinalDirections.init(rawValue: "North")
//c?.rawValue

//switch statement that prints ("hey you're going in the \(rawValue) direction")

var theRawType = String()

switch  c! {
default:
    theRawType = c!.rawValue
//case .north:
//    theRawType = c!.rawValue
//case .south:
//    theRawType = c!.rawValue
//case .east:
//    theRawType = c!.rawValue
//case .west:
//    theRawType = c!.rawValue
}

print("hey you are going in the \(theRawType) direction")

//print that line from above and interpolate theRawType

//make an enum where each case tells us what we will feel on our skin. sunny = heat/warmth/sunlight, windy = wind, rainy = rain, snow = snow
//for the ones that have precipitation, make sure to tell us what state of matter
//Now we'll have things of the type Weather!!!
enum Weather {
    case sunny(String)
    case windy(String)
    case rainy(String,String)
    case snow(String,String)

    func printWhatsGoingOn(argumentName x: Int) {
        print(x)
    }
    
    func printTheWeather() {
        switch self {
        case .sunny:
            print("It's hot outside")
        case .windy:
            print("It's windy")
        case .rainy:
            print("It's rainy")
        case .snow:
            print("it's cold as hell and snowing")
        }
    }
}
//calling printWhatsGoingOn() wont work - it's outside scope of enum definition
let todayIsSunny = Weather.sunny("heat")
var todaysWeather = Weather.rainy("wet", "liquid")
todaysWeather = Weather.sunny("heat")
todaysWeather.printWhatsGoingOn(argumentName:1)

//below prints whatever is output by the sunny case
todaysWeather.printTheWeather()

todaysWeather = Weather.rainy("wet", "liquid")
//below prints whatever is output by the rainy case
todaysWeather.printTheWeather()

print(todaysWeather)

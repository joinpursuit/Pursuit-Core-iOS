//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//
//1a) Define an enumeration called iOSDeviceTypes with member values iPhone, iPad, iWatch. Create a variable called my device and assign it one member value.

//1b) Adjust your code above so that iPhone and iPad have associated values of type String which represents the model# eg: iPhone("6 Plus"). Use a switch case and let syntax to print out the model #.


//2)
/*
Write an enum called Shapes and give it cases for Triangles, Rectangles, Pentagons and Hexagons.  Write a method inside that returns how many sides the shape has.  Then assign a variable to Shapes.Pentagon and then print how many sides it has.
*/


//3)
/*
Write an enum called OperatingSystems and give it cases for Windows, Mac, and Linux.  Create an array of 10 OperatingSystems where each one is set to a random operating system.  Then, iterate through the array and print out a message depending on the operating system.
*/

//4)
/*
You are working on a game in which your character is exploring a grid-like map. You get the original location of the character and the steps he will take.
A step .Up will increase the x coordinate by 1. A step .Down will decrease the x coordinate by 1. A step .Right will increase the y coordinate by 1. A step .Left will decrease the y coordinate by 1.
Print the final location of the character after all the steps have been taken.
*/

enum Direction {
    case Up
    case Down
    case Left
    case Right
}

var location = (x: 0, y: 0)

var steps: [Direction] = [.Up, .Up, .Left, .Down, .Left]

// your code here


//5)
/*
1) Define an enumeration named HandShape with three members: .Rock, .Paper, .Scissors.
2) Define an enumeration named MatchResult with three members: .Win, .Draw, .Lose.
3) write a function called match that takes two hand shapes and returns a match result. It should return the outcome for the first player (the one with the first hand shape).
// Hint: Rock beats scissors, paper beats rock, scissor beats paper

*/

//6)
/*
You are given a CoinType enumeration which describes different coin values.
Print the total value of the coins in the array moneyArray which has tuples(ammount, coinType).
*/

enum CoinType: Int {
    case Penny = 1
    case Nickle = 5
    case Dime = 10
    case Quarter = 25
}

var moneyArray:[(Int,CoinType)] = [(10,.Penny),
(15,.Nickle),
(3,.Quarter),
(20,.Penny),
(3,.Dime),
(7,.Quarter)]

// your code here

//6b)
/*
Write a method in the CoinType enum that returns an Int representing how many coins of that type you need have a dollar.  Then, create an instance of CoinType set to .Nickle and use your method to print out how many nickels you need to have to make a dollar.
*/




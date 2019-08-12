//
//  main.swift
//
//  Created by David Rifkin on 7/12/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation

//this prints something out in command line and then waits for the user to give an input
func getInput() -> String? {
    print("get input:", terminator: " ")
    let lineIn = readLine()
    return lineIn
}

// this would save the value of the input
// var thisWasInput  = getInput()

// when we call this function, it creates a loop that will run all of our game logic. What kind of loop could we use inside of it? Be careful not to create an infinite loop!
func gameLoop() {
    // we could call getInput to print things out and get an input value. Remember what Type we get as the return value for our input function
    let input = getInput()
    // we could also create some other functions to handle the other parts of our game, like seeing if the game is over, seeing if the user won or lost, and some other stuff too!
}

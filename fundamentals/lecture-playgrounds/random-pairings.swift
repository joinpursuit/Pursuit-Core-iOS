//
//  main.swift
//  random-pairings-7.17
//
//  Created by David Rifkin on 7/17/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation


var students = ["Hildy", "Alyson", "Ayoola", "Jocelyn", "Bianca", "Phil", "Krystal", "Ian", "Michelle", "Levi", "Angela", "Anthony", "Mariel", "Adam", "Alex", "Tia", "Kary", "Phoenix", "Eric M", "Kevin", "Liana", "Albert", "Aaron", "Neema", "Fredlyne", "Sam", "Jason", "Wally", "Sunni", "Malcolm", "Jack", "Eric W", "Kimball"]

var studentPairs = [(String,String)]()

func getRandomStudent() -> String? {
    if let student = students.randomElement() {
        students.removeAll(where: {a in
            a == student
        })
        return student
    }
    return nil
}

func addStudentPair(_ s1: String,_ s2: String) {
    studentPairs.append((s1,s2))
}

func createPair() {
    if let student1 = getRandomStudent() {
        if let student2 = getRandomStudent() {
            addStudentPair(student1,student2)
        } else {
            addStudentPair(student1,"oooooops we have an odd number of people in our class today :( let's figure out how to pair you up!")
        }
    }
}

func printPairings() {
    let date = Date()
    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd"
    let formattedDate = format.string(from: date)
    print("Here are the pairs for the date \(formattedDate)")
    for i in studentPairs {
        print("\(i.0) and \(i.1), you're working together today!")
    }
}

func setupPairings(){
    while students.count > 0 {
        createPair()
    }
    printPairings()
}

setupPairings()

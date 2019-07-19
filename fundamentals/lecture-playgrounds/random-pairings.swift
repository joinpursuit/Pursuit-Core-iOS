//
//  main.swift
//  random-pairings-7.17
//
//  Created by David Rifkin on 7/17/19.
//  Copyright © 2019 David Rifkin. All rights reserved.
//

import Foundation


var students = ["Hildy", "Alyson", "Ayoola",  "Bee", "Krystal", "Ian", "Michelle", "Levi", "Angela", "Anthony", "Mariel", "Adam", "Alex", "Tia", "Kary", "Phoenix", "Eric M", "Kevin", "Liana", "Albert", "Aaron", "Neema", "Fredlyne", "Sam", "Jason", "Wally", "Sunni", "Jack", "Eric W", "Kimball", "Rad"]
//absent: "Malcolm", "Josh", "Jocelyn"
var previousPairs: [String:String] = [
    "Hildy" : "Wally",
    "Alyson" : "Jocelyn",
    "Ayoola" : "Adam",
//    "Jocelyn" : "Alyson",
    "Bee" : "Malcolm",
    "Krystal" : "Sunni",
    "Ian" : "Kary",
    "Michelle" : "Alex",
    "Levi" : "Fredlyne",
    "Angela" : "Liana",
    "Anthony" : "Eric W",
    "Mariel" : "Tia",
    "Adam" : "Ayoola",
    "Alex" : "Michelle",
    "Tia" : "Mariel",
    "Kary" : "Ian",
    "Phoenix" : "Eric M",
    "Eric M" : "Phoenix",
    "Kevin" : "Neema",
    "Liana" : "Angela",
    "Albert" : "Kimball",
    "Aaron" : "Jason",
    "Neema" : "Kevin",
    "Fredlyne" : "Levi",
    "Sam" : "",
    "Jason" : "Aaron",
    "Wally" : "Hildy",
    "Sunni" : "Krystal",
//    "Malcolm" : "Bianca",
    "Jack" : "",
    "Eric W" : "Anthony",
    "Kimball" : "Albert",
    "Rad": ""]


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

func getNewPair(_ student1: String) -> (String,String) {
    var pairFound = false
    while !pairFound {
        let potentialPair = students.randomElement()
        if let p = potentialPair, p != student1 && p != previousPairs[student1] {
            students.removeAll(where: {a in
                a == p
            })
            return (student1,p)
        }
    }
}

func addStudentPair(_ pair: (String, String)) {
    studentPairs.append(pair)
}

func createPair() {
    if let student1 = getRandomStudent() {
        if students.count > 0 {
            let pair = getNewPair(student1)
            addStudentPair(pair)
        } else {
            addStudentPair((student1,"let's triple you with the pair above"))
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

//: [Previous](@previous)

import Foundation

let ac32folks = [("Amber", "Spadafora",	3201),
                 ("Ana", "Ma",	3202),
                 ("Annie", "Tung",	3203),
                 ("Cristopher", "Chavez", 3204),
                 ("Eashir", "Arafat", 3205),
                 ("Edward", "Anchundia", 3206),
                 ("Emily", "Chu", 3207),
                 ("Eric", "Chang", 3208),
                 ("Erica", "Stevens", 3209),
                 ("Fernando", "Ventura", 3210),
                 ("Harichandan", "Singh", 3211),
                 ("Ilmira", "Estil", 3212),
                 ("Jermaine", "Kelly", 3213),
                 ("Gabriel", "Breshears", 3214),
                 ("Kadell", "Gregory", 3215),
                 ("Kareem", "James", 3216),
                 ("Karen", "Fuentes", 3217),
                 ("Leandro", "Nunez", 3218),
                 ("Liam", "Kane", 3219),
                 ("Luz", "Herrera", 3220),
                 ("Madushani", "Liyanage", 3221),
                 ("Marcel", "Chaucer", 3222),
                 ("Margaret", "Ikeda", 3223),
                 ("Maria", "Scutaru", 3224),
                 ("Marty", "Avedon", 3225),
                 ("Michael", "Pinnock", 3226),
                 ("Miti", "Shah", 3227),
                 ("Rukiye", "Karadeniz", 3228),
                 ("Sabrina", "Ip", 3229),
                 ("Simone", "Grant", 3230),
                 ("Sophia", "Barrett", 3231),
                 ("Thinley", "Dorjee", 3232),
                 ("Tom", "Seymour", 3233),
                 ("Tong", "Lin", 3234),
                 ("Tyler", "Newton", 3235),
                 ("Victor", "Zhong", 3236)]

//var microwaveLine = ac32folks.filter { (a) -> Bool in
//    a.1.hasPrefix("S")
//}

//for peep in microwaveLine {
//    print(peep)
//}

let me = ("Annie", "Tung", 3203)
let cutMicrowaveLine = { (students: [(String, String, Int)], me: (String, String, Int)) -> [(String, String, Int)] in
    var selfFirstStudentList = students
    
//    for index in 0..<selfFirstStudentList.count {
//        if selfFirstStudentList[index] == me {
//            selfFirstStudentList.removeAtIndex(index)
//            selfFirstStudentList.insert(me, atIndex: 0)
//        }
//    }
    selfFirstStudentList = selfFirstStudentList.filter({ (a:(String,String,Int)) -> Bool in
        return me != a
    })
    selfFirstStudentList.insert(me, atIndex: 0)

    print(selfFirstStudentList)
    
    return selfFirstStudentList
}
//print(cutMicrowaveLine(ac32folks, me))

var microwaveLine = ac32folks.sort{(a, b) -> Bool in
    var x = a.2
    var y = b.2
    if x == 3208 {
        x += 1000
        return x > y
    }
    return x > y
}
for i in microwaveLine {
    if i.0 == "Eric" {
        print("\(i.0) is awesome!!")
    } else {
        print("\(i.0) is awesome but less awesome than Eric!!")
    }
}
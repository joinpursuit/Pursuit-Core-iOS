//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)

//for dict in movies {
//    if let locationArr = (dict as NSDictionary).value(forKeyPath: "locations") as? [String] {
//        print(locationArr)
//    }
//}

//if let locs = (movies as NSArray).value(forKeyPath: "locations") as? NSArray {
//    for loc in locs  {
//        if let location = loc as? [String] {
//            print("Location array:", location)
//        }
//    }
//}

//for dict in movies {
//    if let nm = (dict as NSDictionary).value(forKeyPath: "nested_movie.locations") as? [String] {
//        print(nm)
//    }
//}

//let newString = String(format: "Hi my name is %@, I am %d years old and I'm %2.3f meters", "Jerjunkel", 27, 2.1898798798)
//print(newString)

//let niPredicate = NSPredicate(format: "name like '*ni?h*'")
//let filmsThatSayNi = movies.filter { niPredicate.evaluate(with: $0) }
//
//for dict in filmsThatSayNi {
//    if let nm = (dict as NSDictionary).value(forKeyPath: "name") as? String {
//        print(nm)
//    }
//}

//let twentyFirstCenturyPredicate = NSPredicate(format: "year between {%d, %d}", 2007, 2009)
//let twentyFirstCentury = movies.filter { twentyFirstCenturyPredicate.evaluate(with: $0) }
//for m in twentyFirstCentury {
//    print("\(m["name"]!), \(m["year"]!)")
//}


//let sigourney = NSPredicate(format: "ANY #cast == 'Sigourney Weaver'", "cast")
//let sigourneyMovies = movies.filter { sigourney.evaluate(with: $0) }
//print (sigourneyMovies)
//for m in sigourneyMovies {
//    print("\(m["name"]!), \(m["cast"]!)")
//}

//let JPredicate = NSPredicate(format: "ANY %K BEGINSWITH %@", "cast", "J")
//let JMovies = movies.filter { JPredicate.evaluate(with: $0) }
//
//for m in JMovies {
//    print("\(m["name"]), \(m["cast"]!)")
//}


//let sigourneyWeaverSubquery = NSPredicate(format: "SUBQUERY(#cast, $x, $x beginswith 'S').@count > 1")
//let sigourneyWeaverBySubquery = movies.filter { sigourneyWeaverSubquery.evaluate(with: $0) }
//print(sigourneyWeaverBySubquery)


let sigourneyPred = NSPredicate(format: "SUBQUERY(#cast, $actor, $actor contains 'Sigourney').@count > 0 and ANY locations == 'Los Angeles'")
let sigourneyMovies = movies.filter { sigourneyPred.evaluate(with: $0) }
for m in sigourneyMovies {
    print("\(m["name"]!), \(m["cast"]!)")
}
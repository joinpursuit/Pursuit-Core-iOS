import UIKit

//Sets!!! But first, a dictionary????

//You are given an array of dictionaries. Each dictionary in the array contains exactly 2 keys “firstName” and “lastName”. Create an array of strings called firstNames that contains only the values for “firstName” from each dictionary.

var people: [[String:String]] = [
    [
        "firstName": "Calvin",
        "lastName": "Newton"
    ],
    [
        "firstName": "Garry",
        "lastName": "Mckenzie"
    ],
    [
        "firstName": "Leah",
        "lastName": "Rivera"
    ],
    [
        "firstName": "Sonja",
        "lastName": "Moreno"
    ]
]
var firstNames = [String]()
for a in people {
    if let first = a["firstName"] {
        firstNames.append(first)
    }
//    for (k,v) in a {
//        if k == "firstName" {
//            firstNames += [v]
//        }
//    }
}
//print(firstNames)
//for loop that iterates through the array
//why? so we have access to the keys/values in dictionaries?
//we want to pull the values from "firstName" specifically, so we want to iterate through the array to find the value for that key in each dictionary


//output
//["Calvin","Garry","Leah","Sonja"]

//Sets: Another data type!
//Collection of information that has no keys and is unordered
//Used it to get rid of duplicates in an array. how?
//Can't have duplicates - no way to look up things up!
//Values must be unique, but we can iterate through
//in the same way that dictionary's keys must be unique as well

//var uniqueNamess = [] <--- ambiguous syntax to the computer

//var array: [String]
//var set: Set<AnyTypeThatYouWant>
//
//var namesArray = ["eric", "eric", "eric", "david"]
//print(namesArray)
//var uniqueNamesSet = Set(namesArray)
////var uniqueNames: Set<String> = ["eric", "eric", "eric", "david"]
//print(uniqueNamesSet)
//uniqueNamesSet.insert("samantha")
//print(uniqueNamesSet)
//print(uniqueNamesSet.count)
//uniqueNamesSet.remove("eric")
//var uniqueNamesArray = Array(uniqueNamesSet)
//print(uniqueNamesArray)

var dictionary = ["name":"david","age":"30","mood":"deeece", "ageTomorrow": "30"]
var davidAsSet = Set(dictionary.values)
var someOtherSet: Set<String> = ["name","30","david","ageTomorrow"]

let union = davidAsSet.union(someOtherSet)
//print(union)

let set1: Set<Int> = [1,3,56,42,13]
let set2: Set<Int> = [1,2,3,4,5,6,13]

//union combines all elements and does not add in duplicative values
let setUnion = set1.union(set2)
print(setUnion.sorted())

//intersection shows where the two sets have the same value
let setIntersection = set1.intersection(set2)
print(setIntersection)

//difference ->> union minus intersection
let setDifference = set1.symmetricDifference(set2)
print(setDifference)

//set, superset, subset
//subset - derived from original set.
//subset belongs to its superset. they are inverses of each other
print(setIntersection.isSubset(of: setUnion))
print(setUnion.isSuperset(of: setIntersection))

print(setDifference.isSubset(of: setUnion))
print(setUnion.isSuperset(of: setDifference))

print(setIntersection.isSubset(of: setIntersection))

//a dog in my pocket. what could its superset(s) be?
//things in my pocket
//things contained in my pants.
//different types of dogs
//things that are uncomfortable
var thingsThatAreUncomfortable: Set<String> = ["dog", "ian", "bee", "phil", "eric", "michelle"]
var dog: Set<String> = ["dog"]








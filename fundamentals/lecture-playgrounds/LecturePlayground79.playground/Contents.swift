import UIKit

//to get the two diagonals
// if it's the diagonal from the top-left to bottom right, the indexes are equal to each other.
// if it's the diagonal from the top-right to bottom-left, the indexes must add up to one fewer than the count of indexes

var myMatrix: [[Int]] = [[1,3,6,5],[5,7,23,5],[3,2,0,5],[23,5,1,7]]
var topLeftDiagonal = 0
var topRightDiagonal = 0

for (outerIndex, arrayElement) in myMatrix.enumerated() {
    for (innerIndex, intElement) in arrayElement.enumerated() {
        if innerIndex == outerIndex {
            topLeftDiagonal += intElement
        }
        if innerIndex + outerIndex == myMatrix.count - 1 {
            topRightDiagonal += intElement
        }
    }
}
print(topLeftDiagonal)
print(topRightDiagonal)


// Dictionaries!!!
// They're sort of like arrays, but with keys instead of indexes
// That means that they are "unordered" collections

var a: [String:Int] = ["first": 1, "second": 2, "third": 5, "fourth":7, "fifth": 22]
//Syntax: start with square brackets. inside of those, to add key-value pairs, type ****key: value****
var b = (age: 23, dob: 1989)

//Thinking back: in an array we look for the element at an index by using subscripting array[index]
var array = [1,2,3]
array[0]

//in a dictionary we look for a value by subscripting its key
print(a["fiftieth"])
a["fiftieth"] = 44
print(a["fiftieth"])

a["first"] = 43
print(a["first"])

var theMets: [String:String]
theMets = ["Mr Met": "00", "Adam": "07", "David": "Boo"]

print(theMets.count)
theMets["Adam"] = "100"
theMets["Mrs Met"] = "2321"
theMets["Mrs Met"] = nil
theMets["Mrs Met"] = "12345"
var c = theMets["Mrs Met"] == theMets["Adam"]

print(theMets["thisWillBeNil"]?.isEmpty)
print(c)

for value in theMets {
    print(value)
}

for key in theMets.keys {
    print(key)
}

for (k, v) in theMets {
    print(k)
    print(v)
}

//getting a decimal from a Double? what!!!
var deposits: [String: [Double]] = [
    "Williams" : [300.65, 270.45, 24.70, 52.00, 99.99],
    "Cooper" : [200.56, 55.00, 600.78, 305.15, 410.76, 35.00],
    "Davies" : [400.98, 56.98, 300.00],
    "Clark" : [555.23, 45.67, 99.95, 80.76, 56.99, 46.50, 265.70],
    "Johnson" : [12.56, 300.00, 640.50, 255.60, 26.88]
]

var aa = 300.65
var bb = aa.truncatingRemainder(dividingBy: 1.0)
print(bb)



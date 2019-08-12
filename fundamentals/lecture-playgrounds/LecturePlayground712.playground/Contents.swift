import UIKit

/*
 The set S originally contains numbers from 1 to n in ascending order. Unfortunately, due to the data error, one of the numbers in the set was duplicated to another number in the set. This results in the repetition of one number and loss of another number in the set.
 
 You are given an array nums representing the data status of the set S after the error occurred. Your task is to first find the number that occurs twice and then find the number that is missing from the sequence. Return these two values in the form of an array.
 Ex: [1,2,3,3,5]
 */
//Input: Array of numbers - supposed to have numbers in a sequential, ascending order, but some issues caused it to lose one of those sequential values, and duplicate one of the other values

//approach a)
//Find a number that occurs twice in an array of numbers
//Went through a for-loop to find the missing number - for number in the input array, check that the value of that number is equal to its index + 1
//this would show us which number is missing (since the conditional in our loop fails at that value), and there would be a dictionary to see how many times each number exists (with the number as the key, and the frequency as the value). then there was a loop to go through the dictionary, and see where the value of a key is equal to 2, which would mean there is a duplicate of that value

//Output: Array with two values - one value is the number that is duplicated in the input array, and the other value is the number that is missing in that input array.

let itemFrequency =  ["apples":1, "bananas": 4, "corn": 2]
let itemCosts = ["apples" : 3.30, "bananas": 1.23, "corn": 5.23, "dogs": 1.45, "elephants": 542.11]

//shopping cart? wut?
func totalCostOfItems(_ itemsOfEachType: [String:Int], costOfEachTypeOfItem: [String:Double]) -> Double {
    //store the totalCost - sum of all the prices of all the items
    var totalCost = Double()
    for items in itemsOfEachType {
        //go through each item (key) in our shopping cart (itemFrequency or the itemsOfEachType), then look up their price by looking for the key (name of the item) in our manual (itemCosts or costOfEachTypeOfItem)
        //multiply that price by the frequency of the item in our shopping cart.
        //add that to our total cost
    }
    return totalCost
}

var totalAtRegister = totalCostOfItems(itemFrequency, costOfEachTypeOfItem: itemCosts)

func reduceTotalCostByOne(total: Double) -> Double {
    return total - 1
    //different from total -= 1
}

var iForgotToPayOneDollarOfMyBill = reduceTotalCostByOne(total: totalAtRegister)


//function that doesn't return anything
func printA() {
    print("a")
}

func printAVoid() -> Void {
    print("a")
}

func printAEmptyTuple() -> () {
    print("a")
}

//printA()

//functions that return must return for all situations

func returnAorB(someString: String) -> String {
    if someString == "a" {
        return "a"
    }
    return "b"
}

//print(returnAorB(someString: "b"))
//print(returnAorB(someString: "a"))

func returnAOrNothing(someString: String) -> String? {
    if someString == "a" {
        return "a"
    }
    return nil
}

//print(returnAOrNothing(someString: "a"))


func coffeeOrTea(coffee: Bool, amountOfSugar: Int = 1) {
    let choice = coffee ? "coffee" : "tea"
    print("here is your \(choice) with \(amountOfSugar) sugar(s) added")
}

//if sugars == 0 or sugars == nil -> apply to two different things
coffeeOrTea(coffee: true, amountOfSugar: 0)
//can't do this: coffeeOrTea(coffee: true, amountOfSugar: nil)

func coffeeOrTeaSugarOptional(coffee: Bool, amountOfSugar: Int?) {
    let choice = coffee ? "coffee" : "tea"
    if let sugar = amountOfSugar {
        print("here is your \(choice) with \(sugar) sugar(s) added")
    } else {
        print("her is your \(choice)")
    }
}

coffeeOrTeaSugarOptional(coffee: true, amountOfSugar: nil)

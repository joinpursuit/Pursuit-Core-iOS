import UIKit

//print each word in a sentence
//approach 1: using a loop

var sentence = "i didn't eat breakfast"
var space = " "
var currentWord = ""

for character in sentence {
    if String(character) == space {
        var printWord = currentWord
        print(printWord)
        //reset the value of currentWord to ""
        currentWord = ""
        //go to the next character in our loop
        continue
    }
    currentWord += String(character)
}
print(currentWord)

//approach two: using a String method to separate the words into an array
var sentenceArr = sentence.components(separatedBy: " ")

for word in sentenceArr {
    print(word)
}

var sentence = "i didn't eat breakfast"

var sentenceArray = Array(sentence)
print(sentenceArray.last)

print(sentenceArray.count)

//using this array, loop through and print out each word. HINT: words are collections of characters that are separated by a space.

var sentence = "i didn't eat breakfast"
var sentenceArray = Array(sentence)
//This array is ["i"," ","d","i","d","n","'","t"]
var space = " "
var currentWord = ""
var lastIndex = sentenceArray.count - 1

for (index, character) in sentenceArray.enumerated() {
    if String(character) == space {
        print(currentWord)
        currentWord = ""
        continue
    }
    currentWord += String(character)
    if index == lastIndex {
        print(currentWord)
    }
}

//Two Dimensional Arrays!
let array1 = ["some","thing","in","here"]
let array2 = ["thing","in","here","some"]

print(array1 == array2)

let arrayOfArrays: [[String]] = [array1,array2]

print(arrayOfArrays[1][2])
arrayOfArrays[1]
//pulls out -> ["other","stuff","in","here"]

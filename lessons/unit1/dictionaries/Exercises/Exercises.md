### Dictionary Exercises
---

### Question 1.

1a. Create an instance of a dictionary called `citiesDict` that maps 3 countries to their capital cities.

<details>
<summary><b>Solution</b></summary>

```swift
var citiesDict = ["United States": "Washington D.C.", "Great Britain": "London", "France": "Paris"]

```
</details>

1b. Add two more countries to your dictionary.

<details>
<summary><b>Solution</b></summary>

```swift
citiesDict["Italy"] = "Rome"
citiesDict["Japan"] = "Tokyo"
```
</details>

1c. Translate at least 3 of the capital names into another language.

<details>
<summary><b>Solution</b></summary>

```swift
citiesDict["Great Britain"] = "ロンドン"
citiesDict["United States"] = "ワシントンDC。"
citiesDict["Tokyo"] = "東京"

```
</details>

### Question 2.

```swift
var someDict:[String:Int] = ["One": 1, "Two": 4, "Three": 9, "Four": 16, "Five": 25]
```

2a. Using `someDict`, add together the values associated with "Three" and "Five" and print the result.

<details>
<summary><b>Solution</b></summary>

```swift
//With Optional Binding (safe)
if let thirdValue = someDict["Three"],
    let fifthValue = someDict["Five"] {
        print(thirdValue + fifthValue)
}

//Alternative: With Force Unwrapping (not so safe)
print(someDict["Three"]! + someDict["Five"]!)
```
</details>

2b. Add values to the dictionary for the keys "Six" and "Seven".

<details>
<summary><b>Solution</b></summary>

```swift
someDict["Six"] = 34
someDict["Seven"] = 8
```
</details>

2c. Make a key caled "productUpToSeven" and set its value equal to the product of all the values.

<details>
<summary><b>Solution</b></summary>

```swift
var product = 1

for (_, value) in someDict {
    product *= value
}

someDict["productUpToSeven"] = product
```
</details>

2d. Make a key called "sumUpToSix" and set its value equal to the sum of the keys "One", "Two", "Three", "Four", "Five" and "Six".

<details>
<summary><b>Solution</b></summary>

```swift
var sum = 0

for (key, value) in someDict {
    switch key {
    case key where key == "Seven":
        continue
    case key where key == "productUpToSeven":
        continue
    default:
        sum += value
    }
}

someDict["sumUpToSix"] = sum
```
</details>

2e. Remove the new keys made for parts c and d.

<details>
<summary><b>Solution</b></summary>

```swift
someDict.removeValue(forKey: "productUpToSeven")
someDict.removeValue(forKey: "sumUpToSix")
```
</details>

2f. Add 2 to every value inside of `someDict`.

<details>
<summary><b>Solution</b></summary>

```swift
for (key, var value) in someDict {
    value += 2
    someDict[key] = value
}
```
</details>


### Question 3.  
(from http://www.themobilemontage.com/wp-content/uploads/2015/05/hw1.pdf)

3a. Create a variable that is explicitly typed as a dictionary that maps strings to floating point numbers. Initialize the variable to the data shown in the table below which lists an author name and their comprehensibility score.

| Author Name | Score |
| ----------- | --- |
| Mark Twain | 8.9	|
| Nathaniel Hawthorne | 5.1 |
| John Steinbeck | 2.3 |
| C.S. Lewis | 9.9 |
| Jon Krakaur | 6.1 |


<details>
<summary><b>Solution</b></summary>

```swift
var authorScores: [String:Float] = ["Mark Twain":8.9,
                                    "Nathaniel Hawthorne":5.1,
                                    "John Steinback":2.3,
                                    "C.S. Lewis":9.9,
                                    "Jon Krakaur":6.1]
```
</details>

3b. Using the dictionary created in the previous problem, do the following: 

* Print out the floating-point score for “John Steinbeck”. 

<details>
<summary><b>Solution</b></summary>

```swift
if let johnSteinbackScore = authorScores["John Steinback"] {
    print(johnSteinbackScore)
}
```
</details>

* Add an additional author named “Erik Larson” with an assigned score of 9.2. 

<details>
<summary><b>Solution</b></summary>

```swift
authorScores["Erik Larson"] = 9.2
```
</details>

* Write an if/else statement that compares the score of John Krakaur with Mark Twain. Print out the name of the author with the highest score.

<details>
<summary><b>Solution</b></summary>

```swift
if let jonsScore = authorScores["Jon Krakaur"],
    let marksScore = authorScores["Mark Twain"] {
    if jonsScore > marksScore {
        print("John Krakaur has a higher score than Mark Twain")
    } else {
        print("Mark Twain has a higher score than John Krakaur")
    }
}

```
</details>

3c. Use a `for` loop to iterate through the dictionary created in problem 3a and print out the content in the form of **key: value**, one entry per line.

<details>
<summary><b>Solution</b></summary>

```swift
for (key, value) in authorScores {
    print("\(key): \(value)")
}
```
</details>

### Question 4.  
(Questions 4 - 7 Source: https://www.weheartswift.com/dictionaries/) 

4a. You are given a dictionary code of type `[String:String]` which has values for all lowercase letters. The `code` dictionary represents a way to encode a message. For example if `code["a"]` = "z" and `code["b"]` = "x" the encoded version if "ababa" will be "zxzxz". You are also given a message which contains only lowercase letters and spaces. Use the `code` dictionary to encode the message and print it.

```swift
var code = [
    "a" : "b",
    "b" : "c",
    "c" : "d",
    "d" : "e",
    "e" : "f",
    "f" : "g",
    "g" : "h",
    "h" : "i",
    "i" : "j",
    "j" : "k",
    "k" : "l",
    "l" : "m",
    "m" : "n",
    "n" : "o",
    "o" : "p",
    "p" : "q",
    "q" : "r",
    "r" : "s",
    "s" : "t",
    "t" : "u",
    "u" : "v",
    "v" : "w",
    "w" : "x",
    "x" : "y",
    "y" : "z",
    "z" : "a"
]

var message = "hello world"
```

<details>
<summary><b>Solution</b></summary>

```swift
var encodedString = ""

for char in message.characters {
    if char == " " {
        encodedString.append(" ")
    }
    if let encodedChar = code[String(char)] {
        encodedString.append(encodedChar)
    }
}
print(encodedString)
```
</details>

4b. You are also given an `encodedMessage` which contains only lowercase letters and spaces. Use the `code` dictionary to decode the message and print it.

```swift
var encodedMessage = "uijt nfttbhf jt ibse up sfbe"
```

<details>
<summary><b>Solution</b></summary>

```swift
var decodedString = ""

for char in encodedMessage.characters {
    if char == " " {
        decodedString.append(" ")
    }
    for (key, value) in code {
        if String(char) == value {
            decodedString.append(key)
        }
    }
}

print(decodedString)
```
</details>

### Question 5.
5a. You are given an array of dictionaries. Each dictionary in the array contains exactly 2 keys “firstName” and “lastName”. Create an array of strings called `firstNames` that contains only the values for “firstName” from each dictionary.

```swift
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
    ],
    [
        "firstName": "Noel",
        "lastName": "Bowen"
    ]
]
```
<details>
<summary><b>Solution</b></summary>

```swift
var firstNames: [String] = []

for peopleDict in people {
    if let firstName = peopleDict["firstName"] {
        firstNames.append(firstName)
    }
}
```

</details>

5b. Create an array of strings called `fullNames` that contains the values for “firstName” and “lastName” from the dictionary separated by a space.

<details>
<summary><b>Solution</b></summary>

```swift
var fullNames: [String] = []

for peopleDict in people {
    if let firstName = peopleDict["firstName"],
        let lastName = peopleDict["lastName"] {
            fullNames.append("\(firstName) \(lastName)")
    }
}
```
</details>

### Question 6.

6a. You are given an array of dictionaries. Each dictionary in the array describes the score of a person. Find the person with the best score and print his full name.

```swift
var peopleWithScores: [[String: String]] = [
    [
        "firstName": "Calvin",
        "lastName": "Newton",
        "score": "13"
    ],
    [
        "firstName": "Garry",
        "lastName": "Mckenzie",
        "score": "23"
    ],
    [
        "firstName": "Leah",
        "lastName": "Rivera",
        "score": "10"
    ],
    [
        "firstName": "Sonja",
        "lastName": "Moreno",
        "score": "3"
    ],
    [
        "firstName": "Noel",
        "lastName": "Bowen",
        "score": "16"
    ]
]
```

<details>
<summary><b>Solution</b></summary>

```swift
var maxScore = Int.min

for peopleDict in peopleWithScores {
    if let scoreString = peopleDict["score"],
        let score = Int(scoreString) {
        if score > maxScore {
            maxScore = score
        }
    }
}

for peopleDict in peopleWithScores {
    if let scoreString = peopleDict["score"],
        let score = Int(scoreString) {
        if maxScore == score {
            if let firstName = peopleDict["firstName"],
                let lastName = peopleDict["lastName"] {
                print("\(firstName) \(lastName) has the highest score of \(maxScore)")
            }
        }
    }
}
```
</details>

6b. Print out the dictionary above in the following format: ** full name - score **


<details>
<summary><b>Solution</b></summary>

```swift
for peopleDict in peopleWithScores {
    if let firstName = peopleDict["firstName"],
        let lastName = peopleDict["lastName"],
        let score = peopleDict["score"] {
        print("\(firstName) \(lastName) - \(score)")
    }
}
```
</details>


### Question 7.
```swift
var numbers = [1, 2, 3, 2, 3, 5, 2, 1, 3, 4, 2, 2, 2]
```

7a. You are given an array of integers. The frequency of a number is the number of times it appears in the array. Find out the frequency of each one.

<details>
<summary><b>Solution</b></summary>

```swift
//Using if-else
for num in numbers {
    if numFrequencyDict[num] != nil {
        numFrequencyDict[num] = numFrequencyDict[num]! + 1
    } else {
        numFrequencyDict[num] = 1
    }
}

//Alternative: Using ternary operator
/*
for num in numbers {
    numFrequencyDict[num] != nil ? (numFrequencyDict[num] = numFrequencyDict[num]! + 1) : (numFrequencyDict[num] = 1)
}
*/

print(numFrequencyDict)
```
</details>

7b. Print the numbers in ascending order followed by their frequency.


<details>
<summary><b>Solution</b></summary>

```swift
var sortedKeys: [Int] = []
var sortedKeysWithValues: [(Int, Int)] = []

for (key,value) in numFrequencyDict {
    sortedKeys.append(key)
}
sortedKeys.sort()

for num in sortedKeys {
    if numFrequencyDict[num] != nil {
        if let frequency = numFrequencyDict[num] {
            sortedKeysWithValues.append((num, frequency))
        }
    }
}

print(sortedKeysWithValues)
```

</details>

### Question 8.
Print the most common letter in the string below:

```swift
var myString = "We're flooding people with information. We need to feed it through a processor. A human must turn information into intelligence or knowledge. We've tended to forget that no computer will ever ask a new question."
```

<details>
<summary><b>Solution</b></summary>

```swift
var charCountDict: [Character:Int] = [:]
var characterWithHighestCount = ""
var topCharCount = Int.min

for char in myString.characters {
    charCountDict[char] != nil ? (charCountDict[char] = charCountDict[char]! + 1) : (charCountDict[char] = 1)
}

for (key, value) in charCountDict {
    if key != " " && value > topCharCount {
        topCharCount = value
        characterWithHighestCount = String(key)
    }
}

print("The letter \(characterWithHighestCount) has the highest count of \(topCharCount).")
```
</details>

### Question 9.
Write code that creates a dictionary where the keys are Ints between 0 and 20 inclusive, and each key's value is its cube.


<details>
<summary><b>Solution</b></summary>

```swift
var numsAndTheirCubes: [Int:Int] = [:]

for i in 0...20 {
    numsAndTheirCubes[i] = Int(pow(Double(i), Double(3)))
}

print(numsAndTheirCubes)
```
</details>

### Question 10.
Write code that iterates through `testStates` and prints out whether or not that key is in `statePop`.

```swift
let statePop = ["Alabama": 4.8, "Alaska": 0.7, "Arizona": 6.7, "Arkansas": 3.0]
let testStates = ["California","Arizona", "Alabama", "New Mexico"]
```

<details>
<summary><b>Solution</b></summary>

```swift
for state in testStates {
    if statePop[state] != nil {
        print("\(state) exists in statePop!")
    } else {
        print("Could not find \(state) in statePop.")
    }
}
```

</details>




### Logic Exercise Solutions
---

### Exercise 1.
What do each of the following expressions evaluate to?
```swift
a. 3 < 12.3
b. 9 == 2
c. "Hello!" == "Hello!"
d. 19.0 >= 19.0
e. 9 > 7 && 7 < 10
```

<details>
<summary><b>Click Here to Toggle Solution</b></summary>

```swift
a. true
b. false
c. true
d. true
e. true 
```

</details>


### Exercise 2.
What do each of the following expressions evaluate to?
```swift
a. false || true
b. false && true
c. !false
d. !!!true
e. !(true && true)
```

<details>
<summary><b>Click Here to Toggle Solution</b></summary>

```swift
a. true
b. false
c. true
d. false
e. false
```

</details>


### Exercise 3.
What do each of the following expressions evaluate to?
```swift
a. 3 == 2 || 9 == 9
b. !(3 > 3)
c. !(true || false)
d. (4 < 3 || 4 > 3) && ("Message: " == "Message: ")
e. !(3 != 3)
```

<details>
<summary><b>Click Here to Toggle Solution</b></summary>

```swift
a. true
b. true
c. false
d. true
e. true
```

</details>



### Exercise 4.
What do each of the following expressions evaluate to?
```swift
a. !(4 + 3 < 2 * 4)
b. !(1 + 1 != 2) && !(3 >= 3)
c. (3 < 2 || (0 < 1 && 3 >= 3)) && true
d. !!(!!true && !!false)
e. true && (true && (true && (true || false)))
```


<details>
<summary><b>Click Here to Toggle Solution</b></summary>

```swift
a. false
b. false
c. true
d. false
e. true
```

</details>


### Exercise 5.
Identify which variables are correct/incorrect. Change the variable value and/or declaration if it is incorrect.
```swift
a. let nameOfPrincipal: Character = "Mrs. Watkins"
b. var temperatureOutside: Int = 90.7
c. var isSummer: String = false
d. let whiteHouseAddress: Int + String = 1600 + "Pennsylvania Ave"
e. var peopleAtParty: Double = "95"
```

<details>
<summary><b>Click Here to Toggle Solution</b></summary>

```swift
a. incorrect -> let nameOfPrincipal: String = "Mrs. Watkins"
b. incorrect -> var temperatureOutside: Double = 90.7
c. incorrect -> var isSummer: Bool = false 
d. incorrect -> let whiteHouseAddress: String = "1600 Pennsylvania Ave"
e. incorrect -> var peopleAtParty: Int = 95
```

</details>


### Exercise 6.
The following variables are declared, fill in their value in a separate line.
```swift
a. var favoriteVacationSpot: String
b. var timesOnAPlane: Int
c. var amHungry: Bool
d. var middleInitial: Character
e. var twentyFiveDividedByTen: Double
```


<details>
<summary><b>Click Here to Toggle Solution</b></summary>

```swift
a. favoriteVacationSpot = "Hawaii"
b. timesOnAPlane = 0
c. amHungry = true
d. middleInitial = "Y"
e. twentyFiveDividedByTen = 2.5
```

</details>

### Exercise 7.
Mad-Libs. Add a value to the declared variables below. Insert the variables (already in correct order) inside the string  __madLib__ and print.
```swift
var geographicLocation: String
var adjective1: String
var pluralNoun1: String
var adjective2: String
var pluralNoun2: String
var number1: Int
var number2: Int
var articleOfClothing: String

var madLib = "Here is tomorrow's weather report for \()
and vicinity. Early tomorrow, a \()-front will
collide with a mass of hot \() moving from the
north. This means we can expect \() winds and
occasional \() by late afternoon. Wind velocity will
be \() miles an hour, and the high temperature should
be around \() degrees. So, if you're going out, you had
better plan on wearing your \()".
```

<details>
<summary><b>Click Here to Toggle Solution</b></summary>

```swift
var geographicLocation: String = "New York"
var adjective1: String = "cold"
var pluralNoun1: String = "gasses"
var adjective2: String = "strong"
var pluralNoun2: String = "thunderstorms"
var number1: Int = 9
var number2: Int = 56
var articleOfClothing: String = "hoodie"

var madLib = "Here is tomorrow's weather report for \(geographicLocation)
and vicinity. Early tomorrow, a \(adjective1)-front will
collide with a mass of hot \(pluralNoun1) moving from the
north. This means we can expect \(adjective2) winds and
occasional \(pluralNoun2) by late afternoon. Wind velocity will
be \(number1) miles an hour, and the high temperature should
be around \(number2) degrees. So, if you're going out, you had
better plan on wearing your \(articleOfClothing)".
```

</details>


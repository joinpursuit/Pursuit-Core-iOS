### Enumeration Exercises

---

1a. Define an enumeration called `iOSDeviceTypes` with member values `iPhone`, `iPad`, `iWatch`. Create a variable called `myDevice` and assign it one member value.

<details>
<summary><b>Solution</b></summary>
```swift
enum iOSDeviceTypes {
    case iPhone
    case iPad
    case iWatch
}

let myDevice = iOSDeviceTypes.iPhone
```
</details>


1b. Adjust your code above so that iPhone and iPad have associated values of type String which represents the model number, eg: iPhone("6 Plus"). Use a switch case and let syntax to print out the model number of each device.

<details>
<summary><b>Solution</b></summary>

```swift
enum iOSDeviceTypes {
    case iPhone(String)
    case iPad(String)
    case iWatch
}

let myIphone = iOSDeviceTypes.iPhone("iPhone SE")
let myIpad = iOSDeviceTypes.iPad("iPad Pro")

switch myIphone {
case .iPhone(let phoneModel):
    print("I have the \(phoneModel)")
case .iPad(let model):
    print("I have the \(model)")
case .iWatch(let model):
    print("I have the \(model)")
}

switch myIpad {
case .iPhone(let phoneModel):
    print("I have the \(phoneModel)")
case .iPad(let model):
    print("I have the \(model)")
case .iWatch(let model):
    print("I have the \(model)")
}
```

</details>


2. Write an enum called `Shape` and give it cases for `triangle`, `rectangle`, `pentagon` and `hexagon`. Write a method inside that returns how many sides the shape has.  Then assign a variable to `Shape.pentagon` and then print how many sides it has.

<details>
<summary><b>Solution</b></summary>

```swift
enum Shape {
    case triangle
    case pentagon
    case rectangle
    case hexagon
    
    static func countSidesIn(shape: Shape) -> Int {
        switch shape {
        case .triangle:
            return 3
        case .pentagon:
            return 5
        case .rectangle:
            return 4
        case .hexagon:
            return 6
        }
    }
}

let deltaSymbol = Shape.triangle
print(Shape.countSidesIn(shape: deltaSymbol))
```

</details>


3. Write an enum called `OperatingSystems` and give it cases for `Windows`, `Mac`, and `Linux`.  Create an array of 10 `OperatingSystems` where each one is set to a random operating system.  Then, iterate through the array and print out a message depending on the operating system.

<details>
<summary><b>Solution</b></summary>

```swift
enum OperatingSystem: Int {
    case windows
    case mac
    case linux
}

var operatingSystems: [OperatingSystem] = []

for _ in 0...9 {
    let randomRawValue = arc4random_uniform(2)
    if let os = OperatingSystem(rawValue: Int(randomRawValue)) {
        operatingSystems.append(os)
    }
}

for os in operatingSystems {
    switch os {
    case .windows:
        print("I love my PC!")
    case .mac:
        print("Mac are better than anything else!")
    case .linux:
        print("Seriously, who even owns one of these?!")
    }
}
```

</details>


4. You are working on a game in which your character is exploring a grid-like map. You get the original location of the character and the steps he will take.

- A step `.Up` will increase the `x` coordinate by 1.
- A step `.Down` will decrease the `x` coordinate by 1. 
- A step `.Right` will increase the `y` coordinate by 1. 
- A step `.Left` will decrease the `y` coordinate by 1.

Print the final location of the character after all the steps have been taken.

```swift
enum Direction {
    case up
    case down
    case left
    case right
}

var location = (x: 0, y: 0)

var steps: [Direction] = [.Up, .Up, .Left, .Down, .Left]

// your code here

```

<details>
<summary><b>Solution</b></summary>


```swift
enum Direction {
    case up
    case down
    case left
    case right
}

var location = (x: 0, y: 0)

var steps: [Direction] = [.Up, .Up, .Left, .Down, .Left]

for step in steps {
    switch step {
    case .up:
        location.x += 1
    case .down:
        location.x -= 1
    case .left:
        location .y -= 1
    case .right:
        location.y += 1
    }
}

print(location)
```

</details>


5a. Define an enumeration named `HandShape` with three members: `.rock`, `.paper`, `.scissors`.

<details>
<summary><b>Solution</b></summary>

```swift
enum HandShape {
    case rock
    case paper
    case scissors
}
```

</details>

5b. Define an enumeration named `MatchResult` with three members: `.win`, `.draw`, `.lose`.

<details>
<summary><b>Solution</b></summary>

```swift
enum MatchResult {
    case win
    case lose
    case draw
}
```

</details>

5c. Write a function called `match` that takes two `HandShape`s and returns a `MatchResult`. It should return the outcome for the first player (the one with the first hand shape).

> Hint: Rock beats scissors, paper beats rock, scissor beats paper

<details>
<summary><b>Solution</b></summary>

```swift
func match(player1: HandShape, player2: HandShape) -> MatchResult {
    switch player1 {
    case .paper:
        switch player2 {
        case .paper:
            return .draw
        case .rock:
            return .win
        case .scissors:
            return .lose
        }
    case .rock:
        switch player2 {
        case .paper:
            return .lose
        case .rock:
            return .draw
        case .scissors:
            return .win
        }
    case .scissors:
        switch player2 {
        case .paper:
            return .win
        case .rock:
            return .lose
        case .scissors:
            return .draw
        }
    }
}

match(player1: .paper, player2: .rock)
```

</details>


6a. You are given a `CoinType` enumeration which describes different coin values. Print the total value of the coins in the array `moneyArray` which contains tuples of type `(ammount, coinType)`.

```swift
enum CoinType: Int {
    case penny = 1
    case nickle = 5
    case dime = 10
    case quarter = 25
}

var moneyArray:[(Int,CoinType)] = [(10,.penny),
                                   (15,.nickle),
                                   (3,.quarter),
                                   (20,.penny),
                                   (3,.dime),
                                   (7,.quarter)]


// your code here

```

<details>
<summary><b>Solution</b></summary>

```swift
enum CoinType: Int {
    case penny = 1
    case nickle = 5
    case dime = 10
    case quarter = 25
}

var moneyArray:[(Int,CoinType)] = [(10,.penny),
                                   (15,.nickle),
                                   (3,.quarter),
                                   (20,.penny),
                                   (3,.dime),
                                   (7,.quarter)]


var total = 0

for moneyTuple in moneyArray {
    let value = moneyTuple.1.rawValue * moneyTuple.0
    total += value
}

print(total)
```

</details>

6b. Write a method in the `CoinType` enum that returns an Int representing how many coins of that type you need to have a dollar. Then, create an instance of `CoinType` set to `.Nickle` and use your method to print out how many nickels you need to have to make a dollar.

<details>
<summary><b>Solution</b></summary>

```swift
enum CoinType: Int {
    case penny = 1
    case nickle = 5
    case dime = 10
    case quarter = 25
    
    static func findQuantityToMakeDollar(with coin: CoinType) -> Int {
        return 100 / coin.rawValue
    }
}


let nickel = CoinType.nickle
print(CoinType.findQuantityToMakeDollar(with: nickel))
```

</details>

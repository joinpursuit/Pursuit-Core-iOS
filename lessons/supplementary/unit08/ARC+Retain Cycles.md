# ARC + Retain Cycles

### Past Lesson Links

- [Memory Management and Retain Cycles](https://github.com/C4Q/AC-iOS/tree/master/lessons/unit6/MemoryManagement%2BRetainCycles)

### Key Interview Questions

1. What is ARC?

2. What is a Retain Cycle?  Give an example of when one would occur and how to resolve it.


# 1. What is ARC?

ARC stands for Automatic Reference Counting.  It's the process by which iOS cleans up objects that no longer need to be held in memory.  Once an object no longer has anything that references it, it can be taken out of memory.

```swift
class Person {
    var name: String
    init(name: String) {
        self.name = name  
    }
}

var testPerson: Person? = nil
testPerson = Person(name: "Abe")
```

This creates the following picture:

```
(testPerson) --->  New Person Object: "Abe"
```

If we set testPerson to nil again, there is no reason to hold the Person object in memory anymore.  No one is referring to it, so it isn't posslbe for anyone to care about its properties.  Swift (or Objective-C) can then safely deinitialize the Person object.  We can see this happening directly by adding a special method called *deinit*.  Just like *init* is called when we create an object, *deinit* is called when the object is deallocated from memory.


```swift
class Person {
    var name: String
    init(name: String) {
        self.name = name
        print("Initialized person \(self.name)")
    }
    deinit {
        print("Deinitializing person \(self.name)")
    }
}


var myPerson: Person?
myPerson = Person(name: "Abe")
myPerson = nil
```

Abe will also be deinitialized if we reassign myPerson to someone else:

```
var myPerson: Person?
myPerson = Person(name: "Abe")
myPerson = Person(name: "Bart")
```

But if we keep a reference, to Abe somewhere else, then it won't be deinitialized when myPerson is set to nil:

```
var myPerson: Person?
myPerson = Person(name: "Abe")
let alsoAbe = myPerson
myPerson = nil
```

ARC only deallocates an object when it knows that no one else is referring to it.

## Swift Reference Types

There are 3 ways to declare a reference in Swift.  We need multiple reference types to help avoid *retain cycles* which we'll see about in the next section.

```swift
var favoritePerson = Person(name: "Otis Redenbacher") //Strong reference
weak var weakFavorite = favoritePerson  //Weak reference
unowned var unownedFavorite = favoritePerson //Unowned reference
```

### Strong references

Strong references are the default.  They work exactly like in the examples above.  ARC counts the strong references to an object, and deallocates it once that count is zero.

### Weak references

Weak references are a way of making a reference to an object, without it counting towards ARC.  weakFavorite is of the type Person?.  If we reassign favoritePerson to a new Person object, ARC will see that there are no longer any strong references to the Person "Otis Redenbacher".  It will then deallocate the object.  So what will weakFavorite do when we ask it what it's assigned to?

```swift
favoritePerson = Person(name: "James Watkins")
print(weakFavorite)
```

weakFavorite didn't count as a reference to ARC because it wasn't a strong reference.  When the object it was weakly referencing is deallocated, weakFavorte gets set to nil.

### Unowned references

Unowned references are another way of making a reference that doesn't count towards ARC.  Unlike weak variables, unowned variables are not optionals.  If you try to use an unowned variable after the object it was referring to has been deallocated, your app will crash.  Think of it like the force unwrapping of references.  

```swift
print(unownedFavorite) //Will crash if the object unownedFavorite referenced has been deallocated.
```

# 2. What is a Retain Cycle?
 A retain cycle occurs when two objects have strong references to each other.

```swift
class Apartment {
    let name: String
    var tenant: Person?
    init(name: String) {
        self.name = name
        print("Initialized apartment \(self.name)")
    }
    deinit {
        print("Deinitializing person \(self.name)")
    }
}

class Person {
    let name: String
    var apartment: Apartment?
    init(name: String) {
        self.name = name
        print("Initialized person \(self.name)")
    }
    deinit {
        print("Deinitializing person \(self.name)")
    }
}


var john: Person?
var unit4A: Apartment?

john = Person(name: "John Appleseed")
unit4A = Apartment(name: "Unit 4A")

john!.apartment = unit4A
unit4A!.tenant = john

john = nil
unit4A = nil
```

![image](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/referenceCycle01_2x.png)

![image](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/referenceCycle02_2x.png)

![image](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/referenceCycle03_2x.png)

Because both objects have a strong reference to each other, they will stay in memory and not be deallocated.  There is no way for them to leave memory because we no longer have references to them, but they stay in memory because they have strong reference to each other.  How can we resolve this?

```swift
class Apartment {
    let name: String
    weak var tenant: Person?
    init(name: String) {
        self.name = name
        print("Initialized apartment \(self.name)")
    }
    deinit {
        print("Deinitializing person \(self.name)")
    }
}
```

By making the tenant a weak var, that means it will not hold a strong reference, but a weak one.  This means it does not count towards the Person object's retain count.

![image](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/weakReference01_2x.png)

When we set john to nil, we remove all strong references to the Person instance.  The Apartment object holds only a weak reference to the Person, so it doesn't count towards ARC.  The tenant of unit4A is now nil.

```swift
unit4A.tenant == nil
//true
```

When we set unit4A to nil, all strong references to the Aparment instance are removed, because the Person instance has already been deallocated.  By making weak references, we are able to get around creating these retain cycles.

![image](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Art/weakReference03_2x.png)


### Give an example of when one would occur and how to resolve it.

#### Delegation and retain cycles

Delegation is one way that we can create retain cycles, if we are not careful.  If we give our cells a strong reference to our view controller and give our view controller a strong reference to our cells, this will create a retain cycle, and the view controller will never leave memory.

![image link](https://raw.githubusercontent.com/C4Q/AC-iOS/master/lessons/unit6/MemoryManagement%2BRetainCycles/Screen%20Shot%202018-02-14%20at%202.02.06%20PM.png)

We can create a simple application that demonstrates this problem.  Our app will load a list of quotes.  Each quote will have a like button.  Our cells will set a strong reference to the View Controller as its delegate, and the View Controller keeps a strong reference to each cell it is displaying.

Our application will launch on a View Controller in a Navigation Controller that just contains a button.  Selecting the button will segue to our TableViewController.  Selecting back should get rid of that TableViewController, allowing us to press the button again for a new set of quotes.


<details>
<summary> Code to build an example </summary>

## Build the Model

We will get data from "https://talaikis.com/api/quotes/" and display it to the user.

**Quote + QuotesAPIClient**

```swift
struct Quote: Codable {
    let quote: String
    let author: String
    let cat: String
}

class QuotesAPIClient {
    private init() {}
    static let manager = QuotesAPIClient()
    private let endpoint = "https://talaikis.com/api/quotes/"
    func getQuotes(completionHandler: @escaping ([Quote]?, Error?) -> Void) {
        let completion: (Data) -> Void = {data in
            do {
                let quotes = try JSONDecoder().decode([Quote].self, from: data)
                completionHandler(quotes, nil)
            }
            catch {
                completionHandler(nil, error)
            }
        }
        let request = URLRequest(url: URL(string: endpoint)!)
        NetworkHelper.manager.performDataTask(with: request, completionHandler: completion, errorHandler: {print($0)})
    }
}
```

**Network Helper + AppError**

```swift
enum AppError: Error {
    case noData
}

class NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    private let urlSession = URLSession(configuration: URLSessionConfiguration.default)
    func performDataTask(with request: URLRequest, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        self.urlSession.dataTask(with: request){(data: Data?, response: URLResponse?, error: Error?) in
            DispatchQueue.main.async {
                guard let data = data else {errorHandler(AppError.noData); return}
                
                if let error = error {
                    errorHandler(error)
                }
                completionHandler(data)
                
            }
            }.resume()
    }
}
```


## Build the UI

We'll make a Storyboard based application.  Embed the starting ViewController in a Navigation Controller.  Add a button to the ViewController and pin it to the middle.

Create a TableViewController with one prototype cell named "quoteCell".  Inside the prototype cell, add a UILabel and UIButton.  Create a class for the custom cell named QuoteTableViewCell and add an outlet to the label and an action to the button.

**QuoteTableViewCell + QuoteTableViewCellDelegate**

```swift
protocol QuoteTableViewCellDelegate {
    func userLiked(quote: Quote)
}

class QuoteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var quoteLabel: UILabel!
    var delegate: QuoteTableViewCellDelegate?
    
    public func configureCell(with quote: Quote) {
        self.quote = quote
    }
    
    private var quote: Quote! {
        didSet {
            quoteLabel.text = quote.quote
        }
    }

    @IBAction func likeButtonPressed(_ sender: Any) {
        self.delegate?.userLiked(quote: quote)
    }
}
```

## Build our ViewControllers

Our QuotesTableViewController will be powered by an array of Quote objects.

**QuotesTableViewController**

```swift
import UIKit

class QuotesTableViewController: UITableViewController {

    var quotes = [Quote]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadQuotes()
    }
    
    func loadQuotes() {
        QuotesAPIClient.manager.getQuotes{quotes, error in
            if let error = error {
                print(error)
            }
            guard let quotes = quotes else { return }
            self.quotes = quotes
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "quoteCell", for: indexPath) as! QuoteTableViewCell
        cell.delegate = self
        cell.configureCell(with: quotes[indexPath.row])
        return cell
    }
}

extension QuotesTableViewController: QuoteTableViewCellDelegate {
    func userLiked(quote: Quote) {
        print("I Like It!")
    }
}
```

Now that our application is built we can test it out!

</details>

## Visualizing the retain cycle

### Debug Memory Graph

Select the button to get to your quotes list, then click back.  Repeat this process a dozen times or so.  Then click on the "Debug Memory Graph" button at the buttom of XCode right next to the "Debug View Hierarchy" button.

On the left in the Navigator section, you can see all of the objects that are held in memory.  Despite only needing to have one QuoteTableViewController available, they are all visible here in memory!  This means that there is a retain cycle and they will never be deallocated.  The more a user goes back and forth enough, the more memory your app consumes.  This is called a memory leak.

### Instruments

We can also use iOS Instruments to visualize the memory leak.

- Launch Instruments.
- In the profiling template selection dialog that appears, click Allocations.
- Choose your device and app from the target device and process lists.
- Click Choose to create a trace document.
- Click the Record button in the toolbar (or press Command-R) to begin recording.

Use your app normally.

By typing in cell at the search bar on the bottom left, you can see the count of your custom cells increasing as you move push and pop instances of the TableViewController

## Resolving the retain cycle

The fix is fortunately pretty straightforward.  If our cell had only a weak reference to its delegate, that would mean that our ViewController will be deallocated after it's pushed off the stack.

```swift
weak var delegate: QuoteTableViewCellDelegate?
```

We also need to mark our protocol as being a "class" protocol, because you can't have a weak reference to a struct.

```swift
protocol QuoteTableViewCellDelegate: class {
    func userLiked(quote: Quote)
}
```

Run through the visualization steps again to ensure that there is no longer a memory leak.

#### Closures and Retain Cycles

Closures can introduce the same problems as our delegation example above.  Let's say that we are tired of writing our closure in our method, and want to have a method that builds that closure for us.  THe following isn't good practice, but is a simple example of when these issues might occur:

```swift
var quotesCompletionHandler: (([Quote]?, Error?) -> Void)?
    
var quotes = [Quote]() {
    didSet {
        tableView.reloadData()
    }
}
    
override func viewDidLoad() {
    super.viewDidLoad()
    configureCompletionHandler()
    loadQuotes()
}
    
func configureCompletionHandler() {
    quotesCompletionHandler = {onlineQuotes, error in
        if let error = error {
            print(error)
        }
        guard let onlineQuotes = onlineQuotes else { return }
        self.quotes = onlineQuotes
    }
}
    
func loadQuotes() {
    guard let completion = quotesCompletionHandler else { return }
    QuotesAPIClient.manager.getQuotes(completionHandler: completion)
}
```

Note that if you delete the word "self" in the configureCompletionHandler function, you get an error that reads "Reference to property 'quotes' in closure requires explicit 'self.' to make capture semantics explicit"

Closures are able to store values.  We saw this in unit one, by building a counter object.  When we are assigning quotes to onlineQuotes, we want to store the whole view controller, and assign one of its properties to a new value.  We need to grab the entire view controller, because this closure can be passed to other locations.  This is what we do inside loadQuotes: the closure is passed into another class.

If we did not capture the ViewController, we wouldn't have a way of referring to it.  But we have created the same problem as before!  Run the visualization tools to see that we have reitroduced a retain cycle.

Our View Controller has a strong reference to the closure, and the closure has a strong reference to the View Controller.

#### Resolving the Retain Cycle

We can resolve this issue by introducing a *retain list*.  This is a special section at the beginning of the closure where you can list the values that you want to retain.  We can tell Swift that instead of keeping a strong reference to the View Controller, we should instead keep a weak reference.

```swift
func configureCompletionHandler() {
    quotesCompletionHandler = {[weak self] onlineQuotes, error in
        if let error = error {
            print(error)
        }
        guard let onlineQuotes = onlineQuotes else { return }
        self?.quotes = onlineQuotes
    }
}
```

# 3. DSA Review

1. [Rotate Array](https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/646/)
2. [Move Zeros](https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/567/)
3. [Rotate Image](https://leetcode.com/explore/interview/card/top-interview-questions-easy/92/array/770/)
4. [Speak and Say Sequence](https://leetcode.com/explore/interview/card/top-interview-questions-easy/127/strings/886/)
5. [Reverse Digits](https://leetcode.com/explore/interview/card/top-interview-questions-easy/127/strings/880/)
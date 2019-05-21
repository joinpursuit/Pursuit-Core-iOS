# Introduction to Tableviews

### [Project Repo](https://github.com/C4Q/AC-iOS-TableViewIntroduction)

### Readings

1. [Swith TableView Basics - Tutsplus](https://code.tutsplus.com/tutorials/ios-from-scratch-with-swift-table-view-basics--cms-25160)
1.  ["A Closer Look at Table View Cells" - Apple](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/TableViewCells/TableViewCells.html#//apple_ref/doc/uid/TP40007451-CH7)
2. [Protocols - Swift Library Reference](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html)
3. [Storyboards Tutorial Part 1 - RW](https://www.raywenderlich.com/113388/storyboards-tutorial-in-ios-9-part-1)

### References

1.  [`UINavigationController` - Apple Docs](https://developer.apple.com/reference/uikit/uinavigationcontroller)
3.  [`UITableViewController`  - Apple Docs](https://developer.apple.com/reference/uikit/uitableviewcontroller)
4.  [`UITableViewDataSource`  - Apple Docs](https://developer.apple.com/reference/uikit/uitableviewdatasource)
5.  [`UITableViewDelegate` - Apple Docs](https://developer.apple.com/reference/uikit/uitableviewdelegate)
6.  [`UITableView` - Apple Docs](https://developer.apple.com/reference/uikit/uitableview)

### Vocabulary

1. **MVP (Minimal Viable Product)**:  is a product with just enough features to satisfy early customers, and to provide feedback for future development. [MVP - Wiki](https://en.wikipedia.org/wiki/Minimum_viable_product)
2. **`cellForRow`**: shorthand for the `UITableViewDataSource` method `tableView(_:cellForRowAt:)`. Used to describe the cell at a specific `row`/`section` in a `UITableView` - [Docs](https://developer.apple.com/documentation/uikit/uitableviewdatasource/1614861-tableview#)
3. **`reuseIdentifier`**: String value that you use to specify a "prototype" cell in a table. [Docs](https://developer.apple.com/documentation/uikit/uitableviewcell/1623246-reuseidentifier#)
4. **Protocol**: A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality.
5. **Adoption/Conforming**: The process of saying a class, structure, or enumeration will fulfill the blueprint of a protocol. Any type that satisfies the requirements of a protocol is said to conform to that protocol. [Docs](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html)
    - *UITableViewController **adopts** the UITableViewDataSource protocol*
    - *UITableViewController **conforms** to the UITableViewDataSource protocol*
    - These are mostly just synonyms of each other.

---
### 0. Objectives
1. Understand how [`UITableView`s](https://developer.apple.com/reference/uikit/uitableview) efficiently display and manage data in `UITableViewCell`s (["A Closer Look at Table View Cells"](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/TableView_iPhone/TableViewCells/TableViewCells.html#//apple_ref/doc/uid/TP40007451-CH7))
2. Learn how to populate and display data in `UITableView` by way of its delegate protocols (`UITableViewDataSource`,  `UITableViewDelegate`)
3. Further your understanding of protocols ([Swift 4- Protocols](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/Protocols.html))

---

## UITableViewDataSource
In order to get data populated into a table view the following methods are required
```swift
func tableView(_ tableView: UITableView,
cellForRowAt indexPath: IndexPath) -> UITableViewCell
```
and

```swift
func tableView(_ tableView: UITableView,
numberOfRowsInSection section: Int) -> Int
```

### 1. Creating a TableView

How can we display a list of all of the movies that we have?  We could make a label for each movie in our array and set the text of that label equal to the title of the movie.  What might be some problems with this approach?

<details>
<summary>Solution</summary>

- If we want to add more movies later, we'll need to create more and more labels.
- We have no way of handling more labels than we can show on screen at once

</details>

In order to resolve these issues, we will need to look at a new structure, a **UITableView**.  

Go to your Main.storyboard file and go to the *Object Library*.  Drag a TableViewinto your ViewController.  Use Auto Layout to pin your ViewController to the edges of the screen. Change the background color of your View Controller to .blue. Build and run your app.

We now see a blue area with a lines drawn through it.  A good start, but we don't see any data in between the lines.  Let's find out how to hook up our TableView to our Movie data.


### 2. TableView Delegate Methods

Using the Assistant editor, go to your ViewController and and create an outlet to your tableview, named tableView.  

Just like a TextField has delegate methods, so does a TableView.  When the user interacts with our tableview, we want to be able to respond to it.  There are a great number of delegate methods available, all of which are optional.  Let's take a look at one:

- tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)

This delegate method takes two arguments:

- A UITableView representing the tableView that the user interacted with
- An IndexPath representing the row the user selected

The implementation below will print out the row that the user selected.

```swift
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = indexPath.row
        print(selectedRow)
    }
```

But when we try this, nothing we click on makes anything appear in the console.  What's missing?  Our tableView doesn't know how many rows it should have.  Our app shows an "empty" tableView that we can scroll through, but it doesn't actually have any rows set inside of it.  So how can we tell our table view how many rows it has?  For that, we will need to look at another protocol, **UITableViewDataSource** that lists a set of methods to define the data inside the tableView.

### 3. TableView Data Source Methods

A tableView has a *delegate*.  When the user interacts with the tableView, it tells its delegate.

A tableView also has a *dataSource*.  When the tableView wants to know how many rows it has, or what to display in each row, it asks its dataSource.  In order to conform to UITableViewDataSource, the two following methods must be implemented:

1) tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)

>A table view uses *tableView(_:numberOfRowsInSection:)* to ask its data source how many rows it should have.

2) tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)

>A table view uses *tableView(_:cellForRowAt:)* to ask its data source how to configure the cell at the selected row.


We must also must set the dataSource of our tableView to be the instance of the view controller we are currently in.


```swift
override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    //NEW
    tableView.dataSource = self
}
```

We can define those methods with any implementation that we choose.  Below, we are returning a UITableViewCell with the default initializer and stating we want five rows.  Let's rerun our app after implementing the data source methods below.

```swift
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
```

What happens now?  The blue part only takes up the bottom of the screen.  This represents the area that we are not taking up with *our* TableViewCells and is reserved if we want to add more rows later.  As you tap on each lined area, the table view calls delegate.tableView(_:didSelectRowAt:).  We can observe the console to see each row as we select it.

We have created a table view with 5 rows, empty cells, and a printout to the console whenever a row is selected.  Our next step is to populate the cells with some information.

### 4. Populating a Table View


First, we'll need a set of data to fill our tableView with.  

```swift
let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]
```

Now, let's return to our implementation of *tableView(_:cellForRowAt:)*.  Right now we are initializing a default cell and immediately returning it.  Instead, we want to customize our implementation depending on which number row we are looking at.  We want row 0 to be "Monday, row 1 to be "Tuesday" and so on.


There are three properties of a UITableViewCell we have access to:

1. textLabel (the main text)
2. detailTextLabel (the subtitle's text)
3. imageView


```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	let rowToSetUp = indexPath.row
	let dayAtRow = daysOfWeek[rowToSetUp]
	let cell = UITableViewCell()
	cell.textLabel?.text = dayAtRow
   return cell
}
```

Great!  We now can see all the days of the week.  Let's add Saturday and Sunday to our array:

```swift
let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
```

When we rerun our app, we don't see the new elements we've added.  Why is this?

<details>
<summary>Solution</summary>
We are still returning 5 for how many rows are in our table.  Let's update that implementation.
</details>


```swift
func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return daysOfWeek.count
}
```

Now, let's add a *subtitle* to each of our cells.  The subtitle will be the number of the row.

```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
	let rowToSetUp = indexPath.row
	let dayAtRow = daysOfWeek[rowToSetUp]
	let cell = UITableViewCell()
	cell.textLabel?.text = dayAtRow
	cell.detailText?.text = String(rowToSetUp) //New
   return cell
}
```

When we rebuild our app, we notice no change.  Why is this?  The cell we used was a default UITableViewCell().  It has only a textLabel that is visible.  If we want other elements to appear, we must make our own TablViewCell through Interface Builder.

### 5. Prototype Cells

Go to Main.storyboard, and select the tableView inside your ViewController.  

- Under the setting "Prototype Cells" change the 0 to a 1.  Then, select the new area that appears.  
- Change the `Style` from "Custom" to "Subtitle"
- Give the cell a "Reuse Identifier" of "Day Cell"

Return to your ViewController and your tableView(_: cellForRowAt:) method.  Instead of making a generic UITableViewCell, we want to create the cell that we just defined inside our Interface Builder.

```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let rowToSetUp = indexPath.row
    let dayAtRow = daysOfWeek[rowToSetUp]
    let cell = tableView.dequeueReusableCell(withIdentifier: "Day Cell")! //NEW
    cell.textLabel?.text = dayAtRow
    cell.detailTextLabel?.text = String(rowToSetUp)
    return cell
}
```

This here is a "reusable cell".  Right now our list only has 7 elements in it.  If we had a table of 100 elements (like a contacts list) it would be very expensive to create a new view every time.  What we do instead, is create a reusable cell.  When the user scrolls down, the iPhone will take the cells that disappeared from the top, update their text/images and move them to the bottom.


### 6. Sections

Another main way we can configure a TableView is by controlling how many sections our table view has.  By default, it has a single section.  If we want to add more sections, we will need to implement another data source method: **numberOfSections(in:)**

```swift
func numberOfSections(in tableView: UITableView) -> Int {
    return 2
}
```

By implementing this data source method, we now have two sections.  Each of them have the same information right now.  We can make them have separate information by modifying our *tableView(_:cellForRowAt)* method.  Let's make Section One English, and Section Two in Chinese (or whatever language you prefer).

```swift
let daysOfWeek = [["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"], ["星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"]]
```

By remodeling our daysOfWeek as a [[String]], we will make array 0 English and array 1 Chinese.

```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let rowToSetUp = indexPath.row
    let currentSection = indexPath.section //NEW
    let dayAtRow = daysOfWeek[currentSection][rowToSetUp] //NEW
    let cell = tableView.dequeueReusableCell(withIdentifier: "Day Cell")!
    cell.textLabel?.text = dayAtRow
    cell.detailTextLabel?.text = String(rowToSetUp)
    return cell
}

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return daysOfWeek[section].count //NEW
}

func numberOfSections(in tableView: UITableView) -> Int {
    return 2
}

func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    switch section {
    case 0:
        return "English"
    case 1:
        return "Chinese"
    default:
        return "Unknown Language"
    }
}
```

**Exercise:** Add two more languages to your table view.

# Table Views

## Objectives

- Understand what reusing cells does in a Table View

## Resources

- [Cell Duplication](https://fluffy.es/solve-duplicated-cells/)
- [Jayesh Kawli diffable data source](https://jayeshkawli.ghost.io/ios-13-diffable-data-source-for-uitableview-and-uicollectionview/)

# 1. Reusable Cells Motivation

A common iOS interview question might be "Explain what the line below does":

```swift
tableView.dequeueReusableCell(withIdentifier: "myCellID", for: indexPath)
```

You've used this before on projects that you built, but why bother using this API instead of just creating a new Table View Cell?  Consider the following two implementations:

```swift
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserTableViewCell else {
        fatalError("Unexpected reuse identifier")
    }    
    let user = users[indexPath.row]
    cell.configureCell(with: user)
    return cell
}
```

```swift
override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UserTableViewCell()
    let user = users[indexPath.row]
    cell.configureCell(with: user)
    return cell
}
```

In the first version, we implement `tableView(_:cellForRowAt)` with our usual pattern.  In the second, we make a Table View Cell directly.  Both versions will work correctly and load our cells as specified.  So why use the first version?

It takes work to create a Table View cell.  In the second code snippet we create a new `UserTableViewCell` every time we need to display a new cell.  This is not recommended by Apple practices:

> For performance reasons, a table view’s data source should generally reuse UITableViewCell objects when it assigns cells to rows in its > tableView(\_:cellForRowAt:) method

So how does reusing cells work?

# 2. Reusing Table View Cells

![reuseCells](https://iosimage.s3.amazonaws.com/2018/41-solve-duplicated-cell/reuseProcess.png)

The method's name `dequeueReusableCell` gives a hint to the implementation.  Remember that a [queue](https://github.com/joinpursuit/Pursuit-Core-DSA/tree/master/lessons/Queues/ios) is a data structure where the first element to enter is the first element to leave (like a line at a grocery store).  Whenever a Table View cell disappears off the top of the screen, the cell is placed into a queue.  When a new cell needs to be shown to the user, we `dequeue` the cell at the front of the line, then add it to the bottom.  This is why you may see cells have duplicated information: because you didn't clean the cell of its previous information before reusing it.

# 3. Diffable Data Source

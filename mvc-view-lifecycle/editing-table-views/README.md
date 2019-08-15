# Editing UITableViews

# Objectives

# Readings

# 1. Introduction

As we've seen so far, TableViews power a lot of iOS applications.  But not all applications present a static and unchanging list of items.  Many applications allow you to add items of your own, remove items or move and reorder items.

What are some applications you've used that have those features built in?

Today we'll look at how to build TableViews that allow the user to interact with the list directly.

We'll be using the starting repo [here](https://github.com/joinpursuit/Pursuit-Core-iOS-Editing-TableViews) to build an editable list of `ShoppingItems`

# 2. Populating a TableView (review)

Let's rename our ViewController to be called `ShoppingItemsViewController` so that it's more descriptive.

Then, we need to get all of our `ShoppingItems` loaded into a UITableView.  In your `main.storyboard` file, add a TableView and pin it to the edges.  Then create an outlet from it to your `ShoppingItemsViewController`.

Create a Prototype cell for your TableView and set its style to "Right Detail".  Give it a Reuse Identifier of "shoppingItemCell".

Then, implement the code below to populate the TableView

```swift
import UIKit

class ShoppingItemsViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet var shoppingItemsTableView: UITableView!

    // MARK: - Private properties

    private var shoppingItems = [ShoppingItem]()

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureShoppingItemsTableView()
        loadShoppingItems()
    }

    // MARK: - Private Methods

    private func loadShoppingItems() {
        let allItems = ShoppingItemFetchingClient.getShoppingItems()
        shoppingItems = allItems
    }

    private func configureShoppingItemsTableView() {
        shoppingItemsTableView.dataSource = self
        shoppingItemsTableView.delegate = self
    }
}

extension ShoppingItemsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shoppingItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = shoppingItemsTableView.dequeueReusableCell(withIdentifier: "shoppingItemCell") else {
            fatalError("Unknown Reuse ID")
        }
        let shoppingItem = shoppingItems[indexPath.row]
        cell.textLabel?.text = shoppingItem.name
        cell.detailTextLabel?.text = "$\(shoppingItem.price)"
        return cell
    }
}

extension ShoppingItemsViewController: UITableViewDelegate { }
```

![loadedShoppingItems](/images/loadedShoppingItems.png)

# 3. Removing items

Now let's say that we want a user to be able to remove one of the items from our list.  We'll add handling that allows that user to either tap a button, or swipe to delete.

First, let's add UI that enables the user set the TableView into editing mode.

Create a button above your TableView and create an IBAction linked to it called "toggleEditMode".

TableViews have a `.setEditing(:animated)` method where we can enable edit mode.  We can check to see if that mode is currently enabled using the `.isEditing` property.

```swift
@IBAction func toggleEditMode(_ sender: UIButton) {
    switch shoppingItemsTableView.isEditing {
    case true:
        shoppingItemsTableView.setEditing(false, animated: true)
        sender.setTitle("Edit", for: .normal)
    case false:
        shoppingItemsTableView.setEditing(true, animated: false)
        sender.setTitle("Stop Editing", for: .normal)
    }
}
```

![stopEditing](/images/stopEditing.png)

Let's try tapping delete.  Nothing happens!  The UI is there, but we haven't actually told the application how to delete something.  This has to happen in two steps:

1. Remove the item from the underlying array.
2. Remove the item from the TableView


The first step is very important.  If we don't delete the item from the underlying array, then our numberOfRowsInSection method will give us the same number of cells we need to set up.  But if the item is deleted from the TableView, we will crash because there's a mismatch between how many rows we have and how many rows it's expecting.

In order to delete the item, we need to know when the user is trying to delete it.  There is a delegate method that gives us this information:

```swift
extension ShoppingItemsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            shoppingItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        default: break
        }
    }
}
```

![deletingCells](/images/deletingCells.gif)

Note that swipe to delete works even if don't turn editing mode on.

# 4. Adding items

It's great that we can delete elements, but what if we wanted to add new ones? Let's make an addition to our UI that will let up add a new ShoppingItem.  We will also review using Unwind Segues.

In order to make our unwind segue optional show up on storyboard, add the following code to your ShoppingItemsViewController:

```swift
@IBAction func unwind(segue: UIStoryboardSegue) {

}
```

Go back to Storyboard, and make a new button in the top right, and set its type to "Add Contact" to turn it into a plus symbol.

Then, create a new ViewController called CreateShoppingItemViewController that looks like the UI below:

![newVCUI](/images/newVCUI.png)

Click and drag from the Submit button to the red "exit" icon on the top of the CreateShoppingItemViewController.

Then, control click and drag from the yellow icon on the top left of the ShoppingItemsViewController to the red exit icon also on top of the ShoppingItemsViewController and select the option `manualSegue -> unwindWithSegue` that appears.

![img](https://camo.githubusercontent.com/c9b017c5511783183f9b7088a1cebdac823c6fb8/68747470733a2f2f646576656c6f7065722e6170706c652e636f6d2f6c6962726172792f617263686976652f746563686e6f7465732f746e323239382f4172742f746e323239385f5363656e65546f4578697449636f6e2e706e67)

Now, add your outlets to your new VC and have dismiss the VC if the cancel button is pressed.

```swift
import UIKit

class CreateShoppingItemViewController: UIViewController {

    // MARK: - IBOutlets

    @IBOutlet var nameLabel: UITextField!
    @IBOutlet var priceLabel: UITextField!

    // MARK: - IBActions

    @IBAction func cancelButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
```

Return to the ShoppingItemsViewController and complete the unwind segue implementation:

```swift
@IBAction func unwind(segue: UIStoryboardSegue) {
    guard let createItemVC = segue.source as? CreateShoppingItemViewController else {
        fatalError("Unknown segue source")
    }
    if let itemName = createItemVC.nameLabel.text,
        let itemPriceStr = createItemVC.priceLabel.text,
        let itemPrice = Double(itemPriceStr) {
            let newItem = ShoppingItem(name: itemName, price: itemPrice)
            shoppingItems.append(newItem)
            let lastRow = shoppingItemsTableView.numberOfRows(inSection: 0)
            let lastIndexPath = IndexPath(row: lastRow, section: 0)
            shoppingItemsTableView.insertRows(at: [lastIndexPath], with: .automatic)
    }
}
```

![addItem](/images/addItem.gif)

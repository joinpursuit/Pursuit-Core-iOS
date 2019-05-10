# Subclassing UIViews and Nibs (Xibs)

# Objectives

1. Create xib files and instantiate them using Storyboard
2. Use xib files in multiple tableviews / collectionviews

# Resources

1. [Brian Clouser Xib walkthrough](https://medium.com/@brianclouser/swift-3-creating-a-custom-view-from-a-xib-ecdfe5b3a960)
2. [Apple Docs](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/LoadingResources/CocoaNibs/CocoaNibs.html)


# 1. Why subclass a UIView?

When creating projects, we often come accross situations where we want to reuse work that we've already done.  We've seen one example of this already, by having two different view controllers segue to the same detail view controller.  Just as View Controllers can be reused in seveeral different places, so too can Views.  Up until now, we've had to recreate every view from scratch when making View Controllers.  But what if there are common elements between two View Controllers?

<details>
<summary>What would be an example of this?</summary>

A *user profile* view that has an image an a name label right below it.

</details>

Today, we will look into how we can build our own subclasses of UIView, complete with their own AutoLayout.

# 2. What is a an .xib file?

xib stands for "XML Interface Builder".  XML is what powers Interface Builder to do all its magic of hooking up segues, actions and outlets.  xib files used to be called nib files (NeXT interface builder).  Back in the days before iOS 5, there were no Storyboards.  Every view controller would be made in a separate file, and you would indicate the transitions between them using programmatic segues.  Storyboards made it possible for a single file to hold all your Views and View Controllers as well as add the functionality for showing transitions (segues) graphically.

Storyboard solves the issue of having to create xib files ourselves in the majority of cases.  Occassionally, we may want to use the same *view* in multiple diffeernt iew controllers.  Instead of redoing all the work of making our custom view again, we can make a xib file that lays out our custom view and then drag it in to whatever view controllers we want.

# 3. How do I use an .xib file in Storyboard?

Let's make a simple app where we can reuse a view.  Using the Pixabay API, we are going to get a random image from online.  If the user likes it, they can save it.  They can also go to their favorites and look at which image that they have favorited.  Ultimately, we would want to build this as a collection view or table view, but we'll keep it simple for now.

### Create a new Xib File

To begin, click on file -> new file and go to create a new View.  Name it **PixabayView** and click create.  Something that looks like a Storyboard should pop up.  This is your Canvas for working with your custom view.

### Customize your view

Drag in views to configure your view.  We will have:

- A UIImage
- A label below the image with its tags
- A label in the top left showing how many likes the image has

Constrain these views appropriately using auto-layout.  You can configure the Canvas to see what it will look like in different configurations.  In the attributes inspector, change the "Size" from *Inferred* to *Freeform*.  Then, in the size inspector, you can manipulate the width and the height.  You will be able to use this custom View just like any other view that you would drag into Storyboard.

### Create a .swift file to link to your .xib file

Just like with custom tableview cells, we need to have a .swift file that manages our outlets.  Make a new Swift file and call it PixabayView.swift.  This will be where we can configure the code from our custom view.

### Create outlets from your .xib file to your .swift file.

First, you need to select the "File's Owner" button and indicate the .swift file that manages this .xib file.  Select the identity inspector and select the PixabayView.swift file in the dropdown menu.

Create an outlet from **the entire view**.  Name it contentView.

Create outlets to the imageView and two labels.

### Set the initializer in your .swift file to load the Nib

```
Bundle.main.loadNibNamed("PixabayView", owner: self, options: nil)
addSubview(contentView)
contentView.frame = self.bounds
```

These lines will load in the name, then set the content view to be at the forefront of the screen.

### Use you view in Storyboard

Anywhere you want to use your view, just drag in a UIView.  Then in the identity inspector, select PixabayView.


# 4. Reusing TableView Cells

Just like we can create a reusable custom subview, we can create a reusable table view cell.  One example of when this could be useful would be for the Shows homework project.  Instead of creating two separate cells that are layed out identically, you can create one cell and use it twice.


# 5. Creating a Nib to Reuse Cells you create

The process to create a nib for a table view cell is similar to creating a UIView cell.

1. Create an Empty User Interface
2. Drag in a table view cell into the .xib file
3. Configure the table view cell
4. Create a .swift file and drag in your outlets


### Configure the View Controller

Inside the view controller that manages your tableview, you need to link the table view cell .xib and the table view.

```swift
let nib = UINib(nibName: "PixabayTableViewCell", bundle: nil)
self.tableView.register(nib, forCellReuseIdentifier: "Pixabay Cell")
```

You can now deque a cell and downcast it to your custom tableview cell .xib.
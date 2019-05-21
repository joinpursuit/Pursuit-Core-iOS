## Unit 2 Review Guide: 
--

### Actions and Outlets

- **Outlets** are the way in which we can send instructions from a View Controller to the views that it manages.

- **Actions** are ways we can have Views send information back to our View Controller.

To create an outlet or action, control drag from a View in Storyboard to a class.  Select either outlet or action (if it is a UIControl subclass such as a UIButton) and give it a name.  If you are creating an Action, you may want to change the sender to be of the type of the UIControl subclass the action is coming from.


Common Actions/Outlet errors:

- Deleting an outlet from your custom subclass and not from Storyboard
- Not setting the name of the class in Storyboard to the custom UIViewController subclass


### MVC - Model View Controller

- The **Model** is where your data reside.  It powers the central logic of your app.  It is **UI Independant** and includes any custom classes/structs you use to represent objects (e.g Song, Movie, GOTEpisode)

- The **View** layer is the face of your app.  It represents the actual Views that are displayed to the user and is the means by which the user enters input.

- The **Controller** mediates between the view and the model.  The main two ways in which it does this are **target-action** and **delegation**.

### Protocols & Delegation

A **protocol** is a collection of properties and methods. Protocols can be adopted by classes, structs and enums. In order for another class to adopt/conform to a protocol, it must provide its own implementation for all of the properties and methods defined inside of the protocol.

**Delegation** is a pattern in which one object in a program acts on behalf of, or in coordination with, another object.  For example, when we create a text field, we assign a view controller as its delegate.  When the text field is interacted with, it informs its delegate (whoever it may be).  The delegate then handles that activity.


### Auto Layout 

Auto Layout is the process by which iOS dynamically calculates how to 
set up the views inside its view hierarchy.

In order for Auto Layout to work, there must be a continuous set of contstaints from the top to the bottom, and from the leading (left) to the trailing (right) edges of the main view.  Additionally, every view needs:

- A hight
- A width
- An x position (horizontal)
- A y position (vertical)

Common Auto Layout errors:

- Two views constrained to each other with ambigousity about their relative sizes
- Too few constraints (e.g not setting the height of a view)
- Too many constraints (e.g setting the height of a view to 200 and also pinning it to the top and bottom of its superview.
- Two labels constrained to each other without setting hugging priority or compression resistance

### TableViews

There are 2 ways we can create a table view

1. Using a ViewController
2. Using a TableViewController

#### View Controller

- Create a Table View
- Create an outlet from your Table View into your ViewController
- Assign the delegate of the Table View to the instance of the View Controller
- Assign the data source of the Table View to the instance of the View Controller
- Implement the 2 required data source methods: numberOfRows and cellForRowAt

#### TableVIewController

- Create a TableViewController in Interface Builder
- Create a new Cocoa Touch Class that subclasses from UITableViewController
- Implement the 2 required data source methods: numberOfRows and cellForRowAt



### Custom Table View Cells

To customize a Table View Cell:

1. Set the number of prototype cells from 0 to 1
2. Set the cell type to Custom
3. Configure your cell using Auto Layout
4. Create a subclass of UITableViewCell
5. Change the name of your cell in Storyboard in the identity inspector to the name of the subclass
6. Create outlets and actions as necessary
7. When dequeuing your cell in your Data Source, downcast it to your custom UITableViewCell

### Customizing TableViews: Search bar

To create a Search Bar:

1. Drag a Search Bar into your main View and configure it with Auto Layout.
2. Create an outlet from your Search Bar to your View Controller
3. Assign the delegate of your Search Bar to your View Controller
4. Create an optional String that represents the search term.  Add a property observer that reloads the tableview data when the String changes
5. Reconfigure your model to include a property called filteredArr.  Have that be a computed property that either returns the original array or the original array filtered by a given condition.
6. Add appropriate delegate methods that will modify the searchTerm

### Life Cycle & Controls 

![Life Cycle](https://camo.githubusercontent.com/99eb0236dc45072b16e5abb76b822b7d7b3962e1/68747470733a2f2f646576656c6f7065722e6170706c652e636f6d2f6c6962726172792f636f6e74656e742f7265666572656e63656c6962726172792f47657474696e67537461727465642f446576656c6f70694f534170707353776966742f4172742f575756435f76636c6966655f32782e706e67)

- **viewDidLoad()**

Called when the view controller’s content view (the top of its view hierarchy) is created and loaded from a storyboard. The view controller’s outlets are guaranteed to have valid values by the time this method is called. Use this method to perform any additional setup required by your view controller. Typically, iOS calls viewDidLoad() only once, when its content view is first created; however, the content view is not necessarily created when the controller is first instantiated. Instead, it is lazily created the first time the system or any code accesses the controller’s view property.

- **viewWillAppear()**

Called just before the view controller’s content view is added to the app’s view hierarchy. Use this method to trigger any operations that need to occur before the content view is presented onscreen. Despite the name, just because the system calls this method, it does not guarantee that the content view will become visible. The view may be obscured by other views or hidden. This method simply indicates that the content view is about to be added to the app’s view hierarchy.

- **viewDidAppear()**

Called just after the view controller’s content view has been added to the app’s view hierarchy. Use this method to trigger any operations that need to occur as soon as the view is presented onscreen, such as fetching data or showing an animation. Despite the name, just because the system calls this method, it does not guarantee that the content view is visible. The view may be obscured by other views or hidden. This method simply indicates that the content view has been added to the app’s view hierarchy.

- **viewWillDisappear()**

Called just before the view controller’s content view is removed from the app’s view hierarchy. Use this method to perform cleanup tasks like committing changes or resigning the first responder status. Despite the name, the system does not call this method just because the content view will be hidden or obscured. This method is only called when the content view is about to be removed from the app’s view hierarchy. viewDidDisappear()—Called just after the view controller’s content view has been removed from the app’s view hierarchy. Use this method to perform additional teardown activities. Despite the name, the system does not call this method just because the content view has become hidden or obscured. This method is only called when the content view has been removed from the app’s view hierarchy.


# Open Review Questions

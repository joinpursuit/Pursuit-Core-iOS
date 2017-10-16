# Building Apps with MVC Design


### Readings

- Swift Programming: The Big Nerd Ranch Guide, Chapter 26 page 353
- [Apple Documentation, Model-View-Controller](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html)
- [Understanding MVC In Swift](https://learnappmaking.com/model-view-controller-mvc-swift/)
- [MVC For Beginners](http://www.seemuapps.com/swift-model-view-controller-mvc-beginners)

# 1. Assessment One Review

# 2. App development review

- UIViewController
- UIView
- UILabel: UIView
- UIButton: UIControl
- View hierarchy
- viewDidLoad()
- IBAction
- IBOutlet


Warmup project: Create a "Flashlight app".  Make a button that switches the background from black to white or from white to black.



# 3. MVC Design

Why not just have the View also execute all the code we want to run?

To better understand that, we need to take a look at the primary **design pattern** with iOS apps.


MVC stands for Model, View, Controller.

![MVC](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/model_view_controller_2x.png)


The **Model** encapsulates the underlying data to the application.

The **View** is the UI of an app and what the user can interact with.

The **Controller** mediates between the View and the Model.


The guiding principle behind this organization is that we want to separate out the Model and the View.  Ideally, the Model and the view don't communicate directly with each other, but through the intermediary of a Controller.

With our color selection app yesterday, we mixed together UI and logic elements together.  While this works for small apps, when you have more complicated programs, you want to ensure that its organized in a way that's sensible.


# 4. MVC In depth

The following slides are from Paul Hegarty's Stanford iOS class:

[Slides](file:///Users/c4q-ac01/Downloads/Lecture%201.pdf)


# 5. Creating an app with MVC


Let's go through an example of creating an app in accordance with MVC design patterns.


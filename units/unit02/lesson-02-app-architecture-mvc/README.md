# Building Apps with MVC Design

### Readings

- [Apple Documentation, Model-View-Controller](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html)
- [Understanding MVC In Swift](https://learnappmaking.com/model-view-controller-mvc-swift/)
- [MVC For Beginners](http://www.seemuapps.com/swift-model-view-controller-mvc-beginners)

# 1. App development review

- UIViewController
- UIView
- UILabel: UIView
- UIButton: UIControl
- View hierarchy
- viewDidLoad()
- IBAction
- IBOutlet


Warmup project: Create a "Flashlight app".  Make a button that switches the background from black to white or from white to black.


# 2. MVC Design

Why not just have the View also execute all the code we want to run?

To better understand that, we need to take a look at the primary **design pattern** with iOS apps.


MVC stands for Model, View, Controller.

![MVC](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Art/model_view_controller_2x.png)


The **Model** encapsulates the underlying data to the application.

The **View** is the UI of an app and what the user can interact with.

The **Controller** mediates between the View and the Model.


The guiding principle behind this organization is that we want to separate out the Model and the View.  Ideally, the Model and the view don't communicate directly with each other, but through the intermediary of a Controller.

With our color selection app yesterday, we mixed together UI and logic elements together.  While this works for small apps, when you have more complicated programs, you want to ensure that its organized in a way that's sensible.


# 3. Creating an app with MVC


Let's go through an example of creating an app in accordance with MVC design patterns.

We are going to make an app similar to what we saw yesterday that will change the background color.  We will start by putting together what will comprise the **View**

### Create the view

- Create a label that reads "The background color is"
- Create a label that reads "Grey" and put it right below the top label
- Create a view and set its backgroundColor to .grey
- Create a button with a title of "Random Color"
- Create a button with a title of "Next Color"

Our app will go through a list of colors and show them in the same order every time.  We can disrupt this by selecting "Random Color" which will choose a color at random.  When we click "Next Color" again, it will resume our order from before.

Example
>colors = [.blue, .red, .green, .white]
>
>nextColor
>
>//.blue
>
>randomColor
>
>//.white
>
>nextColor
>
>//.red

We now have most of our view set up.  

### Create the controller

We now need to set up our **Controller** so that it can change our Views.


**Exercises:** 

- Add an outlet from your label to your ViewController
- Add an outlet from you view to your ViewController
- Add an action from your random color button to your ViewController
- Add an action from your next color button to your ViewController


Now we have our Controller set up to manage the Views and handle the actions we get from the buttons.

### Create the model

Now we have to think about what logic will dictate our code.

The best way to conceptualize this is to start by making our Model as a new file, named ColorChangingModel.swift.

Now, consider what the **public API** will be.

API stands for Application Programming Interface, and here it just means what will the Controller need to get from the model.

Our public API will have two methods:

- getNextColor() -> UIColor
- getRandomColor() -> UIColor

Our Controller doesn't need to know what the full sequence is or how we are selecting our random color.  It only needs answers when it asks for the next color or a random color.

Everything else we write in our model we want to be *private*.  We can do this by using the `private` keyword.  This means that our ViewController won't even be able to access these properties and methods.  This is a good thing.  We don't want to give it access to anything except what it needs.

**Exercise** Build private methods and properties to complete the implementation of your model

### Complete your Controller

We now need an instance of our colorChangingModel inside our Controller.  Let's set that as a property.

**Excercise**: Complete the implementations in your button Action methods.


Now you've made your first app using MVC design patterns.  What might be an advantage for using MVC in this app? 


# 4. Practice:

**Exercise**: Refactor your ThreeCardMonte from yesterday to use MVC design patterns.  What should the model look like? 

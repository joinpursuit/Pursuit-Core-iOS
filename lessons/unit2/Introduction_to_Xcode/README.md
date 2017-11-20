# Introduction to iOS Development in Xcode

### [Project Repo](https://github.com/C4Q/AC-iOS-ThreeCardMonteExercise)

It's now time to get into the world of iOS development.  We have built apps for command line and for experimented with different types in Playground.  Now we will enter the iOS section of the environment and see how we can be creating apps of our own.  Let's start by making a new Project in Xcode.

- Select a Single View Application
- For the Project Name, enter "My First App"
- Save the project in your Projects folder

You should now see a screen that looks like this:

![Xcode map](https://codewithchris.com/img/xcodetutorial/xcode_7_workspace_diagram.jpg)

In the Navigator area, select the AppDelegate.swift and LaunchScreen.storyboard using command click.  Right click, then select "New Group from Selection" and name that file "Supporting Files".  This is just to clean up what you are looking at.

Go to the Toolbar, and select iPhone 6s.  Then hit the play button.

(Note, this might take a while)

Congrats!  You made your first app!  It's a blank white screen, but it's a totally functioning app.

Let's see how we can make it a little more interesting.

# 1. Storyboard

Click on the Main.storyboard file.  You know are in the **Interface Builder** and can edit the UI of your app.  Interface Builder is incredibly powerful and you can make many components of your app there.  Let's play with a couple features.

Click on the main rectangle.  This is the screen that the user sees, called the **ViewController**.  It's called a view controller because it controllers the view that is displayed to the user.

Look over to the right in the **Utility Area**  If it is not selected already, select the **Attributes Inspector**.  There are a variety of different options here. Select the attribute "Background Color" and change it to your favorite color.  Then click the play button again in the Toolbar and rerun your app.

Now our app can be any color we like!  But it is just a background color.  Let's add some more features.


# 2. UIView and Subclasses

Return to the storyboard and select the main view.  Click on the **Identity Inspector** in the Utility Area.  Notice that the class is listed as **UIView**.  

Remembering back to when we learned about classes, UIView is a key class in UIKit.  Many of the UI elements that we use will inherit from UIView.  Here are some properties of UIView that will be helpful to us:

1. backgroundColor: UIColor?
2. isHidden: Bool
3. tag: Int

**backgroundColor** is an Optional UIColor that determines the background color of the view

UIColor is an enum that has common colors as its cases.  You can also use the tool we saw before in the Attributes Inspector to select any RGB color that we want.

**isHidden** is a Bool that sets whether or not the view is hidden from the user.  This appears as a checkbox in the Attributes Inspector

**tag** is an Int that provides a quick way to refer to a view.  You can tag views you create with an Int to be able to refer to them later.

# 3. UILabel

Now we want to add some more information to our app.  Let's say we want to have some text displayed to the user.

In the **Utility Area** select the **Object Library**.  We want to create a label, so type *label* into the search bar.  Then, drag and drop the label into the center of your app.  You can use the blue gridlines to know if it is being placed in the center.  We'll learn much more robust ways of organizing our UI when we get to Autolayout next week.

Click on the label and change the text to a different message, then click play and run your app.  Now you can display text as well!

Let's look a little more in depth into our label.  Clicking back to the Attributes Inspector, we can see all the ways we can manipulate our label.  Some key properties are:

1. text: String
2. textAllignment: NSTextAlignment
3. textColor: UIColor!

We can set the text proporty by double clicking the label or by editing it in the attributes inspector.  We can also set the textColor just like we set the background color of our main view.

textAllignment is an enum, but one with a strange name.  The "NS" refers to [NeXTSTEP](https://en.wikipedia.org/wiki/NeXTSTEP) which previous source of iOS which Objective-C.  Anything marked NS is a holdover from earlier, which means you should be on the lookout for unusual behavior.  We'll talk much more about NS marked classes throughout the program.

We also we see that there is a section marked `View` below that has all of the same properties we just saw in UIView.  Why do we see those same properties in our UILabel?

<details>
<summary>Solution</summary>
UILabel inherits from UIView, which means it inherits all of its properties.
</details>



# 4. Subviews and Superviews
There are two more key propeties of UIView that we will discuss today:

1. subviews: [UIView]
2. superView: UIView?

To better understand them, lets look at another tool in Xcode.

Right above the Debug area, to the left of the message "View as: iPhone 8", select the **Document Outline**

We have our View and underneath the view we can see our textLabel makred with an "L".

**For our View:**
view.subviews is an array with our label
view.superView is nil


**For our Label:**
label.subviews is an empty array
label.superView is our view

The way that the views are nested is known as the **view hierarchy**

Let's add some more views and work them into the view hierarchy.

Go to the Object Library and type UIView in the search bar.  Drag in a new UIView to the middle of the screen.  What happens and why?

<details>
<summary>Solution</summary>
Our text label is not visible because we've put another view on top of it at the same level.
</details>

In order to set up our UI properly, we need to add the label as a subview of the new view that we've created.  Set that up and rerun your app.

# 5. UIButton

Now we can have an app that displays some information to the user.  But everything that we have so far is static.  It would be great if we could give the user a chance to interact with what we've made.  We will see how we can add logic with a button.

Let's change the text to read "The background color is blue".

Now let's add a button that will let the use change the background color to something else.

### Button Attributes

Let's take a look at our Button in the Attributes Inspector.  We have some button-specific attributes:

- text: String
- buttonType: UIButtonType
- currentImage: UIImage?
- currentBackgroundImage: UIImage?

The text for a button works just the same as it does in a label.

The buttonType is a way of setting certain defaults of a button.  Change the type to `Custom` so it will work with images later on.

Preview for later

> We can also set a background image and a primary image for buttons.  To do this, we use the functions:
> 
> - myButton.setImage(\_:for:_)
> - myButton.setBackgroundImage(\_:for:_)
> Or set them in the Attributes Inspector

We'll take a look at images a little later.

### UIButton inherits from UIControl

Underneath the Button section, we see a section named "Control".  UIButton inherits from UIControl which inherits from UIView.  A Control is something like a switch or a button that the user can toggle.  The main control we will use is:

- isEnabled: Bool

Disabling a button means that the user can't click on it anymore.

### UIControl inherits from UIView

Finally, under "Control" we see the familiar View options.  We can set a buttons background color, tag and isHidden just like we could with any other view.

Let's set the text of the button to "Red" and the textColor to .red with the intention of changing the background color to red when the user clicks on the button.  Now let's rerun the app.

# 6. ViewController and Target Action

Unfortunately, our button didn't do anything.  And how could it?  We know that it should change the background color, but we haven't told our button that.  And we also didn't see any options in the Attributes Inspector for how to set that.  We'll need to add that functionality in code.

Select the **Assistant Editor** in the **Toolbar**

You should now see your Storyboard on the left and code on the right.  Your code should be in the ViewController.swift file.  If it didn't find it automatically, use the menu at the top to to navigate there.

### What is a ViewController?

Simply put, a ViewController is a class that controllers a View.  Every ViewController has a property

- view: UIView!

that represents the view inside the rectangle we worked with in Storyboard.  Instead of writing code inside that View, so write it inside the ViewController.  This way, we could re-use the same ViewController for different views later.  This also connects directly with MVC design which we'll discuss tomorrow.

Let's start by deleting all the code inside of it.  We'll get into what it does later.


### Target Action

We now want to make our button actually *do* something.  We will make use of what is called the *target action* pattern.  Our ViewController will be informed when our button is clicked and then we can execute a block of code.  Think of it like our View shooting an arrow over to the block of code we will write in our ViewController.


![Target Action](http://4.bp.blogspot.com/-n9uOOnZjadQ/UatUfFQcK8I/AAAAAAAADlc/24A_tVXcQio/s1600/Action+-+Target.png)


The Action is the user pressing the Button, and the Target is the code we are about to write.


### IBAction

Control click on your button, then drag your cursor over inside your ViewController.

A context menu will appear and give you a few options.  Change the *Connction* to *Action* as this is part of our Target-Action pattern.  Then change the *Type* to UIButton, because a button is sending this action over.  Finally, set the *Name* to "colorChangeButtonPressed".

We now have our Action function defined.  We see a new keyword in the definition:

```swift
@IBAction func colorChangeButtonPressed(_ sender: UIButton) {
        
}
```

@IBAction stands for Interface Builder Action.  Interface Builder is the name of the program where we've been working with our Main.storyboard file.  The @ is a little bit of magic that helps connect the ViewController.swift file with the Main.storyboard file.

Now we can define our function.  We want to change the background color of the View that our ViewController controllers to red

```swift
@IBAction func colorChangeButtonPressed(_ sender: UIButton) {
	self.view.backgroundColor = UIColor.red        
}
```

Let's rerun our app now.

Great!  We've now changed our background color to .red.  We've still got a bug though, we didn't change the text in the middle of the screen.  Let's go ahead and fix that now.

# 7. Outlets

What we need to do first is to find a way to talk to our Label inside of our ViewController.  We want to add an *outlet* to our ViewController so that we can refer to other views directly.  We could access it by diving into self.view.subViews, but it's better to access it directly.

We add an Outlet the same way we added an IBAction.  Control click on the label, then drag into your ViewController.  Keep all properties as they are, and enter the name "displayLabel".   The declaration looks fairly similar to our Action before:

```swift
@IBOutlet weak var displayLabel: UILabel!
```

IBOutlet means Interface Builder Outlet.

This is a `weak` variable that is an Optional UILabel.  It's `weak` and Optional due to memory reasons, because our ViewController doesn't exist immediately, the app needs to set it up for us.  We don't need to worry about that right now.  Treat it as a regular variable for now.

Now that we have a way of talking about our label, we want to update it.

**Exercise**: Fix the text to update appropriately.  Then test your solution.

<details>
<summary>Solution</summary>

```swift
@IBAction func colorChangeButtonPressed(_ sender: UIButton) {
        self.view.backgroundColor = UIColor(named: "red")
        self.displayLabel.text = "The background color is red"
}
```
</details>

# 8. Linking multiple buttons

So far so good!  We can change the color to red and our label updates accordingly.  But now it's stuck at red forever.  We want to be able to go back!  And it would be great if we had another option as well.

**Exercise:**: Add a button that will change the background color to blue and update the label.  Then add a button that will change the background color to green and update the label.


<details>Solution to review after
<summary>Solution</summary>

```swift
@IBAction func colorChangeButtonPressed(_ sender: UIButton) {
    guard let buttonText = sender.currentTitle else {
        return
    }
    let newColor: UIColor?
    switch buttonText {
    case "red":
        newColor = .red
    case "green":
        newColor = .green
    case "blue":
        newColor = .blue
    default:
        newColor = nil
    }
    self.view.backgroundColor = newColor
    self.displayLabel.text = "The background color is \(buttonText)"
}
```
</details>


In the solution above, we saw how we can use the currentTitle property to set the color.  But what if the titles were something else?  Our code right now depends on those titles being exactly correct.  If we needed to capitlize the labels, our code would break.  Let's make it a little more flexible:

**Exercise**: Refactor your code to use the tag property.

<details>
<summary>Solution</summary>

```swift
@IBAction func colorChangeButtonPressed(_ sender: UIButton) {
    let newColor: (color: UIColor?, name: String)
    switch sender.tag {
    case 0:
        newColor = (.red, "red")
    case 1:
        newColor = (.green, "green")
    case 2:
        newColor = (.blue, "blue")
    default:
        newColor = (nil, "error")
    }
    self.view.backgroundColor = newColor.color
    self.displayLabel.text = "The background color is \(newColor.name)"
}
```
</details>


# 9. Adding Image Assets

Let's make our buttons a little more exciting by adding image assets.

Download the following images to your desktop with the following names

- [redImage](https://www.organicfacts.net/wp-content/uploads/2013/05/Pomegranate11.jpg)
- [greenImage](https://www.freshfruitportal.com/assets/uploads/2013/05/limes_74531311.jpg)
- [blueImage](https://media.licdn.com/mpr/mpr/AAEAAQAAAAAAAApmAAAAJDg3YjBkMzIwLTdmNGUtNDVhYi04NmRiLTBkM2U2M2I5ZjJkMw.jpg)

Return to Xcode and select on the folder *Assets.xcassets*

Drag your images right below the AppIcon label.

Delete the text for each image, then change the backgroundImage to be from the appropriate color.  Shrink the images down so they don't take up the whole screen.  Now you have image assets in your app!

If you want to set the image based on an action use the following two functions:

> - myButton.setImage(\_:for:_)
> - myButton.setBackgroundImage(\_:for:_)


# 10. override viewDidLoad()

We will talk much more about the **lifecycle** of a ViewController.  For now, if you want to run some code when your app loads for the first time, override the function viewDidLoad() and write your code inside.

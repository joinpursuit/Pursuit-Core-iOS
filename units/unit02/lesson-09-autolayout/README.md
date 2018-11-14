# Auto Layout

### Readings

- [Apple Documentation](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/WorkingwithConstraintsinInterfaceBuidler.html)
- [raywenderlich](https://www.raywenderlich.com/160527/auto-layout-tutorial-ios-11-getting-started])
- [weheartswift](https://www.weheartswift.com/auto-layout-101/)



### Objectives

- Make an app that has a good UI on any sized device
- Make an app that supports rotation
- Use Autolayout in Interface Builder
- Create StackViews
- Build an app matching an image




# 1. The case for Autolayout

Open up any app that you have built in class so far.  Rotate it.  What happens?


We probably need to come up with something better.


Let's make a new project called AutoLayout to see how we can build an app that handles rotation and multiple different devices.

- Position a UIView in the center of the screen.  Use the blue alignment guides to center it.

![rect](https://raw.githubusercontent.com/C4Q/AC-iOS/master/lessons/unit2/AutoLayout/images/blueRect.png)

Run your app and rotate it.  Is the view still in the center?

The guidelines can only take us so far.  If we control the type of phone that we are running on, we can make the UI look good, but users of our apps will be using iPhones of all different sizes.  

# 2. Allignment Constraints

Let's make it so that our rectangle is always in the middle of the screen.  How can we do that?  There are 3 different ways we can configure autolayout in Interface Builder:

1. The ```Allign``` menu
2. The ```Add New Constraints``` menu
3. Control dragging a view to itself or another view


Let's constrain our blue View using each of those methods.

### Using the Allign Menu

<details>
<summary>Allign</summary>

![rect](https://raw.githubusercontent.com/C4Q/AC-iOS/master/lessons/unit2/AutoLayout/images/allignment.png)

</details>


Setting constraints in the allign menu serves to allign multiple views to the same constraints.  Because we only have one view right now, we can only chose to allign it to its superview, the main view of the ViewController.

Select  ```Horizontally in Container``` and ```Vertically in Container```, keeping the number at zero.  This will set the view to be in the center both horizontally (left and right) and vertically (up and down).  Click ```Add Constraints```

What happens?  We get an error!

<details>
<summary> Image </summary>

![rect](https://raw.githubusercontent.com/C4Q/AC-iOS/master/lessons/unit2/AutoLayout/images/error1.png)

</details>


To investigate this error, click on the red arrow at the top right of the Document Outline.

<details>
<summary> Image </summary>

![rect](https://raw.githubusercontent.com/C4Q/AC-iOS/master/lessons/unit2/AutoLayout/images/error2.png)

</details>


It tells us that we are missing two constraints.  We don't have constraints set for its width, or its height.  When we didn't have any constraints, our app knew what to do.  What's different now?

When we don't use Auto Layout, it automatically sets the width and height to be whatever it is on the interface builder.  When we use Auto Layout, we need to explicitly tell our view how tall and wide it should be.  How can we set that?  Using the ```Add New Constraints Menu```
 

### Using the Add New Constraints Menu

<details>
<summary> Add New Constraints </summary>


![Allign](https://koenig-media.raywenderlich.com/uploads/2017/08/xcode-help-align.png)
source: www.raywenderlich.com

</details>

We now have our view centered and we need to set its width and height.  One way that we can do that is by adding constraints to its nearest neighbors.  We only have one view, so its nearest neighbors on all sides are the edges of the screen.  Change the top and bottom values to 200 and the left and right values to 50.  Select all four constraints around the center (they look like red I-beams).  Then click add constraints.


<details>
<summary> More errors! </summary>

![errors](https://raw.githubusercontent.com/C4Q/AC-iOS/master/lessons/unit2/AutoLayout/images/error3.png)

</details>

What now?  We tried to give it a width and height by constraining it to its nearby neighbors, but we get more errors.  This brings us to the most important section of Auto Layout.

# 3. Resolving Conflicting Constraints


What happens if we try to add impossible constraints to our view?


Auto Layout sees these constraints and realizes that it has no way to satisfy all of them.  When this happens, it gives you an error in the document outline.  You can still build and run your app, but it will chose to ignore constraints until it finds a way to present your app.  This will cause unpredictable behavior, because you don't know what constraints it will break.  For this reason, we make sure that there are no Auto Layout errors when we finish our Storyboard.

In our app, we have conflicting constraints that are very subtle.

- View.centerY = centerY
- Safe Area.bottom = View.bottom + 200
- View.top = Safe Area.top + 200

These constraints can be read like *equations*.  Unlike a coordinate plane, the origin (0,0) is at the top left.

- The first constraint tells us that the center of our view horizontally is the horizontal center of its superview.
- The second constraint says that the *Safe Area*'s bottom is 200 points below our view.
- The third constraint says that the *Safe Area*'s top is 200 points above our view.

Why are these in conflict?  It's because the *Safe Area* is different than our views superview.

### [Safe Area](https://developer.apple.com/documentation/uikit/uiview/2891102-safearealayoutguide)

The Safe Area is "the portion of the view that is not covered by navigation bars, tab bars, toolbars, and other ancestor views".

This means that some of the top area is reserved for other elements and we should constrain things by the Safe Area.

Notice that we neglected to do that when centering our view vertically.  It didn't even show up as an option!  The Safe Area is new to iOS 9, and Xcode is lagging a bit behind with the default setting.  Not to worry though, we can change it ourselves.

### Inspecting Constraints

<details>
<summary> Open the Attributes Inspector </summary>

![errors](https://raw.githubusercontent.com/C4Q/AC-iOS/master/lessons/unit2/AutoLayout/images/error4.png)

</details>

We want to be centering our view in the center of the safe area.  Change the ```Second Item``` from Superview.Center Y to Safe Area.Center Y.

No more errors!  Finally, we have constrained our view appropriately.  Let's check out the last method of constaining a view.  First, let's reset our constraints by deleting them all.  Select all the constraints in the Document Outline and press delete.  Time to start anew.


### Using Control Drag

<details>
<summary>Control Drag</summary>

![cdrage](https://raw.githubusercontent.com/C4Q/AC-iOS/master/lessons/unit2/AutoLayout/images/controlDrag.png)

</details>

By control dragging from our view onto its superview, we see several different options for constraining it.  Hold down command, then click on the top four options.  Click add constraints.  And we're done!  Control-dragging can be a very quick way of setting constraints, but note that we didn't have any options about setting constants.  We have to do that manually later in the Attributes Inspector.


Let's look a little deeper into those options:

![layout](https://camo.githubusercontent.com/61a0eb85f15265e522803deb378ff3765f201f41/68747470733a2f2f7777772e7765686561727473776966742e636f6d2f77702d636f6e74656e742f75706c6f6164732f323031352f30392f53637265656e2d53686f742d323031352d30392d30342d61742d30322e34302e34392e706e67)


### Equal width and height

Another option available is to set the width/height of one view equal to the width/height of another.  Let's practice by making our view the same width as it's superview.  We can also set a *multiplier* for this contraint if we only want to be half as wide as another view.  By manipulating these figures, you can see your app update in real-time in Interface Builder.

**Exercise:** Create a view that takes up the entire left side of the screen.  Test your Auto Layout by rotating the app with command-right arrow.


![hori](https://raw.githubusercontent.com/C4Q/AC-iOS/master/lessons/unit2/AutoLayout/images/horizontalHalf.png)

![hori](https://raw.githubusercontent.com/C4Q/AC-iOS/master/lessons/unit2/AutoLayout/images/verticalHalf.png)



# 4. Constraining Views to Each Other

So far we have been working with a single view.  More often, we will have several different views that we will want to configure on the same screen.  This process is exactly the same as setting up one view, but we need to constrain all of our views.  There must be a continuous and uninterrupted set of constraints that provides a unique way to set up our app's UI.

**Exercise:** Set up three labels.  The middle one should be in the center with one label 20 points above it, and one 20 points below.

<details>
<summary>Images</summary>

![l1](https://raw.githubusercontent.com/C4Q/AC-iOS/master/lessons/unit2/AutoLayout/images/labelsOne.png)

![l1](https://raw.githubusercontent.com/C4Q/AC-iOS/master/lessons/unit2/AutoLayout/images/labelsTwo.png)

</details>

Notice that for our label, we didn't need to set its width.  This is because some UIKit objects have intrinsic widths/heights that are given to them, which they then tell Auto Layout themselves.

### Constraining Views with Variable Size to Each Other

A label has a explicit size, but a UIView does not.  Another element without an explicit size is a TextView.  Set up two TextViews like this:


![l1](https://raw.githubusercontent.com/C4Q/AC-iOS/master/lessons/unit2/AutoLayout/images/tf1.png)

![l1](https://raw.githubusercontent.com/C4Q/AC-iOS/master/lessons/unit2/AutoLayout/images/tf2.png)


Without setting constraint for the width and the height, Auto Layout doesn't know how to configure their relative sizes.  Should the top textview be very big and the bottom one very small?  Vice versa?  Or should they have the same size?  You need to add constraints to let Auto Layout know.

# 5. Stack Views

There are a couples of ways to add a stack view in storyboard:

- You can drag in either a `Horizontal Stack View` or `Vertical Stack View` from the Object Library in the right pane
- You can select the views you'd like to place in a stack view, and then go to `Editor > Embed In > Stack View`
- Or, you can select the views and click on the `Stack` button, conveniently located next to the `Align`, `Pin` and `Resolve AutoLayout Issues` buttons on the bottom right corner of Interface Builder.


![stack](https://raw.githubusercontent.com/C4Q/AC3.2-Stackview_Scrollview-2/master/Images/embed_in_stack_button.png)


There are three main configuration options needed to consider for a stack view (see `UIStackView` documentation under ["Managing the Stack View's Apperance"](https://developer.apple.com/documentation/uikit/uistackview))
	- `Axis` - the orientation of the stack, `vertical` or `horizontal`
	- `Alignment` - the layout of the arranged views *perpendicular* to the stack’s axis
	- `Distribution` - the layout of the arranged views *along* the stack’s axis

> Developer's Note: It's encouraged that you try out variations of each of these properties to get a sense for what each is accomplishing. Visual changes made by each of these properties is best understood having used them for a while.

**Exercise:** Create three labels and put them into a stack view that is alligned in the center of your app.  Put different lengths of text into each label.


# Standards
* Understand the basic elements of an iOS project
* Understand principles of class design and reuse

# Objectives
Students will be able to:
* Create and place UIViews programmatically
* Work with Selectors
* Create a new ViewController

# Resources

[CGRect](https://developer.apple.com/reference/coregraphics/cgrect)

[UIButton](https://developer.apple.com/reference/uikit/uibutton#//apple_ref/c/tdef/UIButtonType)

## Exercise: n-Card Monty

1. Extend the Monty engine to initialize itself with a configurable number of cards. The number of 
cards should be defined in a constant in the view controller. Update the storyboard to include
the correct number of buttons.

```swift
    required init?(coder aDecoder: NSCoder) {
    	// custom initializations

        super.init(coder: aDecoder)
    }
```

2. Make a new ViewController that programmatically lays out its views. Since we have a one-View Controller
app, we'll make the new view controller the initial one. One of our view controllers will always be
unreachable this way but that's OK for now.

Outline of steps

1. Create a new ViewController object in the Storyboard
2. Check "Is initial View Controller" in the Attributes Inspector of that view controller.
3. Create a new file, this time of Cocoa Class. You'll get a compiler error on the ```import Cocoa```
line. Change ```Cocoa``` to ```UIKit```. Don't ask.
4. Copy the code from the original view controller but you'll need to change it.
5. Wire up a UILabel like we did before.
6. But this time create the buttons in code. You will need to use these methods:

```swift
let rect = CGRect(
    origin: CGPoint(x: ?, y: ?),
    size: CGSize(width: ?, height: ?)
)

let button = UIButton(frame: rect)
button.tag = ?
button.backgroundColor = ?
button.setTitle(?, forState: ?)

// this line is verbatim if your tap handler is named buttonTapped
button.addTarget(self, action: #selector(buttonTapped), forControlEvents: .TouchUpInside)

// add it to the view hierarchy
self.view.addSubview(button)
``` 



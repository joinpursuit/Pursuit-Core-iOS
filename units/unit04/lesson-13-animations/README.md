# Introduction to UIView Animations 

## What is Animation 

Animations provide fluid visual transitions between different states of your user interface. In iOS, animations are used extensively to reposition views, change their size, remove them from view hierarchies, and hide them. You might use animations to convey feedback to the user or to implement interesting visual effects.

Both UIKit and Core Animation provide support for animations, but the level of support provided by each technology varies. In UIKit, animations are performed using UIView objects. Views support a basic set of animations that cover many common tasks. For example, you can animate changes to properties of views or use transition animations to replace one set of views with another.

## Three Reasons to Animate 

- Direct your users attention
- Keep users oriented
- Help connect behavior to what is on screen

## Objectives 

- What is the basic syntax of a UIView animation
- What properties can we animate

## What can be Animated 

- frame 
- bounds 
- center
- transform 
- alpha
- backgroundColor
- contentStretch 

## Sample Code

**Here the logo is being moved using a transform translation animation**   
```swift 
UIView.animate(withDuration: 1.0, delay: 0.3, options: [], animations: {
  self.loginView.pursuitLogo.transform = CGAffineTransform(translationX: 0, y: 600)
})
```

**Here the logo is being pulsated through the use of transform scale animation**   
```swift 
UIView.animate(withDuration: 1.0, delay: 0.3, options: [.repeat, .curveEaseInOut], animations: {
  self.loginView.pursuitLogo.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
})
```

**Using transform rotation**  
```swift 
UIView.animate(withDuration: 1.0, delay: 0.3, options: [.repeat, .autoreverse], animations: {
  self.loginView.sledgeHammer.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2.0)
})
```

**Animating backgroundColor**   
```swift 
UIView.animate(withDuration: 1.0, delay: 0.3, options: [.repeat, .autoreverse], animations: {
  self.loginView.backgroundColor = .red
})
```

- **withDuration**: The total duration of the animations, measured in seconds. If you specify a negative value or 0, the changes are made without animating them.
- **delay**: The amount of time (measured in seconds) to wait before beginning the animations. Specify a value of 0 to begin the animations immediately.
- **options**: A mask of options indicating how you want to perform the animations. For a list of valid constants, see [UIViewAnimationOptions](https://developer.apple.com/documentation/uikit/uiviewanimationoptions?language=swift).
- **animations**: A block object containing the changes to commit to the views. This is where you programmatically change any animatable properties of the views in your view hierarchy. This block takes no parameters and has no return value. This parameter must not be NULL.
- **completion**: A block object to be executed when the animation sequence ends. This block has no return value and takes a single Boolean argument that indicates whether or not the animations actually finished before the completion handler was called. If the duration of the animation is 0, this block is performed at the beginning of the next run loop cycle. This parameter may be NULL.

## Cubic Bezier curve representations of the predefined timing function

<p align="center">
<img src="https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Animation_Types_Timing/Art/standardtiming_2x.png" width="600" height="600"/>
</p>

Visualize timing curves [here](http://cubic-bezier.com/#.17,.67,.83,.67)

## CGAffineTransform

An affine transformation matrix for use in drawing 2D graphics.

**Overview**  
An affine transformation matrix is used to rotate, scale, translate, or skew the objects you draw in a graphics context. The [CGAffineTransform](https://developer.apple.com/documentation/coregraphics/cgaffinetransform) type provides functions for creating, concatenating, and applying affine transformations.

![radians degrees chart conversion](https://www.1728.org/degrees.png)   


## Resources 

| Resource | Summary |
|:--------:|:---------:|
| [Apple - Human Interface Guideline](https://developer.apple.com/ios/human-interface-guidelines/visual-design/animation/)  | Apple - Human Interface Guidelines (Animation) |
| [Apple - Animations Programming Guide](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/AnimatingViews/AnimatingViews.html) | Apple - Animations Programming Guide |
| [Radians to Degrees](https://www.rapidtables.com/convert/number/radians-to-degrees.html) | Radians to Degrees conversion calculator |

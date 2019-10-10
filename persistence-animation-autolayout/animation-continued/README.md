# Animations Continued

# 1. UIView.transition()

[UIView.transition()](https://developer.apple.com/documentation/uikit/uiview/1622574-transition). Creates a transition animation for the specified container view.

Here when the button is tapped an animated transition is created and toggles the button's imaage. Any animatable UI element can be placed in the animations: block. Here we are changing the UIImageView's image property.

```swift
@IBAction func imageTransition(_ sender: UIButton) {
  if dog.imageView?.image == UIImage(named: "dog") {
    UIView.transition(with: dog, duration: 1.0, options: [.transitionFlipFromRight], animations: {
      self.dog.setImage(UIImage(named: "cat"), for: .normal)
    })
  } else {
    UIView.transition(with: dog, duration: 1.0, options: [.transitionFlipFromRight], animations: {
      self.dog.setImage(UIImage(named: "dog"), for: .normal)
    })
  }
}
```

# 2. UIView.animateKeyframes()

[UIView.animateKeyframes()](https://developer.apple.com/documentation/uikit/uiview/1622552-animatekeyframes). Creates an animation block object that can be used to set up keyframe-based animations for the current view.

The view is being animated by using a variety of keyframe animations. The overall timing duration is set on the withDuration: parameter. Each individual keyframe has it duration and animation block.

```swift
@IBAction func cyclistMove(_ sender: UIButton) {
  UIView.animateKeyframes(withDuration: 3.0, delay: 0.0, options: [.calculationModePaced], animations: {
    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5, animations: {
      self.cyclist.transform = CGAffineTransform(translationX: 100, y: -50)
      self.cyclist.transform = CGAffineTransform(rotationAngle: -.pi/4)
    })
    UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
      self.cyclist.transform = CGAffineTransform(translationX: 200, y: -50)
    })
    UIView.addKeyframe(withRelativeStartTime: 1.0, relativeDuration: 2.0, animations: {
      self.cyclist.transform = CGAffineTransform(translationX: 400, y: -50)
      self.cyclist.alpha = 0.2
    })
  }) { done in
    self.cyclist.transform = CGAffineTransform.identity
    self.cyclist.alpha = 1.0
  }
}
```

# 3. UIViewPropertyAnimator()

[UIViewPropertyAnimator()](https://developer.apple.com/documentation/uikit/uiviewpropertyanimator). A class that animates changes to views and allows the dynamic modification of those animations.

A UISlide is being used here to dynamically manipulate the animation using a UIViewPropertyAnimator instance.

```swift
private var animator: UIViewPropertyAnimator!
```

```swift
animator = UIViewPropertyAnimator(duration: 2.0, curve: .easeInOut, animations: {
  self.ballon.transform = CGAffineTransform(scaleX: 6.0, y: 6.0)
})
```

```swift
@IBAction func sliderChanged(_ sender: UISlider) {
  animator.fractionComplete = CGFloat(sender.value)
}
```

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

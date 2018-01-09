## Core Animation - Layer Animations 

## Review - What is Animation?
* Change over Time
* Practical - how all the bits of your app fit together
* Artful - how your app feels 

<p align="center">
<img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Animations/Images/animation-change-over-time.png" />
</p>

Animations provide fluid visual transitions between different states of your user interface. In iOS, animations are used extensively to reposition views, change their size, remove them from view hierarchies, and hide them. You might use animations to convey feedback to the user or to implement interesting visual effects.

Both UIKit and Core Animation provide support for animations, but the level of support provided by each technology varies. In UIKit, animations are performed using UIView objects. Views support a basic set of animations that cover many common tasks. For example, you can animate changes to properties of views or use transition animations to replace one set of views with another.

## Three reasons to Animate
1. Direct your users attention
2. Keep users oriented 
3. Help connect behavior to what is on screen

## Apple's Platform Overview  
* UIKit
* CoreAnimation 
* CoreGraphics 
* CoreImage 
* SceneKit and SpriteKit
* Metal 

## Objectives 
* Overview of Core Animation 
* When do we need to use Core Animation over UIKit Animations
* What is a Layer
* Use CABasicAnimation 
* Use CAAnimationGroup 
* Implicity vs Explicit Animation 
* The default Time Functions available in CoreAnimation 
* What can we Animate on a Layer

Core Animation sits beneath AppKit and UIKit and is integrated tightly into the view workflows of Cocoa and Cocoa Touch. 
Of course, Core Animation also has interfaces that extend the capabilities exposed by your app’s views and give you more 
fine-grained control over your app’s animations.

<p align="center">
<img src="https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CoreAnimation_guide/Art/ca_architecture_2x.png"
width="300" height="200">
</p>

Using Core Animation, you can animate the following types of changes for your view’s layer:
- The size and position of the layer
- The center point used when performing transformations
- Transformations to the layer or its sublayers in 3D space
- The addition or removal of a layer from the layer hierarchy
- The layer’s Z-order relative to other sibling layers
- The layer’s shadow
- The layer’s border (including whether the layer’s corners are rounded)
- The portion of the layer that stretches during resizing operations
- The layer’s opacity
- The clipping behavior for sublayers that lie outside the layer’s bounds
- The current contents of the layer
- The rasterization behavior of the layer

## When do we need to use Core Animation over UIKit Animations

One of the most valid reasons to use CoreAnimation over UIKit is for 3-Dimensional Animations. 

[![XYZ Axis Video](https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Animations/Images/x-y-z-axis.png)](https://www.youtube.com/watch?v=3qXic7PR64g)  

## What is a CALayer

Every UIView has a CALayer.
* view.layer
* drawRect renders to the layer

CALayer Hierarchy
<p align="center">
<img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Animations/Images/calayer-hierarchy.png" />
</p>

All UIViews has a CALayer
<p align="center">
<img src="https://koenig-media.raywenderlich.com/uploads/2015/01/uiview.png" />
</p>

Layers are often used to provide the backing store for views but can also be used without a view to display content. A layer’s main job is to manage the visual content that you provide but the layer itself has visual attributes that can be set, such as a background color, border, and shadow. In addition to managing visual content, the layer also maintains information about the geometry of its content (such as its position, size, and transform) that is used to present that content onscreen. Modifying the properties of the layer is how you initiate animations on the layer’s content or geometry. A layer object encapsulates the duration and pacing of a layer and its animations by adopting the CAMediaTiming protocol, which defines the layer’s timing information.
If the layer object was created by a view, the view typically assigns itself as the layer’s delegate automatically, and you should not change that relationship. For layers you create yourself, you can assign a delegate object and use that object to provide the contents of the layer dynamically and perform other tasks. A layer may also have a layout manager object (assigned to the layoutManager property) to manage the layout of subviews separately.

Creating a CALayer
```swift 
let layer = CALayer()
layer.bounds = CGRect(x: 0, y: 0, width: view.bounds.width/2.0, height: view.bounds.height/2.0)
layer.position = view.center
layer.contents = UIImage(named:"dog")?.cgImage
view.layer.addSublayer(layer)
```
Creating a CAShapeLayer
```swift 
let layer = CAShapeLayer()
layer.path = UIBezierPath(roundedRect: CGRect(x: 64, y: 64, width: 160, height: 160), cornerRadius: 50).cgPath
layer.fillColor = UIColor.red.cgColor
view.layer.addSublayer(layer)
```

## Implicity vs Explicit Animation

Implicit - When the default behavior of the default animation is sufficient to your needs. 
```swift 
ball.layer.position = CGPoint(x: view.bounds.width/2.0, y: view.bounds.height)
```

Explicit - When you need more control over timiing customization and so on. 
```swift
let positionAnimation = CABasicAnimation(keyPath: "position.x")
positionAnimation.fromValue = -view.bounds.size.width/2
positionAnimation.toValue = view.bounds.size.width/2
positionAnimation.duration = 0.5
loginView.logo.layer.add(positionAnimation, forKey: nil)
```

## Cubic Bezier curve representations of the predefined timing function 
<p align="center">
<img src="https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/Animation_Types_Timing/Art/standardtiming_2x.png" width="600" height="600"/>
</p>

Animation shows Cubic Bezier Curves 
<p align="center">
<img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Animations/Images/animations-cubic-bezier-timing-curves.gif" width="320" height="568"/>
</p>

**Creating Custom Timing Functions**
```swift 
let customTimingFunction = CAMediaTimingFunction(controlPoints: 1.0, 0.01, 0.94, 0.62)
transformRotaion.timingFunction = customTimingFunction
```

## Creating a CAAnimationGroup
```swift 
let fadeOut = CABasicAnimation(keyPath: "opacity")
fadeOut.fromValue = 1
fadeOut.toValue = 0
fadeOut.duration = 1
     
let expandScale = CABasicAnimation()
expandScale.keyPath = "transform"
expandScale.valueFunction = CAValueFunction(name: kCAValueFunctionScale)
expandScale.fromValue = [1, 1, 1]
expandScale.toValue = [3, 3, 3]
     
let fadeAndScale = CAAnimationGroup()
fadeAndScale.animations = [fadeOut, expandScale]
fadeAndScale.duration = 1
```

## In Class Demo

<details>
<summary>Creating examples of CABasicAnimation</summary>
     
```swift 
let positionAnimation = CABasicAnimation(keyPath: "position.x")
positionAnimation.fromValue = -view.bounds.size.width/2
positionAnimation.toValue = view.bounds.size.width/2
positionAnimation.duration = 0.5
loginView.logo.layer.add(positionAnimation, forKey: nil)
```

</details>

<details>
<summary>Creating some examples of CAAnimationGroup</summary>
     
```swift 
let fadeOut = CABasicAnimation(keyPath: "opacity")
fadeOut.fromValue = 1
fadeOut.toValue = 0
fadeOut.duration = 1
     
let expandScale = CABasicAnimation()
expandScale.keyPath = "transform"
expandScale.valueFunction = CAValueFunction(name: kCAValueFunctionScale)
expandScale.fromValue = [1, 1, 1]
expandScale.toValue = [3, 3, 3]
     
let fadeAndScale = CAAnimationGroup()
fadeAndScale.animations = [fadeOut, expandScale]
fadeAndScale.duration = 1
```

</details>

## Exercises

Create the following animations in the gif files below: 

<p align="center">
<img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Animations/Images/animation-exercise-duck.gif" width="320" height="568"/>
</p>

<p align="center">
<img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Animations/Images/animation-exercise-favorite-drop.gif" width="320" height="568"/>
</p>

<p align="center">
<img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Animations/Images/animations-exercise-ball-chase.gif" width="320" height="568"/>
</p>


## Resources   
[Human Interface Guidelines - Animation](https://developer.apple.com/ios/human-interface-guidelines/visual-design/animation/)   
[CAAnimation - The abstract superclass for Core Animation animations.
](https://developer.apple.com/documentation/quartzcore/caanimation)  
[Core Animation Framework](https://developer.apple.com/documentation/quartzcore) 
[Animations](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/AnimatingViews/AnimatingViews.html)  
[Core Animation Programming Guide](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CoreAnimation_guide/Introduction/Introduction.html#//apple_ref/doc/uid/TP40004514)  
[Animating Layer Content](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CoreAnimation_guide/CreatingBasicAnimations/CreatingBasicAnimations.html)  
[CALayer Animatable Properties](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/CoreAnimation_guide/AnimatableProperties/AnimatableProperties.html#//apple_ref/doc/uid/TP40004514-CH11-SW1)  
[Advanced Graphics with Core Animation](https://academy.realm.io/posts/tryswift-tim-oliver-advanced-graphics-with-core-animation/)  
[Introduction to 3D Drawing in Core Animation](http://www.thinkandbuild.it/introduction-to-3d-drawing-in-core-animation-part-1/)  
[CAAnimationGroup](https://developer.apple.com/documentation/quartzcore/caanimationgroup) 
[CALayer](https://developer.apple.com/documentation/quartzcore/calayer)  
[Implicit vs Explicit Animations](http://laurencaponong.com/implicit-vs-explicit-animations-ios/)  
[Radian to Degrees Conversion](https://www.rapidtables.com/convert/number/radians-to-degrees.html)  
[CATransform3D vs. CGAffineTransform](https://stackoverflow.com/questions/567829/catransform3d-vs-cgaffinetransform)  
[Cubic Bezier Preview and Creation](http://cubic-bezier.com/#.17,.67,.83,.67)  

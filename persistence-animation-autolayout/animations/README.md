# Introduction to UIView Animations

## Objectives

- What is the basic syntax of a UIView animation
- What properties can we animate

## Resources

| Resource | Summary |
|:--------:|:---------:|
| [Apple - Human Interface Guideline](https://developer.apple.com/ios/human-interface-guidelines/visual-design/animation/)  | Apple - Human Interface Guidelines (Animation) |
| [Apple - Animations Programming Guide](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/AnimatingViews/AnimatingViews.html) | Apple - Animations Programming Guide |
| [Rey Wenderlich](https://www.raywenderlich.com/5255-basic-uiview-animation-tutorial-getting-started) | Animation tutorial | 
| [Radians to Degrees](https://www.rapidtables.com/convert/number/radians-to-degrees.html) | Radians to Degrees conversion calculator |


# 1. Animation Introduction

Animations provide fluid visual transitions between different states of your user interface. In iOS, animations are used extensively to reposition views, change their size, remove them from view hierarchies, and hide them. You might use animations to convey feedback to the user or to implement interesting visual effects.

Both UIKit and Core Animation provide support for animations, but the level of support provided by each technology varies. In UIKit, animations are performed using UIView objects. Views support a basic set of animations that cover many common tasks. For example, you can animate changes to properties of views or use transition animations to replace one set of views with another.

## Three Reasons to Animate

- Direct your users attention
- Keep users oriented
- Help connect behavior to what is on screen

## What can be Animated

- frame
- bounds
- center
- transform
- alpha
- backgroundColor
- contentStretch

# 2. UIView.animate

**Animating backgroundColor**   
```swift
UIView.animate(withDuration: 1.0, delay: 0.3, options: [.repeat, .autoreverse], animations: {
  self.loginView.backgroundColor = .red
})
```

This animation is animating the frame to the view and moving it down vertically from its y origin. The alpha on the view is also being animated from 1.0 to 0.0 which is slowly fading the view.

```swift 
@IBAction func ballDrop(_ sender: UIButton) {
  // value before animation starts
  self.ball.alpha = 1.0

  UIView.animate(withDuration: 1.0, delay: 0.0, options: [], animations: {
    // values here get animated
    self.ball.frame.origin.y += self.view.bounds.height
    self.ball.alpha = 0.0
  }) { done in

    // reset values in completion block
    self.ball.frame.origin.y -= self.view.bounds.height
  }
}
```

- **withDuration**: The total duration of the animations, measured in seconds. If you specify a negative value or 0, the changes are made without animating them.
- **delay**: The amount of time (measured in seconds) to wait before beginning the animations. Specify a value of 0 to begin the animations immediately.
- **options**: A mask of options indicating how you want to perform the animations. For a list of valid constants, see [UIViewAnimationOptions](https://developer.apple.com/documentation/uikit/uiviewanimationoptions?language=swift).
- **animations**: A block object containing the changes to commit to the views. This is where you programmatically change any animatable properties of the views in your view hierarchy. This block takes no parameters and has no return value. This parameter must not be NULL.
- **completion**: A block object to be executed when the animation sequence ends. This block has no return value and takes a single Boolean argument that indicates whether or not the animations actually finished before the completion handler was called. If the duration of the animation is 0, this block is performed at the beginning of the next run loop cycle. This parameter may be NULL.


# 3. Animating Constraints

Animation can also be used to manipulate constraints set programmatically.  This can be a useful tactic for moving views without needing to worry about how frame sizes will differ on differently sized devices.

Let's start by building a scaffold to move views around, then we'll add the animation.

We will make a blue square that can be animated to move up or down.

```swift
lazy var blueSquare: UIView = {
    let view = UIView()
    view.backgroundColor = .blue
    return view
}()
```

Next, we will add references to its constraints:

```swift
lazy var blueSquareHeightConstaint: NSLayoutConstraint = {
    blueSquare.heightAnchor.constraint(equalToConstant: 200)
}()

lazy var blueSquareWidthConstraint: NSLayoutConstraint = {
    blueSquare.widthAnchor.constraint(equalToConstant: 200)
}()

lazy var blueSquareCenterXConstraint: NSLayoutConstraint = {
    blueSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor)
}()

lazy var blueSquareCenterYConstraint: NSLayoutConstraint = {
    blueSquare.centerYAnchor.constraint(equalTo: view.centerYAnchor)
}()
```

Now create two IBActions (to be linked to buttons), that change the constraints of the square:

```swift
@IBAction func animateSquareUp(sender: UIButton) {
    let oldOffset = blueSquareCenterYConstraint.constant
    blueSquareCenterYConstraint.constant = oldOffset - 150
}

@IBAction func animateSquareDown(sender: UIButton) {
    let oldOffet = blueSquareCenterYConstraint.constant
    blueSquareCenterYConstraint.constant = oldOffet + 150
}
```

We can then hook up those IBActions to buttons:

```swift
lazy var upButton: UIButton = {
   let button = UIButton()
    button.setTitle("Move square up", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.backgroundColor = .cyan
    button.addTarget(self, action: #selector(animateSquareUp(sender:)), for: .touchUpInside)
    return button
}()

lazy var downButton: UIButton = {
   let button = UIButton()
    button.setTitle("Move square down", for: .normal)
    button.setTitleColor(.black, for: .normal)
    button.backgroundColor = .cyan
    button.addTarget(self, action: #selector(animateSquareDown(sender:)), for: .touchUpInside)
    return button
}()
```

And make a stack view to put our buttons inside:

```swift
lazy var buttonStackView: UIStackView = {
   let buttonStack = UIStackView()
    buttonStack.axis = .horizontal
    buttonStack.alignment = .center
    buttonStack.distribution = .equalSpacing
    buttonStack.spacing = 30
    return buttonStack
}()
```

Now, let's make functions that add subviews to our main view:


```swift
private func addSubviews() {
    view.addSubview(blueSquare)
    addStackViewSubviews()
    view.addSubview(buttonStackView)
}

private func addStackViewSubviews() {
    buttonStackView.addSubview(upButton)
    buttonStackView.addSubview(downButton)
}

private func configureConstraints() {
    constrainBlueSquare()
    constrainUpButton()
    constrainDownButton()
    constrainButtonStackView()
}
```


And functions to configure our constraints:

```swift
private func configureConstraints() {
    constrainBlueSquare()
    constrainUpButton()
    constrainDownButton()
    constrainButtonStackView()
}

private func constrainUpButton() {
    upButton.translatesAutoresizingMaskIntoConstraints = false
    upButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    upButton.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor).isActive = true
}

private func constrainDownButton() {
    downButton.translatesAutoresizingMaskIntoConstraints = false
    downButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
}

private func constrainBlueSquare() {
    blueSquare.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        blueSquareHeightConstaint,
        blueSquareWidthConstraint,
        blueSquareCenterXConstraint,
        blueSquareCenterYConstraint
    ])
}

private func constrainButtonStackView() {
    buttonStackView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
        buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
        buttonStackView.heightAnchor.constraint(equalToConstant: 50),
        buttonStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
    ])
}
```

Finally, we can call our methods inside of `viewDidLoad`

```swift
override func viewDidLoad() {
    super.viewDidLoad()
    addSubviews()
    configureConstraints()
}
```

<details>
<summary> The complete file </summary>

```swift
import UIKit

class ViewController: UIViewController {

    lazy var blueSquare: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()

    lazy var buttonStackView: UIStackView = {
       let buttonStack = UIStackView()
        buttonStack.axis = .horizontal
        buttonStack.alignment = .center
        buttonStack.distribution = .equalSpacing
        buttonStack.spacing = 30
        return buttonStack
    }()

    lazy var upButton: UIButton = {
       let button = UIButton()
        button.setTitle("Move square up", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareUp(sender:)), for: .touchUpInside)
        return button
    }()

    lazy var downButton: UIButton = {
       let button = UIButton()
        button.setTitle("Move square down", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .cyan
        button.addTarget(self, action: #selector(animateSquareDown(sender:)), for: .touchUpInside)
        return button
    }()

    lazy var blueSquareHeightConstaint: NSLayoutConstraint = {
        blueSquare.heightAnchor.constraint(equalToConstant: 200)
    }()

    lazy var blueSquareWidthConstraint: NSLayoutConstraint = {
        blueSquare.widthAnchor.constraint(equalToConstant: 200)
    }()

    lazy var blueSquareCenterXConstraint: NSLayoutConstraint = {
        blueSquare.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    }()

    lazy var blueSquareCenterYConstraint: NSLayoutConstraint = {
        blueSquare.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
    }

    @IBAction func animateSquareUp(sender: UIButton) {
        let oldOffset = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffset - 150
    }

    @IBAction func animateSquareDown(sender: UIButton) {
        let oldOffet = blueSquareCenterYConstraint.constant
        blueSquareCenterYConstraint.constant = oldOffet + 150
    }

    private func addSubviews() {
        view.addSubview(blueSquare)
        addStackViewSubviews()
        view.addSubview(buttonStackView)
    }

    private func addStackViewSubviews() {
        buttonStackView.addSubview(upButton)
        buttonStackView.addSubview(downButton)
    }

    private func configureConstraints() {
        constrainBlueSquare()
        constrainUpButton()
        constrainDownButton()
        constrainButtonStackView()
    }

    private func constrainUpButton() {
        upButton.translatesAutoresizingMaskIntoConstraints = false
        upButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        upButton.trailingAnchor.constraint(equalTo: buttonStackView.trailingAnchor).isActive = true
    }

    private func constrainDownButton() {
        downButton.translatesAutoresizingMaskIntoConstraints = false
        downButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    private func constrainBlueSquare() {
        blueSquare.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blueSquareHeightConstaint,
            blueSquareWidthConstraint,
            blueSquareCenterXConstraint,
            blueSquareCenterYConstraint
        ])
    }

    private func constrainButtonStackView() {
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            buttonStackView.heightAnchor.constraint(equalToConstant: 50),
            buttonStackView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
    }
}
```

</details>

To make our functions animate the movement of the square up and down, we need to add a call to `UIView.animate`:

```swift
@IBAction func animateSquareUp(sender: UIButton) {
    let oldOffset = blueSquareCenterYConstraint.constant
    blueSquareCenterYConstraint.constant = oldOffset - 150
    UIView.animate(withDuration: 2) { [unowned self] in
        self.view.layoutIfNeeded()
    }
}

@IBAction func animateSquareDown(sender: UIButton) {
    let oldOffet = blueSquareCenterYConstraint.constant
    blueSquareCenterYConstraint.constant = oldOffet + 150
    UIView.animate(withDuration: 2) { [unowned self] in
        self.view.layoutIfNeeded()
    }
}
```

Calling `self.view.layoutIfNeeded()` will animate any constraint changes that we've made for the whole view.

We use `unowned` self because we are 100% sure that this closure will only be executed from this View Controller.

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

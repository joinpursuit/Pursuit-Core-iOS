## Accessibility

## Objectives 
* What is Accessibility 
* Auditing your app for Accessibility 
* What is Dynamic Type 
* Fixing an app to make it accessible

## Accessibilty 
Making technology usable to everyone regardless of what their unique needs might be.

* Cognitive - conditions like dyslexia or autism
* Motor - the way in which the user physically interacts with the system, e.g pakinsons
* Vision - range of vision abilities from low vision to completely blind 
* Hearing - encompases hard of hearing to completely death

Over 1 billion people in the world have a disability, that equates to 1 in 7 people have a form of disability. 

[Designed for Carlos V. — Apple](https://www.youtube.com/watch?v=EHAO_kj0qcA&list=PLHFlHpPjgk7307LVoFKonAqq616WCzif7)   
[Apple - Accessibility - Sady](https://www.youtube.com/watch?v=SL7YSqlEd8k)  

Turning on Voice Over 
> Settings -> General -> Accessibility -> VoiceOver 

Accessibility Shortcut 
> Settings -> General -> Accessibility -> Accessibility Shortcut

Turning on Larger Text 
> Settings -> General -> Accessibility -> Larger Text (add 6 larger Text Styles) 

**Some Accessiblity Features**
* Voiceover 
* Zoom 
* Large Text
* Guided Access 
* Color Inversion
* Captioning 
* Switch Control 
* Siri 

**Audit your App for Accessibility**
> Settings -> General -> Accessibility -> VoiceOver (on device)  
> Settings -> General -> Accessibility -> Display Accomodations -> Invert Colors (on device)  
> Settings -> General -> Accessibility -> Accessibility Shortcut  
> Xcode -> Open Developer Tool -> Accessibility Inspector (simulator)   


**Best Practices** 
* Voiceover works best with Standard Navigation. 
* Avoid images with Text 
* Font sizes not absolute - 10 Different Text Styles supported
* Be aware of contrast ratio e.g Gray on Gray useful link
* Avoid clutter 
* Keep color schemes simple 
* Tap targets should be no less than 44 x 44 points
* label should be short and clear 
* label/hints should not contain trait information 
* hints should begin with a verb, should not contain action such as "tapping" unless it's a custom action 

## UIAccessibility  
A set of [methods](https://developer.apple.com/documentation/uikit/accessibility/uiaccessibility?language=occ) that provide accessibility information about views and controls in an app's user interface.

The UIAccessibility informal protocol provides accessibility information about an app’s user interface elements. Assistive apps, such as VoiceOver, convey this information to users with disabilities to help them use the app.

Standard UIKit controls and views implement the UIAccessibility methods and are therefore accessible to assistive apps by default. This means that if your app uses only standard controls and views, such as UIButton, UISegmentedControl, and UITableView, you need only supply app-specific details when the default values are incomplete. You can do this by setting these values in Interface Builder or by setting the properties in this informal protocol.

The UIAccessibility informal protocol is also implemented by the UIAccessibilityElement class, which represents custom user interface objects. If you create a completely custom UIView subclass, you might need to create an instance of UIAccessibilityElement to represent it. In this case, you would support all the UIAccessibility properties to correctly set and return the accessibility element’s properties.

Responding to Special VoiceOver Gestures
* Escape. A two-finger Z-shaped gesture that dismisses a modal dialog, or goes back one level in a navigation hierarchy.
* Magic Tap. A two-finger double-tap that performs the most-intended action.
* Three-Finger Scroll. A three-finger swipe that scrolls content vertically or horizontally.
* Increment. A one-finger swipe up that increments a value in an element.
* Decrement. A one-finger swipe down that decrements a value in an element.  
([more](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/SupportingAccessibility.html#//apple_ref/doc/uid/TP40007457-CH12-SW1)) 

UIAccessibility asks your views:

1. What are you? Button
```swift 
control.accessibilityTraits |= UIAccessibilityTraitButton
```

2. Who are you? Notifications
```swift 
control.accessibilityLabel = "notifications"
```

3. What's your value? 3 unread 
```swift
control.accessibilityValue = "\(unreadMessages.count) unread"
```

<details>
<summary>Common Traits</summary>
  
* UIAccessibilityTraitButton
* UIAccessibilityTraitHeader
* UIAccessibilityTraitLink
* UIAccessibilityTraitImage
* UIAccessibilityTraitAdjustable

</details>

<details>
<summary>UIAccessibility Basic Properties</summary>
  
```swift 
extenstion NSObject {
  open var isAccessibilityElement: Bool // should it be accessible 
  open var accessibilityLabel: NSString? // what an element is
  open var accessibilityTraits: UIAccessibilityTraits // what category an element fits into
  open var accessibilityValue: NSString? // elements that have some sort of state e.g scrubber's current value
  open var accessibilityHint: NSString? // long form description, help them learn about UI, no critical info here
}
```

```swift 
memoryView.isAccessibilityElement = true 
```

```swift
memoryView.accessibilityLabel = "Memory, May 11 2007 " 
```

```swift
memoryView.accessibilityTraits |= UIAccessibilityTraitButton
```

```swift
videoScrubber.accessibilityValue = "\(elapsedTime) seconds"
```

```swift
videoScrubber.accessibilityHint = "Swipe up or down with one finger to adjust the value"
```

</details>

<details>
<summary>Attributed properties new in iOS 11</summary>
  
```swift  
extenstion NSObject {
  open var accessibilityAttributedLabel: NSAttributedString? 
  open var accessibilityAttributedValue: NSAttributedString? 
  open var accessibilityAttributedHint: NSAttributedString? 
}
```

</details>

<details>
<summary>Override Accessibility Elements on a Custom View</summary>
  
```swift 
class CustomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

// Override Accessibility Elements
extension CustomView {
    override var isAccessibilityElement: Bool {
        get {
            return true
        }
        set{}
    }
    override var accessibilityLabel: String? {
        get {
            return "Custom View"
        }
        set {}
    }
    override var accessibilityValue: String? {
        get {
            return "Value"
        }
        set {}
    }
}
```

</details>

<details>
<summary>UIAccessibilityCustomAction example</summary>
  
```swift  
class CustomCollectionCell: UICollectionViewCell {
  func commonInit() {
    let customAction = UIAccessibilityCustomAction(name:"Delete", target: self, selector:#selector(deleteCellAction))
    accessibilityCustomActions = [customAction]
  }
  func deleteCellAction() -> Bool {
    // code for initiating cell delete 
  }
}
```

</details>

<details>
<summary>Accessibility Activate example</summary>
  
```swift  
class CustomTableViewCell: UITableViewCell {
  let switchView: UISwitchView
  override func accessibilityActivate() -> Bool {
    switchView.setOn(!switchView.isOn, animated: true)
    return true 
  }
}
```

</details>

<details>
<summary>Increment and Decrement Example</summary>
  
```swift  
class StarsView: UIView {
  var numStars: Int {
    didSet {
      // code for adjusting the star rating 
    }
  }
  
  override func accessibilityTraits {
    get {
      return { super.accessibilityTraits | UIAccessibilityTraitsAdjustable }
    }
    set {}
  }
  
  override func accessibilityIncrement() {
    numStars += 1 
  }
  
  override func accessibilityDecrement() {
    numStars -= 1 
  }
}
```

</details>

<details>
<summary>Activation Point Example</summary>
  
```swift  
class SliderView: UIView {
  let sliderNub: NubView 
  
  override func accessibilityActivationPoint: CGPoint {
    get {
      return sliderNub.center 
    }
    set {}
  }
}
```

</details>


<details>
<summary>Accessibility Scroll Example</summary>
  
```swift  
class MyImageView: UIImageView {
  var canShowDetails: Bool = false 
  func showDetails() {
    // code for showing details
  }
  override func accessibilityScroll(_ direction:UIAccessibilityScrollDirection) -> Bool {
    if (canShowDetails && direction == .down) {
      showDetails() 
      return true 
    }
    return false 
  }
}
```

</details>

<details>
  <summary>Dismiss Modal with "Z" two finger action</summary>
  
```swift 
 override func accessibilityPerformEscape() -> Bool {
    dismiss(animated: true, completion: nil)
    return true
 }
```
</details>

## What is Dynamic Type?

Dynamic Type is a feature that allows users to customize the size of text on screen. For example, some users may prefer a smaller text size so they can fit more content on screen.

Others may prefer a larger text size because it's more comfortable to read.

But Dynamic Type goes beyond a user's preferences. Some users may experience eye strain when viewing text at the default size for long periods of time.

Others may simply have less acute vision due to aging. And yet others may have a low vision condition which makes it impossible for them to read text at the default size.

So for these users Dynamic Type isn't just a preference, it's an actual need and by supporting Dynamic Type in your apps, you can allow these users to use your app and have a great experience with it. The Dynamic Type settings can be found in the Settings app under Display and Brightness. It starts out with seven different text sizes you can choose from, and the default one is in the middle. You can also go into your Accessibility settings and there you can enable five even larger sizes.


**Working with dynamic type in code to change text styles from user input changes**  
```swift 
messageTextField.font = UIFont.preferredFont(forTextStyle: .body)
messageTextField.adjustsFontForContentSizeCategory = true
```

**Listen for Notification on Content Size Change**  
```swift 
Notification.center.default.addObserver(self, selector: #selector(userChangedTextSize), 
                                        name: NSNotification.Name.UIContentSizeCategoryDidChange,
                                        object: nil) 
```

**Make Layout Decisions based on Text Size**  
```swift 
if traitCollection.preferredContentSizeCategory.isAccessibilityCategory {
  // vertically stack
} else {
  // layout side by side 
}
```

**Self-Sizing Table View cells**  
- table view asks each cell to provide its own size 
- provide an estimated row height for off-screen cells 

```swift 
tableView.rowHeight = UITableViewAutomaticDimension
tableView.estimatedRowHeight = // a resonable estimate
```
**NB** if applicable do the same for headers and footers

**Scaling Images for Dynamic Types** 
* images assets should be provided as PDF @ 1x scale (same image for be @2x and @3x)
* assets catalog - check preserve vector data

Allow Bar Items to scale smoothly 
- if image is from a PDF use preserve vector data checkbox 
- if not, you will have to provide a larger image at 75 x 75 points 
```swift 
barButtonItem.largeContentSizeImage = largerImage
```

**Audit App for Dynamic Type using Accessibility Inspector**  
> Xcoce -> Open Developer Tool -> Accessibility Inspector

**Scaling Image base on Accessibility**   
```swift 
private func updateLayoutConstraints() {
  NSLayoutConstraint.activate(commonConstraints)
  if traitCollection.preferredContentSizeCategory.isAccessibilityCategory { 
    NSLayoutConstraint.deactivate(regularConstraints)
    NSLayoutConstraint.activate(largeConstraints)
  } else {
    NSLayoutConstraint.daactivate(largeConstraints)
    NSLayoutConstraint.activate(regularConstraints)
  }
}

override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
  let isAccessibilityCategory = traitCollection.preferredContentSizeCategory.isAccessibilityCategory
  if isAccessibilityCategory != previousTraitCollection?.preferredContentSizeCategory.isAccessibilityCategory {
    updateLayoutConstraints() 
  }
}
```

```swift
// this will adjust the image size
imageView.adjustsImageSizeForAccessibilityContentSizeCategory = true
```

|Resource|Summary|
|:-------|:-------|
|[Accessibility on iOS](https://developer.apple.com/accessibility/ios/)|Accessibility on iOS|
|[Accessibility](https://developer.apple.com/documentation/uikit/accessibility?language=objc)|Make your app more accessible to users with disabilities|
|[UIAccessibility](https://developer.apple.com/documentation/uikit/accessibility/uiaccessibility)|UIAccessibility|
|[Supporting Accessibility](https://developer.apple.com/library/content/featuredarticles/ViewControllerPGforiPhoneOS/SupportingAccessibility.html#//apple_ref/doc/uid/TP40007457-CH12-SW1)|Supporting Accessibility|
|[UITraitCollection](https://developer.apple.com/documentation/uikit/uitraitcollection)|The iOS interface environment for your app, defined by traits such as horizontal and vertical size class, display scale, and user interface idiom.|
|[Xcode 9 Vector Images](https://useyourloaf.com/blog/xcode-9-vector-images/)|Xcode 9 Vector Images|
|[UIAccessibilityContainer](https://developer.apple.com/documentation/uikit/accessibility/uiaccessibilitycontainer?language=objc)|A set of methods that view subclasses use to make subcomponents accessible as separate elements|
|[UIAccessibilityContainerType](https://developer.apple.com/documentation/uikit/uiaccessibilitycontainertype?language=occ)|Constants indicating the type of content stored in a data-based container|
|[VoiceOver - where is it on the simulator?](https://forums.developer.apple.com/thread/83458)|Voice over on the simulator?|
|[UIAccessibilityCustomAction](https://developer.apple.com/documentation/uikit/uiaccessibilitycustomaction?language=occ)|A custom action to be performed on an accessible object|
|[UIKonf - Accessibility - Video](https://www.youtube.com/watch?v=G01Ac5njNSs)|Sommer Panage on Accessibility|
|[What's New in Accessibility - WWDC Video](https://developer.apple.com/videos/play/wwdc2017/215/)|What's New in Accessibility|  

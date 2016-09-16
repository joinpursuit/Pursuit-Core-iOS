# Standards

* Understand the basic elements of an iOS project
* Understand principles of class design and reuse
* Understand the view hierarchy
* Understand the case for Generics and how they're used in the library

# Objectives

Students will be able to:

* Upgrade XCode to version 8, Swift 3
* Convert existing Swift code to Swift 3
* Create a new ViewController
* Add a tab to a Tab Controller
* Perform frame calculations
* Pin a view to its container

# Resources

[UITabBarController](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewControllerCatalog/Chapters/TabBarControllers.html#//apple_ref/doc/uid/TP40011313-CH3-SW1)


### Upgrade XCode to version 8, Swift 3

Some changes I encountered

* Past tense naming convention
     * ```repeatingValue``` --> ```repeated``` 
     * ```enumerate``` --> ```enumerated```
* Fewer words
    * ```repeatingValue``` --> ```repeated``` 
    * ```UIColor.lightGrayColor()``` --> ```UIColor.lightGray```
    * ```button.setTitle(title, for: .normal)```

* Square VC's are gone
	* New tool to look directly at sizes and orientations

* Project settings
Just accept the defaults.

* Application lifecycle methods
The methods in AppDelegate.swift all had changes to their signatures.  We're not actually 
using any of them so you can delete them all but this one is good to have around.

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
    return true
}
```
New projects will generate the correct forms, of course.

> A reflection: Keeping on top of the environment, libraries, frameworks, and SDKs that support your development becomes the focus of your continuing education, not languages so much.

> Question: What's wrong with this function in MontyModel.swift?

```swift
 //resetting button state to change color
    func resetButtonState(buttonA: UIButton, buttonB: UIButton, buttonC: UIButton, buttonD: UIButton, buttonE: UIButton) {
        buttonA.backgroundColor = .lightGrayColor()
        buttonB.backgroundColor = .lightGrayColor()
        buttonC.backgroundColor = .lightGrayColor()
        buttonD.backgroundColor = .lightGrayColor()
        buttonE.backgroundColor = .lightGrayColor()
    }
```

### Exercise

Bring Tabbed Monty up to date by removing errors and fixing style.

### Exercise

Create canonical version of the app. Upload to github and fork.

### Exercise

Add third view controller. Add a ```UISwitch``` to a view controller and create an action on value changed.

### Exercise

Build a matrix of buttons inside a given UIView. Pin the containing view to its superview.






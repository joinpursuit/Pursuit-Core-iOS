# Programmatic Layout


### Objectives

- Create an app with no Storyboard
- Lay out views with frames
- Lay out views with autolayout
- Create controls
- Create segues

### Resources

- [Apple docs - Programmatic Autolayout](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/ProgrammaticallyCreatingConstraints.html)
- [Dan Stepanov walkthrough](https://medium.com/@danstepanov/your-first-ios-app-100-programmatically-xcode-7-2-swift-2-1-9946d09610c4)
- [Borish Ohayon walkthrough](https://medium.com/ios-os-x-development/ios-start-an-app-without-storyboard-5f57e3251a25)
- [Lazy variables with Abhimuralidharan](https://medium.com/@abhimuralidharan/lazy-var-in-ios-swift-96c75cb8a13a)
- [Lazy variables with Sundell](https://www.swiftbysundell.com/posts/using-lazy-properties-in-swift)

# 1. Why no Storyboard?

Up until now, every app that we've developed has been through a Storyboard.  Storyboards are fantastic at giving you a visual interface to create your app and to visualize the autolayout configuration of each view and view controller.

However, there are times when it might be better to create an App without the use of a Storyboard.

<details>
<summary> When might this be? </summary>

- Working with a team
- Managing complex/dynamic autolayout
- Complex interrelation of View Controllers

</details>

In order to dive into creating an App without a Storyboard, we'll need to do a little work in the *info.plist* and the *AppDelegate.swift* files.

# 2. Displaying a View Controller with no Storyboard.

### Configuring the info.plist

First, let's delete the Main.storyboard file from our app.  We won't need it for our app.  Build and run your project. 

<details>
<summary> What happens? </summary>

Our app crashes

</details>

This is because our application is still trying to find a Storyboard.  There's a little bit of work that XCode has to do to associate the Storyboard file with your applciation, so it knows where to look.  We need to tell our application that it shouldn't try to find a Main.storyboard anymore.

Go to the *info.plist* and look for the property titled "Main storyboard file base name".  Click on the minus button to delete the row.

Let's build and run our app again.  Now, we can see that there are no crashes, and just a black screen.  We haven't configured our View Controller at all, so that's not too surprising.  Let's set the background color to green.  When we build and run our app, we still don't see anything!  This is because we didn't tell our app to present an instance of this view controller.  If we had 4 or 5 different view controllers, it wouldn't know what to display.  We'll need to tell our app what to display.

### Configuring AppDelegate.swift

The AppDelegate.swift file is the delegate for your entire application.  Just like a textField has a delegate that gets notified at key events, so too does your application.  The following methods all are called as part of your *Application Lifecyle*

```swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
```

<details>
<summary> Which one do we want to use?</summary>

```swift
application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?)
```

</details>


Inside that method, we need to create an instance of our view controller and display it.  We create an instance of our ViewController like we would any other class.  To display it, we need to use a property of our AppDelegate, the *window*.


#### UIWindow

(from Apple Docs)

The backdrop for your app’s user interface and the object that dispatches events to your views.

**Properties and methods**

- `var rootViewController: UIViewController?`
- `var screen: UIScreen`
- `func makeKeyAndVisible()`

The rootViewController of a UIWindow is the view controller that is points to first.  This rootViewController can also be a Tab Bar Controller or Navigation Controller.

A UIScreen is an object that defines the properties of the hardware that is displaying the app.  For our purposes, consider this to be the screen of the user's phone.  A UIScreen has a property *main* which is the screen object representing the device’s screen.  We can use this to get how big we need to make the display.  This screen property is what screen the window should be displayed on.

The method makeKeyAndVisible(), is a UIWindow instance method that makes the window the *key* window (the window that responds to taps/user interaction) and visible, so it can be seen by the user.


Using these properties and methods, we can now configure our AppDelegate:

```swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let myVC = ViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = myVC
        window?.makeKeyAndVisible()
        return true
    }
```


When we build our app now, we should see a green screen.  Success!  But we can't do much with just this, we'll want to add some views.

# 3. Adding Views Programatically

Let's create a label in the middle of our screen that reads, "Welcome to my app".  We have no storyboard to drag in, so we'll need to add the label in our view controller.  

```swift
class ViewController: UIViewController {

    var myLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        myLabel.text = "Welcome to my app"
    }
}
```

But when we build and run this here, we don't see our label.  And it's not even in the "Debug View Hierarchy" view.  In a Storyboard based app, the @IBOutlet tag did some magic of adding our label to the view for us.  Here, we'll need to do it ourselves.


```swift
class ViewController: UIViewController {

    var myLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        myLabel.text = "Welcome to my app"
        self.view.addSubview(myLabel)
    }
}
```

Our label still isn't here, but we are getting closer.  We can see that the Debug View Hierarchy view knows that we have a label, but it doesn't know where it is.  And how could it?  In a Storyboard app, we can drag the label in, and then use the settings there to set its Autolayout constraints.  We haven't done any of that work here, so our app doesn't know where to place the label.

### Placing subviews

There are two main ways to tell your app where your views belong:

1. Setting the *frame* of the subview
2. Settings the Autolayout constraints using Layout Anchors

We will go much more into both of these in lessons later this week, but enough is included here to get you started.

## Setting the Frame of the subview

Instead of creating a label with an empty initializer, we can use an initializer that sets its frame.

```swift
init(frame: CGRect)
```

Below, we make a frame for our label.  Also, we set it's background color to red to make its frame visible for testing purposes.

```swift
class ViewController: UIViewController {

    var myLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        myLabel.text = "Welcome to my app"
        myLabel.backgroundColor = .red
        self.view.addSubview(myLabel)
    }
}
```

Now our label has appeared!  We can customize the frame to be whatever we want it to be.  Before moving on, let's clean up this code here.  It's a little awkward that all of our label setup has to happen inside of viewDidLoad.  It would be better to have all of that grouped with the label property.

```swift
class ViewController: UIViewController {

    var myLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        label.text = "Welcome to my app"
        label.backgroundColor = .red
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        self.view.addSubview(myLabel)
    }
}
```

And last, let's have our welcome message tell us the background color of our app.  We'll refactor a bit to add only one place to look.

```swift
class ViewController: UIViewController {

    var appColor = (color: UIColor.green, name: "green")
    
    var myLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        label.text = "Welcome to my \(self.appColor.name) app"
        label.backgroundColor = .red
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = self.appColor.color
        self.view.addSubview(myLabel)
    }
}
```

But this code gives an error.  We have an error because we are not allowed to use *self* inside of the closure for myLabel.  This is because our View Controller might not yet be fully initialized when this code gets run.  We can avoid this problem by using the **lazy** keyword.  This means that none of the code will get executed until someone actually accesses the property.  We are then allowed to use *self* because we are garunteed that the view controller is fully initialized by the time something is accessing one of its properties.


```swift
class ViewController: UIViewController {

    var appColor = (color: UIColor.green, name: "green")
    
    lazy var myLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 100, y: 100, width: 200, height: 200))
        label.text = "Welcome to my \(self.appColor.name) app"
        label.backgroundColor = .red
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = self.appColor.color
        self.view.addSubview(myLabel)
    }
}
```

## Setting the Autolayout of the subview

Using Frames is a very manual process to set where a subview should be.  We can tell by rotating the screen that the frame doesn't give a consistant placement.  We would be better off using Autolayout to make it more dynamic.

There are two things we must do to use autolayout for a view.

1. Set the subview's translatesAutoresizingMaskIntoConstraints to false
2. After you make a constraint, set its .isActive to true

Here is our label above with autolayout applied to put it in the center:

```swift
class ViewController: UIViewController {

    var appColor = (color: UIColor.green, name: "green")
    
    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.text = "Welcome to my \(self.appColor.name) app"
        label.backgroundColor = .red
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = self.appColor.color
        self.view.addSubview(myLabel)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        myLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
}
```

If we omit the line:

```swift
myLabel.translatesAutoresizingMaskIntoConstraints = false
```

It will not use our AutoLayout constraints.

Similiarly, it you don't set your constraints .isActive = true, then they will not be in effect.

These AutoLayout constraints are the same as you used in Storyboard.  Every view needs a unique x, y, width and height to be laid out.  Every view has the following properties:

- centerYAnchor
- centerXAnchor
- widthAnchor
- heightAnchor
- leadingAnchor
- trailingAnchor
- topAnchor
- bottomAnchor

You also will see a left and right anchor.  Ignore those, but read [here](https://stackoverflow.com/questions/32981532/difference-between-leftanchor-and-leadinganchor) to see what they are for.

When setting a constraint, you can also control its **constant** and **multiplier**.

![Apple Docs](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/Art/view_formula_2x.png)


```swift
myLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 100).isActive = true
//Sets the label 100 points below the center
```

```swift
        myLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -(self.view.bounds.height / 4)).isActive = true
//Sets to label halfway in between the center and the top
```

By having properties of your app's view's bounds as the constants, you can have dynamic positioning.

We will get much deeper into programatic AutoLayout later this week.


# 4. Adding Controls Programatically

Now that we can position views on the screen, we also want to position UIControls (such as buttons or text fields).  Let's add a button to our app that changes the background color.  First, we'll refactor our app to avoid having to hard code the color changing.

```swift 
//App Color Struct
struct AppColor {
    let name: String
    let color: UIColor
    static let allColors = [AppColor(name: "green", color: .green),
                            AppColor(name: "blue", color: .blue),
                            AppColor(name: "yellow", color: .yellow),
                            AppColor(name: "cyan", color: .cyan)
    ]
}
```

```swift 
class ViewController: UIViewController {
    
    var currentColorIndex: Int! {
        didSet {
            if currentColorIndex >= AppColor.allColors.count {
                currentColorIndex = 0
            }
            let newColor = AppColor.allColors[currentColorIndex]
            self.view.backgroundColor = newColor.color
            self.myLabel.text = "Welcome to my \(newColor.name) app"
        }
    }
    
    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentColorIndex = 0
        self.view.addSubview(myLabel)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        setConstraints()
    }
    
    func setConstraints() {
        myLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -(self.view.bounds.height / 4)).isActive = true
        myLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
}
```

We are now ready to add our button.  We can place it the same way that we placed our view before.  The only difference is that we need to add in the action for what pressing the button does.


```swift
lazy var myButton: UIButton = {
    let button = UIButton()
    button.setTitle("Change Color", for: .normal)
    button.addTarget(self, action:  #selector(changeColor), for: .touchUpInside)
    return button
}()
    
@objc func changeColor() {
    currentColorIndex = currentColorIndex + 1
}


override func viewDidLoad() {
    super.viewDidLoad()
    self.currentColorIndex = 0
    self.view.addSubview(myLabel)
    self.view.addSubview(myButton)
    setConstraints()
}
    
func setConstraints() {
    myLabel.translatesAutoresizingMaskIntoConstraints = false
    myLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -(self.view.bounds.height / 4)).isActive = true
    myLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    
    myButton.translatesAutoresizingMaskIntoConstraints = false
    myButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    myButton.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 20).isActive = true
}

```

# 5. Programatic Segues


One last major component is how to handle transitioning to other view controllers.  Because we do not have a Storyboard, we cannot create segues visually between view controllers.  Instead, we will need to rely on our understanding that they function through the use of a *stack*.  We will manually *push* view controllers onto the stack which will be *popped* off when the user navigates backwards.  To facilitate this process, we will set a *Navigation Controller* as the root view controller of the window in the app delegate.


```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    let myVC = ViewController()
    let navController = UINavigationController(rootViewController: myVC)
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navController
    window?.makeKeyAndVisible()
    return true
}
```

We'll now need a different view controller to segue to.  Let's make a settings page where they can select the starting background color.

```swift
class SettingsViewController: UIViewController {
    lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.dataSource = self
        pv.delegate = self
        return pv
    }()
    
    lazy var startingLabel: UILabel = {
        let label = UILabel()
        label.text = "Select the starting background color"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(pickerView)
        self.view.addSubview(startingLabel)
        setConstraints()
    }
    
    func setConstraints() {
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        pickerView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        pickerView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        
        startingLabel.translatesAutoresizingMaskIntoConstraints = false
        startingLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        startingLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
    }
}

extension SettingsViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return AppColor.allColors.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return AppColor.allColors[row].name
    }
}

extension SettingsViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //TO DO: Add to User Defaults
        print("selected row \(row)")
    }
}
``` 

Then let's return to our view controller and add a button that segues to our new view controller.

```swift
struct AppColor {
    let name: String
    let color: UIColor
    static let allColors = [AppColor(name: "green", color: .green),
                            AppColor(name: "blue", color: .blue),
                            AppColor(name: "yellow", color: .yellow),
                            AppColor(name: "cyan", color: .cyan)
    ]
}

class ViewController: UIViewController {
    
    var currentColorIndex: Int! {
        didSet {
            if currentColorIndex >= AppColor.allColors.count {
                currentColorIndex = 0
            }
            let newColor = AppColor.allColors[currentColorIndex]
            self.view.backgroundColor = newColor.color
            self.myLabel.text = "Welcome to my \(newColor.name) app"
        }
    }
    
    lazy var myLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        return label
    }()
    
    lazy var myButton: UIButton = {
        let button = UIButton()
        button.setTitle("Change Color", for: .normal)
        button.addTarget(self, action:  #selector(changeColor), for: .touchUpInside)
        return button
    }()
    
    lazy var segueButton: UIButton = {
        let button = UIButton()
        button.setTitle("Settings", for: .normal)
        button.addTarget(self, action: #selector(goToSettings), for: .touchUpInside)
        return button
    }()
    
    @objc func changeColor() {
        currentColorIndex = currentColorIndex + 1
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.currentColorIndex = 0
        self.view.addSubview(myLabel)
        self.view.addSubview(myButton)
        self.view.addSubview(segueButton)
        setConstraints()
    }
    
    func setConstraints() {
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        myLabel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -(self.view.bounds.height / 4)).isActive = true
        myLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        myButton.topAnchor.constraint(equalTo: myLabel.bottomAnchor, constant: 20).isActive = true
        
        segueButton.translatesAutoresizingMaskIntoConstraints = false
        segueButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        segueButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    @objc func goToSettings() {
        let settingsVC = SettingsViewController()
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
}
```

## Programmable View Management

## Objectives 
* Creating UIControls Programmatically 
* Create an app without the use of storyboards
* Programmable Auto Layout using LayoutAnchors
* Understand frame and bounds 
* Understand what is UIWindow and its purpose in our app

## UIWindow
Normally, Xcode provides your app's main window. New iOS projects use storyboards to define the app’s views. Storyboards require the presence of a window property on the app delegate object, which the Xcode templates automatically provide. 
If your app does not use storyboards, you must create this window yourself.

## AppDelegate Setup for Programmable Views 
```swift 
func application(_ application: UIApplication, 
didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Create a Navigation Controller
    // Same as when we embed a View Controller in a Navigation Controller in Storyboard
    let navController = UINavigationController()

    // Set the View Hierarchy
    // In this case it's a Navigation Controller with a root View Controller
    let mainVC = MainViewController()
    navController.viewControllers = [mainVC]

    // Set the Main Window of the app
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.rootViewController = navController
    window?.makeKeyAndVisible()

    return true
}
```

## Frame vs Bounds 
The [frame](https://developer.apple.com/documentation/uikit/uiview/1622621-frame) of an UIView is the rectangle, expressed as a location (x,y) and size (width,height) relative to the superview it is contained within.

The [bounds](https://developer.apple.com/documentation/uikit/uiview/1622580-bounds) of an UIView is the rectangle, expressed as a location (x,y) and size (width,height) relative to its own coordinate system (0,0).

[What's the difference between the frame and the bounds?](https://stackoverflow.com/questions/1210047/cocoa-whats-the-difference-between-the-frame-and-the-bounds)  

```swift 
private func setupSquare() {
    // frame base layout
    let length: CGFloat = UIScreen.main.bounds.width / 2
    square = UIView(frame: CGRect(x: 0, y: 80, width: length, height: length))
    square.backgroundColor = .blue
    addSubview(square)
}
```

<p align="center">
<img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Programmatic-View-Management/Images/frame-vs-bounds.png" width="414" height="736" />
</p>

## Subclassing and Creating a Custom UIView
```swift 
class MainView: UIView {

    // here best practices is to create your views by lazy instantiation
    // the view is not created until it's needed - leads to better processing time 
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.frame = bounds // bounds here is the MainView's bounds which is UIScreen.main.bounds (entire screen)
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "NameCell")
        return tv
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        setupViews()
    }
    
    private func setupViews() {
        addSubview(tableView)
    }
}
```

## Creating UI elements using Frame Based layout
Note: This method of laying views could get verbose and complicated really quickly especially for fellow developers 
to read your code. We will be using Layout Anchors for our layout 
constraints for this lesson.
```swift 
lazy var imageView: UIImageView = {
    let iv = UIImageView(frame: CGRect(x: 0, y: 0,
                                       width: UIScreen.main.bounds.width * 0.80,
                                       height: UIScreen.main.bounds.height * 0.80))
    iv.image = UIImage.init(named: "happy-2018")
    iv.contentMode = .scaleAspectFit
    iv.center = view.center
    return iv
}()

lazy var toggleButton: UIButton = {
    let button = UIButton(frame: CGRect(x: 0, y: 0,
                                        width: UIScreen.main.bounds.width * 0.60,
                                        height: 44))
    button.setTitle("Toggle Image", for: .normal)
    button.setTitleColor(.orange, for: .normal)
    button.center = view.center
    button.addTarget(self, action: #selector(toggleImage), for: .touchUpInside)
    return button
}()

override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    view.addSubview(imageView)
    view.addSubview(toggleButton)
}

override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    toggleButton.frame.origin.y = UIScreen.main.bounds.height * 0.80
}

@objc func toggleImage() {
    imageView.isHidden = !imageView.isHidden
}
```

## Programmable Constraints
You have three choices when it comes to programmatically creating constraints: You can use layout anchors, you can use the NSLayoutConstraint class, or you can use the Visual Format Language.

## Autolayout with Layout Anchors
```translatesAutoresizingMaskIntoConstraints```
If you want to use Auto Layout to dynamically calculate the size and position of your view, you must set this property to false, and then provide a non ambiguous, nonconflicting set of constraints for the view.
```swift 
private func setupViews() {
    // programmable autolayout

    // profile view
    addSubview(profileView)
    profileView.translatesAutoresizingMaskIntoConstraints = false
    profileView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    profileView.topAnchor.constraint(equalTo: topAnchor, constant: 100).isActive = true
    profileView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
    profileView.heightAnchor.constraint(equalTo: profileView.widthAnchor).isActive = true

    // name label
    addSubview(profileName)
    profileName.translatesAutoresizingMaskIntoConstraints = false 
    profileName.centerXAnchor.constraint(equalTo: profileView.centerXAnchor).isActive = true
    profileName.centerYAnchor.constraint(equalTo: profileView.centerYAnchor).isActive = true
}
```

## Adding a view to your View Controller
```swift
let mainView = MainView()

override func viewDidLoad() {
    super.viewDidLoad()
    configureNavBar()
    mainView.tableView.dataSource = self
    mainView.tableView.delegate = self 
    view.addSubview(mainView)
}
```

## Presenting a View Controller 
```swift 
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = names[indexPath.row]
        let detailVC = DetailViewController(name: name)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
```

## View Controller with Custom Initializer 
```swift 
class DetailViewController: UIViewController {
    let detailView = DetailView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(detailView)
    }
    
    // Dependency Injection in View Controllers with custom initializers
    // This forces the required properties to be injected by the custom initializer
    // Avoids possible silent injection in prepare: for segue if a conditional optional is used
    // A strong reason some developers prefer programmable view controllers over storyboard
    init(name: String) {
        super.init(nibName: nil, bundle: nil)
        navigationItem.title = name
        detailView.configureView(name: name)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
```

## Exercises
## Use LayoutAnchors to achive the following:
**Exercise 1:**
<p align="center">
<img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Programmatic-View-Management/Images/exercise-1.png" width="414" height="736" />
</p>

**Exercise 2:**
<p align="center">
<img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Programmatic-View-Management/Images/exercise-2.png" width="414" height="736" />
</p>
  
## Resources 
[UIWindow](https://developer.apple.com/documentation/uikit/uiwindow)  
[Programmatically Creating Constraints](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/ProgrammaticallyCreatingConstraints.html)  
[What are lazy variables](https://www.hackingwithswift.com/example-code/language/what-are-lazy-variables) 
[Dependency Injection in View Controllers](https://medium.com/ios-os-x-development/dependency-injection-in-view-controllers-9fd7d2c77e55)  
[iOS: View Controller Data Injection with Storyboards and Segues in Swift](https://www.natashatherobot.com/ios-view-controller-data-injection-with-storyboards-and-segues-in-swift/)  
[View and Window Architecture](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/WindowsandViews/WindowsandViews.html)  
[View Hierarchy](https://developer.apple.com/library/content/documentation/General/Conceptual/Devpedia-CocoaApp/View%20Hierarchy.html)  
[How to change Auto Layout constraints after they are set when using constraintEqualToAnchor()?](https://stackoverflow.com/questions/34391732/how-to-change-auto-layout-constraints-after-they-are-set-when-using-constrainteq)

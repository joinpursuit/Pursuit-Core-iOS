# Lifecycle

## Objectives

- Understand ViewController Lifecycle Methods
- Understand AppDelegate Lifecycle Methods
- Understand SceneDelegate Lifecycle Methods

## Resources

- [Apple docs: VC Lifecycle](https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/WorkWithViewControllers.html#//apple_ref/doc/uid/TP40015214-CH6-SW3)
- [Apple docs: UIApplicationDelegate](https://developer.apple.com/documentation/uikit/uiapplicationdelegate)
- [Apple docs: UISceneDelegate](https://developer.apple.com/documentation/uikit/uiscenedelegate)



## 1. View Controller Lifecycle

![Lifecycle image](https://raw.githubusercontent.com/joinpursuit/Pursuit-Core-iOS/master/mvc-view-lifecycle/lifecycle-and-controls/images/view_lifecycle.png)

- **viewDidLoad()**

Called when the view controller’s content view (the top of its view hierarchy) is created and loaded from a storyboard. The view controller’s outlets are guaranteed to have valid values by the time this method is called. Use this method to perform any additional setup required by your view controller.

Typically, iOS calls `viewDidLoad()` only once, when its content view is first created; however, the content view is not necessarily created when the controller is first instantiated. Instead, it is lazily created the first time the system or any code accesses the controller’s view property.

- **viewWillAppear()**

Called just before the view controller’s content view is added to the app’s view hierarchy. Use this method to trigger any operations that need to occur before the content view is presented onscreen. Despite the name, just because the system calls this method, it does not guarantee that the content view will become visible. The view may be obscured by other views or hidden. This method simply indicates that the content view is about to be added to the app’s view hierarchy.

- **viewDidAppear()**

Called just after the view controller’s content view has been added to the app’s view hierarchy. Use this method to trigger any operations that need to occur as soon as the view is presented onscreen, such as fetching data or showing an animation. Despite the name, just because the system calls this method, it does not guarantee that the content view is visible. The view may be obscured by other views or hidden. This method simply indicates that the content view has been added to the app’s view hierarchy.

- **viewWillDisappear()**

Called just before the view controller’s content view is removed from the app’s view hierarchy. Use this method to perform cleanup tasks like committing changes or resigning the first responder status. Despite the name, the system does not call this method just because the content view will be hidden or obscured. This method is only called when the content view is about to be removed from the app’s view hierarchy.

**viewDidDisappear()**

Called just after the view controller’s content view has been removed from the app’s view hierarchy. Use this method to perform additional teardown activities. Despite the name, the system does not call this method just because the content view has become hidden or obscured. This method is only called when the content view has been removed from the app’s view hierarchy.


#### UIViewController.swift

```swift
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear", "isAnimated: \(animated)")
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear", "isAnimated: \(animated)")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("viewWillDisappear", "isAnimated: \(animated)")

    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear", "isAnimated: \(animated)")
    }
}
```
This includes a simple printout that informs you when each step is being called.

Create a label in the middle with the text "View Controller One"

Build and run your app.  You should see the following messages appear in the console:

```
viewDidLoad
viewWillAppear isAnimated: false
viewWillLayoutSubviews
viewWillLayoutSubviews
viewDidAppear isAnimated: false
```

Notice that `viewWillLayoutSubviews` may be called multiple times.  Don't expect code in there to only run a single time.  We see that all the Lifecycle methods involves bringing a screen to view are present.  In order to get the remaining Lifecycles, we'll need a way to make our View Controller leave the screen.  This is a good opportunity for a (brief) introduction to Segues.

Embed your View Controller in a Navigation Controller by selecting your View Controller and selecting `Editor -> Embed In -> Navigation Controller`

- Add a button to your View Controller.  
- Create a new View Controller by dragging one out from the Object Library.  
- Create a Segue from the button to the new View Controller by control dragging.

Build and rerun your app.  When you segue to the new controller, you should observe the remaining lifecycle methods being called:

```
viewWillDisappear isAnimated: true
viewDidDisappear isAnimated: true
```

Select the back button and you will see the following readout in your console:

```
viewWillAppear isAnimated: true
viewDidAppear isAnimated: true
```

## 2. Application Lifecycle

Just like a View Controller has a lifecycle, your entire application has a lifecycle.  This is conceptually separated into two different places: `AppDelegate` and `SceneDelegate`.  `AppDelegate` controls the whole application, and `SceneDelegate` controls the *scene*.

A *scene* refers to an individual instance of your app's user interface.  With the introduction of iPadOS, Apple added tools to enable support for multiple windows.  This means that a user could have multiple windows of your app displayed simultaneously.  Individual scenes have their own lifecycles as the the user creates and discards them.

By putting print statements into our `AppDelegate` and `SceneDelegate`, we can view the various lifecycle methods being called:


#### AppDelegate.swift

```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("didFinishLaunchingWithOptions")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        print("configurationForConnecting")
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        print("didDiscardSceneSessions")
    }
}
```

#### SceneDelegate.swift

```swift
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        print("Connecting a window to a scene")
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
        print("sceneDidDisconnect")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        print("sceneDidBecomeActive")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        print("sceneWillResignActive")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        print("sceneWillEnterForeground")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        print("sceneDidEnterBackground")
    }
}
```

When run through the following workstreams, we can see the following calls to lifecycle methods:

### Open an app:

- didFinishLaunchingWithOptions
- Connecting a window to a scene
- sceneWillEnterForeground
- sceneDidBecomeActive

### Kill an app:

- sceneWillResignActive
- sceneDidDisconnect
- didDiscardSceneSessions

### Open another app:

- sceneWillResignActive
- sceneDidEnterBackground

### Bring your app back from background:
- sceneWillEnterForeground
- sceneDidBecomeActive

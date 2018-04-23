# View Controller and App LifeCycle Methods

### Key Interview Questions

1. What are the different life cycle methods a ViewController calls?
2. What is the App Delegate and what does it manage?

# 1. View Controller LifeCycle

iOS calls the UIViewController methods as follows:

viewDidLoad()—Called when the view controller’s content view (the top of its view hierarchy) is created and loaded from a storyboard. The view controller’s outlets are guaranteed to have valid values by the time this method is called. Use this method to perform any additional setup required by your view controller. Typically, iOS calls viewDidLoad() only once, when its content view is first created; however, the content view is not necessarily created when the controller is first instantiated. Instead, it is lazily created the first time the system or any code accesses the controller’s view property.

viewWillAppear()—Called just before the view controller’s content view is added to the app’s view hierarchy. Use this method to trigger any operations that need to occur before the content view is presented onscreen. Despite the name, just because the system calls this method, it does not guarantee that the content view will become visible. The view may be obscured by other views or hidden. This method simply indicates that the content view is about to be added to the app’s view hierarchy.

viewDidAppear()—Called just after the view controller’s content view has been added to the app’s view hierarchy. Use this method to trigger any operations that need to occur as soon as the view is presented onscreen, such as fetching data or showing an animation. Despite the name, just because the system calls this method, it does not guarantee that the content view is visible. The view may be obscured by other views or hidden. This method simply indicates that the content view has been added to the app’s view hierarchy.

viewWillDisappear()—Called just before the view controller’s content view is removed from the app’s view hierarchy. Use this method to perform cleanup tasks like committing changes or resigning the first responder status. Despite the name, the system does not call this method just because the content view will be hidden or obscured. This method is only called when the content view is about to be removed from the app’s view hierarchy.

viewDidDisappear()—Called just after the view controller’s content view has been removed from the app’s view hierarchy. Use this method to perform additional teardown activities. Despite the name, the system does not call this method just because the content view has become hidden or obscured. This method is only called when the content view has been removed from the app’s view hierarchy.

 - [More on View Controllers](https://developer.apple.com/library/content/referencelibrary/GettingStarted/DevelopiOSAppsSwift/WorkWithViewControllers.html)


### AppDelegate - Managing Your App's LifeCycle

Apps start off not running. When the user explicitly launches the app, the app moves briefly to the inactive state before entering the active state. (An active app appears onscreen and is known as a foreground app.) Quitting an active app moves it offscreen and into the background state, where it stays until the system suspends it a short time later. At its discretion, the system may quietly terminate a suspended app, returning it to the not running state.

<p align="center">
<img src="https://docs-assets.developer.apple.com/published/cfb6ae10b1/high_level_flow_2x_2bc77269-019d-4554-83b8-6aeecb73c348.png" width="414" height="736" />
</p>

When your app transitions from one state to another, UIKit notifies your app delegate object—an object that conforms to the UIApplicationDelegate protocol. Use your app delegate to modify your app's behavior to match its new state. For example, when moving from the not running to inactive state, handle the launch-time tasks needed to prepare your app to run.

Your app’s current state defines what system resources are available to it. Because active apps are visible onscreen and must respond to user interactions, they have priority when it comes to using system resources. Background apps are not visible onscreen, and therefore have more limited access to system resources and receive limited execution time.


The system notifies your app delegate about the following transitions:

#### Launch time:
Launch. Your app transitions from the not running to the inactive or background state. Use this transition to prepare your app to run

application(_:willFinishLaunchingWithOptions:)
application(_:didFinishLaunchingWithOptions:)

#### Transitioning to the foreground:
Activation. Your app transitions from the inactive to the active state. Prepare your app to run in the foreground and be visible onscreen

applicationDidBecomeActive(_:)

#### Transitioning to the background:
Background execution. Your app transitions from the inactive or not running state to the background state. Prepare to handle only essential tasks while running offscreen

applicationDidEnterBackground(_:)

#### Transitioning to the inactive state:

Deactivation. Your app transitions from the active to the inactive state. Quiet your app, perhaps only temporarily; see Preparing Your App to Run in the Background.

applicationWillResignActive(_:) (Called when leaving the foreground state.)
applicationWillEnterForeground(_:) (Called when transitioning out of the background state.)

#### Termination:
Your app transitions from any running state to the not running state. (Suspended apps are not notified when they are terminated.) Cancel all tasks and prepare to exit; see applicationWillTerminate(_:).

applicationWillTerminate(_:) (Called only when the app is running. This method is not called if the app is suspended.)


The specific tasks you perform during a given state transition are dependent upon your app and its capabilities. 

Your app delegate also responds to some other important events:
- Memory warnings. Reduce the amount of memory your app uses; see Responding to Memory Warnings.
- Time changes. Update time-sensitive features of your app.
- Protected data becomes available/unavailable. Manage files when the user locks or unlocks the device.
- State restoration. Restore your app’s UI to its previous state, giving the appearance that your app never stopped running; see Preserving Your App's UI Across Launches.
- Handoff tasks. Continue tasks started on another device.
- Open URLs. Receive and open URLs sent to your app.
- Inter-app communication. Receive data from a paired watchOS app.
- File downloads. Receive files that your app downloaded using a URLSession object.

Although the app delegate is the primary place where you handle life cycle events, it is not the only place. For most events, UIKit also generates notifications that any object can observe. For a list of app-related notifications that you can observe, see UIApplication. For more information about the methods you use to handle events, see [More on AppDelegate](https://developer.apple.com/documentation/uikit/uiapplicationdelegate)



### Readings
1. [The App Lifecycle](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/TheAppLifeCycle/TheAppLifeCycle.html)
2. [Strategies for handling App Transitions](https://developer.apple.com/library/content/documentation/iPhone/Conceptual/iPhoneOSProgrammingGuide/StrategiesforHandlingAppStateTransitions/StrategiesforHandlingAppStateTransitions.html)
 



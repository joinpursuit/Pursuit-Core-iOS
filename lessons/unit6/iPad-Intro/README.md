## iPad 

## Objectives 
* Using UISplitViewController on iPad and iPhone Plus Devices 
* Presenting Popovers on iPad 

## UISplitViewController 
A split view controller is a container view controller that manages two child view controllers in a master-detail interface. In this type of interface, changes in the primary view controller (the master) drive changes in a secondary view controller (the detail). The two view controllers can be arranged so that they are side-by-side, so that only one at a time is visible, or so that one only partially hides the other. In iOS 8 and later, you can use the UISplitViewController class on all iOS devices; in previous versions of iOS, the class is available only on iPad.

Supported Devices: 
* iPads 
* iPhone Plus Devices 

```swift 
// configure the split view controller
let fellowsSplitVC = FellowsSplitViewController.storyboardInstance()
fellowsSplitVC.preferredDisplayMode = .allVisible
window = UIWindow(frame: UIScreen.main.bounds)
window?.rootViewController = fellowsSplitVC
window?.makeKeyAndVisible()
```

```swift 
// configure showing the selected details of a cell from the master view controller
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    collapseSecondaryController = false
    guard let navController = segue.destination as? UINavigationController,
        let detailVC = navController.viewControllers.first as? DetailViewController,
        let cell = sender as? FellowCell,
        let indexPath = tableView.indexPath(for: cell) else {
            fatalError("can't segue to detail view controller")
    }
    let fellow = fellows[indexPath.row]
    detailVC.fellow = fellow
}
```

```swift 
// set the delegate to get notification for compact sizes 
// in those cases collapse the detail view controller so the root view is shown first 
override func viewDidLoad() {
  super.viewDidLoad()
  splitViewController?.delegate = self
}
```

```swift 
private var collapseSecondaryController = true
```

```swift 
// MARK:- Split View Controller Delegate
extension FellowsViewController: UISplitViewControllerDelegate {
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return collapseSecondaryController
    }
}
```

When building your app’s user interface, the split view controller is typically the root view controller of your app’s window, but it may be embedded in another view controller. The split view controller has no significant appearance of its own. Most of its appearance is defined by the child view controllers you install. You can configure the child view controllers using Interface Builder or programmatically by assigning the view controllers to the viewControllers property. The child view controllers can be custom view controllers or other container view controller, such as navigation controllers.

## UIPopoverPresentationController
From the time a popover is presented until the time it is dismissed, UIKit uses an instance of this class to manage the presentation behavior. You use instances of this class as-is to configure aspects of the popover appearance and behavior for view controllers whose presentation style is set to popover.

In nearly all cases, you use this class as-is and do not create instances of it directly. UIKit creates an instance of this class automatically when you present a view controller using the popover style. You can retrieve that instance from the presented view controller’s popoverPresentationController property and use it to configure the popover behavior.

If you do not want to configure a popover immediately after presenting a view controller, you can use a delegate object to configure the popover instead. During the presentation process, the popover presentation controller calls various methods of its delegate—an object that conforms to the UIPopoverPresentationControllerDelegate protocol—to ask for information and to inform it about the state of the presentation. Your delegate object can use those methods to configure the popover and adjust its behavior as needed. For information about how to implement a delegate for a popover presentation controller, see UIPopoverPresentationControllerDelegate.

```swift 
// this showAlert() is cofigured to show a popover on iPad and alertSheet on iPhone
@objc private func share() {
    guard let fellowImage = profileImage.image else { print("no image to share"); return }
    let activityController = UIActivityViewController(activityItems: [fellowImage, "Here is the link to \(fellow.name)'s Github page: \(fellow.githubURL)"], applicationActivities: nil)
    let popOver = activityController.popoverPresentationController
    activityController.modalPresentationStyle = .popover
    popOver?.sourceView = view
    popOver?.sourceRect = shareButton.frame
    present(activityController, animated: true, completion: nil)
}
```  

## Resources 
|Resources|Summary|
|:-----|:-----|
|[Use your loaf](https://useyourloaf.com/blog/split-view-controller-display-modes/)|Split View Controller Display Modes|
|[Hacking with Swift](https://www.hackingwithswift.com/example-code/uikit/how-to-create-popover-menus-using-uipopoverpresentationcontroller)|How to create popover menus using UIPopoverPresentationController|
|[UIPopoverPresentationController](https://developer.apple.com/documentation/uikit/uipopoverpresentationcontroller)|An object that manages the display of content in a popover|
|[UISplitViewController](https://developer.apple.com/documentation/uikit/uisplitviewcontroller)|A container view controller that implements a master-detail interface|
|[Use Multitasking on your iPad](https://support.apple.com/en-us/HT207582)|On your iPad with iOS 11, you can use Multitasking to work with two apps at the same time, answer emails while watching a video, switch apps using gestures, and more|
|[UISplitViewControllerDelegate](https://developer.apple.com/documentation/uikit/uisplitviewcontrollerdelegate)|Use the methods of this protocol to respond to changes in the current display mode and to the current interface orientation|


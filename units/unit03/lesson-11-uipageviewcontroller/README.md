## UIPageViewController

A UIPageViewController allows you to link several viewcontrollers and swipe on them to cycle through them. 

![Alt Text](https://media.giphy.com/media/836BQXnHcfYLxMNSwH/giphy.gif)



When using a UIPageViewController, you will have to conform to UIPageViewControllerDataSource in order to set up the viewcontrollers. This is NOT done in storyboard. When you conform,  you will have to use two required methods:


```swift
func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
      //the viewcontroller before the one you are currently looking at
    }
    
func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            //the viewcontroller after the one you are currently looking at

    }
```


You also have to set the first ViewController to be seen when the UiPageViewController is first loaded. This can be done in the viewDidLoad:

```swift
setViewControllers([allViewControllers[0]], direction: .forward, animated: true, completion: nil)

```

take note that the first parameter is a single viewcontroller in an array!



Project Link:
https://github.com/lynksdomain/PageViewControllerExample

Apple Docs:
https://developer.apple.com/documentation/uikit/uipageviewcontroller

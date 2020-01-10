# Lifecycle

## Objectives

- Understand ViewController Lifecycle Methods
- Understand AppDelegate Lifecycle Methods
- Understand SceneDelegate Lifecycle Methods
- Use deeplinking in a iOS application

## Resources

-

## 1. View Controller Lifecycle

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



# 3. Deeplinking

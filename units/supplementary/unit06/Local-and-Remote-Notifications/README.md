## Local and Remote Notifications

Local notifications and remote notifications are ways to inform users when new data becomes available for your app, even when your app is not running in the foreground. For example, a messaging app might let the user know when a new message has arrived, and a calendar app might inform the user of an upcoming appointment. Both local and remote notifications require you to add code to support the scheduling and handling of notifications in your app. For remote notifications, you must also provide a server environment that is capable of receiving data from user devices and sending notification-related data to the Apple Push Notification service (APNs), which is an Apple-provided service that handles the delivery of remote notifications to user devices.

## Objectives
* What are Notifications
* What types of Notifications are available 
* What is Local Notification 
* What is Remote Notification 
* Setting up APNS - Apple Push Notification Service 
* Receiving Notifications

## Local Notification 
With local notifications, your app configures the notification details locally and passes those details to the system, which then handles the delivery of the notification when your app is not in the foreground. Local notifications are supported on iOS, tvOS, and watchOS.

## Remote Notification 
With remote notifications, you use one of your company’s servers to push data to user devices via the Apple Push Notification service. Remote notifications are supported on iOS, tvOS, watchOS, and macOS.

## The User Notifications and User Notifications UI Frameworks
The User Notifications framework also supports the creation of notification service app extensions, which let you modify the content of remote notifications before they are delivered. If you include a notification service app extension with your app, the system passes incoming notifications to your extension before delivering them to the user. You might use this type of extension to implement end-to-end encryption for your app’s notifications, to modify the notification content before delivery, or to download additional images or media related to the notification.

The User Notifications UI framework is a companion to the User Notifications framework that lets you customize the appearance of the system’s notification interface. You use the User Notifications UI framework to define a notification content app extension, whose job is to provide a view controller with custom content to display in the notification interface. The system displays your custom view controller instead of the default system interface. You might use this type of extension to incorporate media or dynamic content into your notification interfaces.

## Managing Your App’s Notification Support
Apps must be configured at launch time to support local and remote notifications. Specifically, you must configure your app in advance if it does any of the following:

* Displays alerts, play sounds, or badges its icon in response to an arriving notification.
* Displays custom action buttons with a notification.

Typically, you perform all of your configuration before your application finishes launching. In iOS and tvOS, this means configuring your notification support no later than the application:didFinishLaunchingWithOptions: method of your UIApplication delegate. In watchOS, configure that support no later than the applicationDidFinishLaunching method of your WKExtension delegate. You may perform this configuration at a later time, but you must avoid scheduling any local or remote notifications targeting your app until this configuration is complete.

Apps that support remote notifications require additional configuration, which is described in Configuring Remote Notification Support.

Requesting authorization for user interactions
```swift
let center = UNUserNotificationCenter.current()
center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
    // Enable or disable features based on authorization.
}
```

## Types of Trigger Notifications 
* Push (exclusively with Remote Notifications) - [UNPushNotificationTrigger()](https://developer.apple.com/documentation/usernotifications/unpushnotificationtrigger) 
* Time Interval - [UNTimeIntervalNotificationTrigger()](https://developer.apple.com/documentation/usernotifications/untimeintervalnotificationtrigger)  
* Calendar - [UNCalendarNotificationTrigger()](https://developer.apple.com/documentation/usernotifications/uncalendarnotificationtrigger)  
* Location - [UNLocationNotificationTrigger()](https://developer.apple.com/documentation/usernotifications/unlocationnotificationtrigger)  

## Configuring Local Notifications:

* Create and configure a UNMutableNotificationContent object with the notification details.
* Create a UNCalendarNotificationTrigger, UNTimeIntervalNotificationTrigger, or UNLocationNotificationTrigger object to describe the conditions under which the notification is delivered.
* Create a UNNotificationRequest object with the content and trigger information.
* Call the addNotificationRequest:withCompletionHandler: method to schedule the notification; see Scheduling Local Notifications for Delivery

```swift
let content = UNMutableNotificationContent()
content.title = NSString.localizedUserNotificationString(forKey: "Kitchen Alarm", arguments: nil)
content.body = NSString.localizedUserNotificationString(forKey: "Turn off the stove. Eggs are done",
                                                        arguments: nil)
content.sound = UNNotificationSound.default()

// Configure the trigger
let thisTime:TimeInterval = 30.0
let trigger = UNTimeIntervalNotificationTrigger(timeInterval: thisTime, repeats: false)

// Create the request object.
let request = UNNotificationRequest(identifier: "KitchenAlarm", content: content, trigger: trigger)

// Schedule the request.
//let center = UNUserNotificationCenter.current()
center.add(request) { (error : Error?) in
    if let theError = error {
        print(theError.localizedDescription)
    } else {
        print("scheduled")
    }
}
```

**In app notifications**
```swift 
// in app notifications 
extension PodcastViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
}
```

## Configuring Remote Push Notifications 

### Apple Push Notification Service 

Apple Push Notification service Overview
Apple Push Notification service (APNs) is the centerpiece of the remote notifications feature. It is a robust, secure, and highly efficient service for app developers to propagate information to iOS (and, indirectly, watchOS), tvOS, and macOS devices.

On initial launch of your app on a user’s device, the system automatically establishes an accredited, encrypted, and persistent IP connection between your app and APNs. This connection allows your app to perform setup to enable it to receive notifications, as explained in Configuring Remote Notification Support.

The other half of the connection for sending notifications—the persistent, secure channel between a provider server and APNs—requires configuration in your online developer account and the use of Apple-supplied cryptographic certificates. A provider is a server, that you deploy and manage, that you configure to work with APNs. Figure 6-1 shows the path of delivery for a remote notification.

<p align="center">
<img src="https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/Art/remote_notif_simple_2x.png" width="691" height="132" />
</p>

**Prerequisites:**
* An iOS Device 
* Be part of the developer program to enable APNs
* Provider (Server) which pushes out the notification payload to devices 

### Configuring APNs with FCM - Firebase Cloud Messaging 
The Firebase Cloud Messaging APNs interface uses the Apple Push Notification service (APNs) to send messages up to 4KB in size to your iOS app, including when it is in the background.

**To enable sending Push Notifications through APNs, you need:**
* An Apple Push Notification Authentication Key for your Apple Developer account. Firebase Cloud Messaging uses this token to send Push Notifications to the application identified by the App ID.
* A provisioning profile for that App ID.
You create both in the [Apple Developer Member Center](https://developer.apple.com/membercenter/index.action).  

**To create an authentication key:**
1. In your developer account, go to Certificates, Identifiers & Profiles, and under Keys, select All.
2. Click the Add button (+) in the upper-right corner.
3. Enter a description for the APNs Auth Key
4. Under Key Services, select the APNs checkbox, and click Continue.
5. Click Confirm and then Download. Save your key in a secure place. **This is a one-time download, and the key cannot be retrieved later.**  
_**From Apple: After downloading your key, it cannot be re-downloaded as the server copy is removed. If you are not prepared to download your key at this time, click Done and download it at a later time. Be sure to save a backup of your key in a secure place.**_
_If you'd like to verify that your APNs authentication key is set up properly and is accepted by APNs, try sending a test push notification._

**Create an App ID** 
An App ID is an identifier that uniquely identifies an app. As a convention it is represented by a reversed domain (e.g. com.google.samples.firebaseexample).
* Navigate to the Apple Developer Member Center and sign in
* Navigate to Certificates, Identifiers and Profiles
[continued steps](https://firebase.google.com/docs/cloud-messaging/ios/certs)   

**Create the Provisioning Profile**
To test your app while under development, you need a Provisioning Profile for development to authorize your devices to run an app that is not yet published on the App Store.
[continued steps](https://firebase.google.com/docs/cloud-messaging/ios/certs)   


### Upload your APNs authentication key to the Provider (Server) e.g Firebase

**Register for remote notifications**
```swift 
func application(_ application: UIApplication,
                 didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Configure the user interactions first.
    self.configureUserInteractions()
    
    // Register with APNs
    UIApplication.shared.registerForRemoteNotifications()
}
 
// Handle remote notification registration.
func application(_ application: UIApplication,
                 didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data){
    // Forward the token to your provider, using a custom method.
    self.enableRemoteNotificationFeatures()
    self.forwardTokenToServer(token: deviceToken)
}
 
func application(_ application: UIApplication,
                 didFailToRegisterForRemoteNotificationsWithError error: Error) {
    // The token is not currently available.
    print("Remote notification support is unavailable due to error: \(error.localizedDescription)")
    self.disableRemoteNotificationFeatures()
}
```
### Send a Test Remote notification message using Firebase Messaging

```swift 
// Set the messaging delegate in applicationDidFinishLaunchingWithOptions
Messaging.messaging().delegate = self

extension AppDelegate: MessagingDelegate {
    // Receive the current registration token
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")

        // TODO: If necessary send token to application server.
        // Note: This callback is fired at each app startup and whenever a new token is generated.

        let token = Messaging.messaging().fcmToken
        print("FCM token: \(token ?? "")")
    }
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("didReceive remoteMessage: \(remoteMessage)")
    }
}
```

An example apn payload
```json
{
  "interests": [
    "hello"
  ],
  "apns": {
    "aps": {
      "alert": {
        "title": "It's Friday",
        "body": "Woohoo!"
      }
    }
  }
}
```

## Firebase Cloud Functions
Run your mobile backend code without managing servers
[Node.js®](https://nodejs.org/en/) is a JavaScript runtime built on Chrome's V8 JavaScript engine. Node.js uses an event-driven, non-blocking I/O model that makes it lightweight and efficient. Node.js' package ecosystem, npm, is the largest ecosystem of open source libraries in the world.

To use Cloud Functions, you need to install Firebase command line tools using [npm (Node.js)](https://www.npmjs.com/get-npm)  
> $ npm install -g firebase-tools

Open a terminal window and navigate to the directory for your code:
> Initiate your project: $ firebase init
> Deploy your functions: $ firebase deploy

## Resources 
|Resource|Summary|
|:------|:------|
|[Notifications Guide](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/#//apple_ref/doc/uid/TP40008194-CH3-SW1)|Local and Remote Notification Programming Guide|
|[Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging/)|Cross-platform messaging solution that lets you reliably deliver messages at no cost|
|[RW Push Notifications](https://www.raywenderlich.com/156966/push-notifications-tutorial-getting-started)|Push Notifications Tutorial: Getting Started|

## Notifications

## [In class demo](https://github.com/joinpursuit/Pursuit-Core-iOS-ToDoList-Local-Notifications)   

Local notifications and remote notifications are ways to inform users when new data becomes available for your app, even when your app is not running in the foreground. For example, a messaging app might let the user know when a new message has arrived, and a calendar app might inform the user of an upcoming appointment. Both local and remote notifications require you to add code to support the scheduling and handling of notifications in your app. For remote notifications, you must also provide a server environment that is capable of receiving data from user devices and sending notification-related data to the Apple Push Notification service (APNs), which is an Apple-provided service that handles the delivery of remote notifications to user devices.


## Local Notification 
With local notifications, your app configures the notification details locally and passes those details to the system, which then handles the delivery of the notification when your app is not in the foreground. Local notifications are supported on iOS, tvOS, and watchOS.


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

```import UserNotifications``` 

* Create and configure a UNMutableNotificationContent object with the notification details.
* Create a UNCalendarNotificationTrigger, UNTimeIntervalNotificationTrigger, or UNLocationNotificationTrigger object to describe the conditions under which the notification is delivered.
* Create a UNNotificationRequest object with the content and trigger information.
* Call the addNotificationRequest:withCompletionHandler: method to schedule the notification; see Scheduling Local Notifications for Delivery

```swift
let content = UNMutableNotificationContent()
content.title = NSString.localizedUserNotificationString(forKey: item.title, arguments: nil)
content.body = NSString.localizedUserNotificationString(forKey: item.description, arguments: nil)
content.sound = UNNotificationSound.default

let date = datePicker.date

let calendar = Calendar.current
let hour = calendar.component(.hour, from: date)
let minute = calendar.component(.minute, from: date)

var dateComponents = DateComponents()
dateComponents.hour = hour
dateComponents.minute = minute
dateComponents.timeZone = TimeZone.current

let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

let request = UNNotificationRequest(identifier: "To do list Alert", content: content, trigger: trigger)

UNUserNotificationCenter.current().add(request) { (error) in
  if let error = error {
    print("adding request error: \(error)")
  } else {
    print("scheduled alert")
  }
}
```

**In app notifications**
Make user the set the UNUserNotificationCenter delegate
```swift 
UNUserNotificationCenter.current().delegate = self
```

```swift 
// in app notifications 
extension ItemDetailViewController: UNUserNotificationCenterDelegate {
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    completionHandler([.alert, .sound])
  }
}
```

## Resources 
|Resource|Summary|
|:------|:------|
|[Notifications Guide](https://developer.apple.com/library/content/documentation/NetworkingInternet/Conceptual/RemoteNotificationsPG/#//apple_ref/doc/uid/TP40008194-CH3-SW1)|Local and Remote Notification Programming Guide|

# Firebase Authentication

## Reference

* [iOS Keyboard](https://developer.apple.com/library/content/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html)
* [ScrollView](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/WorkingwithScrollViews.html#//apple_ref/doc/uid/TP40010853-CH24-SW1)
* [Notifications](https://developer.apple.com/reference/foundation/nsnotification)
* [Firebase Authentication](https://firebase.google.com/docs/auth/ios/manage-users)

## Why?

Login is a feature we're all familiar with as users. The motivations for using Firebase for login could be among the following:

* it's simple
* you don't have the means to otherwise build a login system
* you want to use other features of Firebase (database or file storage) and tie users to it
* it, like other BaaS, is cost efficient and reliable

> NB: Apple has strict acceptance rules about collecting user information. If you offer login in your app you must be sure you provide logged in users with something that depends upon it. A human will check this.

## Interface

In terms of time spent and lines of code we'll be looking mostly at some of the design 
patterns that go into building login and registration. The API calls themselves are not
complicated or surprising.

### Login/Registration Form

We're going to combine the two and there are a number of patterns for this you see in the wild.
Some apps segue (or other transition) between login and registration. We'll put both on the
same form to keep it simpler to build (but maybe not simpler to use).

**Passwords** tend not to come with that "confirm password" on mobile we see so often on the web.

This is because:

* it's hard to type on a phone 
* phones are more personal devices usually with just one user
* it's easier to physically manipulate them so noone sees your typing
* there's often a confirmation email to activate the account

Overall, the objective is to remove the barrier to entry and keep things simple. Information 
can be gathered incrementally.


## Post login

Now that you're logged into the app you want to get the current user. If login is required
you probably don't need to keep checking to see if the user is logged in. In other use cases
where an app has some anonymous features and others for logged in users you might need to 
check for the user and optionally prompt for login. 


## Don't forget Logout

Logout is commonly found in a settings or profile page found either in a tab, activated by
a button in the nav bar or in a side drawer. What's common to all good approaches is that
it be factored to one place that's basically easily accessible. Consider 
(**but don't do**) the alternative: embedding a logout button in each view controller in the app
 — not a sustainable approach.

## Firebase

Log into Firebase and either create a new project or use an existing one. If you use 
an existing project you can further decide whether to use an existing app (id = bundle)
or create a new app. Follow the iOS integration instructions.

In order to use Authentication in Firebase on iOS you need to visit the "Authentication"
left-menu item and enable at least one "Sign-In Method" (second top tab). Firebase's
stand-alone auth is "Email/Password" and that's what we'll be building now.

To use Firebase's Auth API in your app you need to install the ```Firebase/Auth``` CocoaPod.
Either edit the Podfile or ```pod init``` and add ```pod 'Firebase/Auth'``` in the appropriate
place. End result is something like this:

```ruby
# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'MyProject' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for MyProject
  pod 'Firebase/Auth'

end
  pod 'Firebase/Auth'
```
Save, and run ```pod install```.

## The Keyboard

Instead of delegation or KVO interacting with the keyboard uses Notifications (NSNotification).
This is another way of listening for broadcasted changes. Things to know about notifications:

* They are not the same as Local or Remote (APN) notifications. I.e. they're not the system
	by which you get those alerts on your phone. It's an unfortunate overlap in terms.
* They execute **synchronously**. This means that when one object posts a notification, all
	registered observers (if any) will execute their code before that line of code returns.
* There might be any number of objects observing the same notification. They will all be called
	but the order is not defined, controllable or knowable.

```swift
private func registerForKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
    
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
}
```

Apple's recommended approach is pretty good but it may not be perfect in every situation.

```swift
func keyboardWillShow(_ notification: Notification) {
    if let info = notification.userInfo,
        let sizeString = info[UIKeyboardFrameBeginUserInfoKey] as? NSValue {
        
        // get the size of the keyboard
        // Apple tells us to only look at its height
        let keyboardSize = sizeString.cgRectValue
        
        // insets are a way to offset content in a scrollview without changing the 
        // content itself: inset ~ margin ~ offset
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
       
        // the scrollview wasn't scrolling before because its content was smaller
        // than its frame and after the next line its content will be the same size
        // but it will become scroll*able* when we add an inset the size of the keyboard
        scrollView.contentInset = contentInsets
        
        // make sure the indicators (aka scrollbars)
        // reflect the new inset
        scrollView.scrollIndicatorInsets = contentInsets
        
        // All is well if the field we're on is already in view.
        // The page is now actively scrollable
        
        // this is the whole vc
        var rect = self.view.frame
        
        // this is the height above the keyboard
        rect.size.height -= keyboardSize.height
        
        if let field = activeField {
            // if the area above the keyboard doesn't intersect with the origin (top left)
            // of the current field scroll the whole field into view
            if !rect.contains(field.frame.origin) {
                scrollView.scrollRectToVisible(field.frame, animated: true)
            }
        }
    }
}
    
func keyboardWillHide(_ notification: Notification) {
    // put everything back to what it was before
    scrollView.contentInset = .zero;
    scrollView.scrollIndicatorInsets = .zero;
}
```

## Exercise

Break into 8 groups, 2 for each of Google, Facebook, Twitter, and Github and implement
the "federated authentication" for your service following the instructions in Firebase.

* [Google](https://firebase.google.com/docs/auth/ios/google-signin)
* [Facebook](https://firebase.google.com/docs/auth/ios/facebook-login)
* [Twitter](https://firebase.google.com/docs/auth/ios/twitter-login)
* [Github](https://firebase.google.com/docs/auth/ios/github-auth)


1. Create a main view controller and a login view controller.
1. Detect whether the user is authenticated in your "main" view controller and present
	the login view controller if they're not.
1. The login view controller should first support email/password auth and then the 
	federated auth method you're working on.
1. Upon successful dismissal of the login view controller.
1. Show user information and a logout button on the main view controller.



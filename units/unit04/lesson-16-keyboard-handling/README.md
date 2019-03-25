
# Keyboard Handling 


## [In class demo](https://github.com/joinpursuit/Pursuit-Core-iOS-Keyboard-Handling)     

When users touch a text field, a text view, or a field in a web view, the system displays a keyboard. You can configure the type of keyboard that is displayed along with several attributes of the keyboard. You also have to manage the keyboard when the editing session begins and ends. Because the keyboard could hide the portion of your view that is the focus of editing, this management might include adjusting the user interface to raise the area of focus so that is visible above the keyboard.


## Notification Center 

A notification dispatch mechanism that enables the broadcast of information to registered observers.

**Overview**   
Objects register with a notification center to receive notifications (NSNotification objects) using the addObserver(_:selector:name:object:) or addObserver(forName:object:queue:using:) methods. When an object adds itself as an observer, it specifies which notifications it should receive. An object may therefore call this method several times in order to register itself as an observer for several different notifications.

Each running app has a default notification center, and you can create new notification centers to organize communications in particular contexts.

A notification center can deliver notifications only within a single program; if you want to post a notification to other processes or receive notifications from other processes, use DistributedNotificationCenter instead.

## UIResponder 

An abstract interface for responding to and handling events.

**Type Properties**  (we register for the following two notifications using UIResponder())   
- keyboardWillShowNotification
- keyboardWillHideNotification

## Receiving Keyboard Notifications

- UIKeyboardWillShowNotification
- UIKeyboardDidShowNotification
- UIKeyboardWillHideNotification
- UIKeyboardDidHideNotification

## Full View Controller Implementation   

This code snippet moves the view upwards equal to the keyboard's height when the keyboard is presented. The height of the keyboard's frame is found from the userInfo notification dictionary. 
```swift 
@objc private func willShowKeyboard(notification: Notification) {
  guard let info = notification.userInfo,
    let keyboardFrame = info["UIKeyboardFrameEndUserInfoKey"] as? CGRect else {
    print("userinfo is nil")
    return
  }
  containerView.transform = CGAffineTransform(translationX: 0, y: -keyboardFrame.height)
}
```

This code snippet returns the container view to it's original frame using the view's CGAffineTransform.Idenity. 
```swift 
@objc private func willHideKeyboard(notification: Notification) {
  containerView.transform = CGAffineTransform.identity
}
```

We make sure to register for Notifications from the keyboard and unregister when the view controller is out of the view hierarchy. 

<details> 
  <summary>Implementation</summary> 
  
```swift 
class ViewController: UIViewController {
  
  @IBOutlet weak var usernameTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var containerView: UIView!

  override func viewDidLoad() {
    super.viewDidLoad()
    usernameTextField.delegate = self
    passwordTextField.delegate = self
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(true)
    registerKeyboardNotifications()
  }
  
  private func registerKeyboardNotifications() {
    NotificationCenter.default.addObserver(self, selector: #selector(willShowKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(willHideKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  private func unregisterKeyboardNofications() {
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(true)
    unregisterKeyboardNofications()
  }
  
  deinit {
    // clean up views
    // clean up memory
    // can also unregister for notification here
  }
  
  @objc private func willShowKeyboard(notification: Notification) {
    guard let info = notification.userInfo,
      let keyboardFrame = info["UIKeyboardFrameEndUserInfoKey"] as? CGRect else {
      print("userinfo is nil")
      return
    }
    containerView.transform = CGAffineTransform(translationX: 0, y: -keyboardFrame.height)
  }
  
  @objc private func willHideKeyboard(notification: Notification) {
    containerView.transform = CGAffineTransform.identity
  }
  
  @IBAction func loginButtonPressed(_ sender: UIButton) {
    usernameTextField.resignFirstResponder()
    passwordTextField.resignFirstResponder()
  }
}

extension ViewController: UITextFieldDelegate {
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    return true
  }
}
```
  
</details> 

## Reading

[Managing the keyboard](https://developer.apple.com/library/archive/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html)  

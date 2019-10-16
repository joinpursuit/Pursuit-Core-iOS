# NotificationCenter / Scroll View / Gestures / Keyboard Handling 


## [Repo Link](https://github.com/joinpursuit/Pursuit-Core-iOS-Keyboard-Handling)     

# Objectives

1. Use NotificationCenter to respond to system events
2. Embed views inside ScrollViews to allow the user to scroll through content too large for its frame
3. Use UIGestureRecognizer subclasses to respond to taps and swipes


# 1. NotificationCenter

[**NotificationCenter**](https://developer.apple.com/documentation/foundation/notificationcenter) is the process by which iOS broadcasts system information.  As your application runs, it constantly is sending out information about changes that occur.  [Here](https://developer.apple.com/documentation/foundation/nsnotification.name) are some examples:

- [EKEventStoreChanged](https://developer.apple.com/documentation/foundation/nsnotification.name/1507525-ekeventstorechanged)
- [NSCalendarDayChanged](https://developer.apple.com/documentation/foundation/nsnotification.name/1408062-nscalendardaychanged)
- [selectionDidChangeNotification](https://developer.apple.com/documentation/appkit/nstableview/1529580-selectiondidchangenotification)
- [UIKeyboardWillShow](https://developer.apple.com/documentation/uikit/uiresponder/1621602-keyboarddidshownotification)

Many of these Notifications are things that we have learned about through other methods, such as delegation.  These notifications are constantly being broadcast to anyone who might be paying attention.  So how do we pay attention?

### Adding an observer

You can "tune in" to broadcasts from the default NotificationCenter using the following [method](https://developer.apple.com/documentation/foundation/notificationcenter/1415360-addobserver):

```swift
func addObserver(_ observer: Any, 
		selector aSelector: Selector, 
		name aName: NSNotification.Name?, 
		object anObject: Any?)
```

- The *observer* is who we want to pay attention, usually a View Controller.
- The *selector* is the method that we want to handle the notification
- The *name* is the name of the notification we want to tune into
- The *object* is the sender of the notification.  Typically, we leave this as nil, meaning that we want to pay attention to the notification regardless of who sent it.

This code shows *all* the Notifications that are posted inside your program.

```
NotificationCenter.default.addObserver(self, selector: #selector(handleNotification(sender:)), name: nil, object: nil)
```

Here, we want to pay attention when the keyboard is about to display.

```swift
NotificationCenter.default.addObserver(self, 
					selector: #selector(handleKeyboardAppearing(sender:)), 
					name: UIResponder.keyboardWillShowNotification, 
					object: nil)
```


### Building the selector for an observer

When we build the method to handle notifications, we add the sender into the signature.

```swift
@objc func handleKeyboardAppearing(sender: Notification) {

}
```

The `Notification` sender has a property called `userInfo`, which is a dictionary containing information that might be helpful.  You can print out this dictionary to see all possible keys.  In this particular case, we want to pay attention to the keyboard's final size.

```swift
@objc func handleKeyboardAppearing(sender: Notification) {
    guard let infoDict = sender.userInfo else { return }
    guard let rectValue = infoDict["UIKeyboardFrameEndUserInfoKey"] as? CGRect else { return }
    print("The keyboard is \(rectValue.height) by \(rectValue.width)")
}
```

# Keyboard handling

We now know that we can "tune in" and get information about the keyboard coming out.  What might we want to do with this information?  Let's consider a common use case.  Imagine an app where we want to add a caption to an image.  

### Creating the app

Let's add a custom view that our view controller will manage. We'll need the following subviews:

```swift
lazy var captionLabel: UILabel = {
    let lab = UILabel()
    lab.text = "Caption" 
    return lab
}()
    
lazy var textField: UITextField = {
    let tf = UITextField()
    tf.placeholder = "Enter a caption for the image"
    return tf
}()
    
lazy var submitButton: UIButton = {
    let but = UIButton()
    but.setTitle("Submit", for: .normal)
    but.addTarget(self, action: #selector(handleButtonPressed), for: .touchUpInside)
    return but
}()
    
lazy var imageView: UIImageView = {
    let iv = UIImageView()
    iv.backgroundColor = .yellow
    return iv
}()
```

And the following constraints:

```swift
private func configureConstraints() {
    configureCaptionLabel()
    configureTextField()
    configureSubmitButton()
    configureImageView()
}
    
    
private func configureCaptionLabel() {
    captionLabel.translatesAutoresizingMaskIntoConstraints = false
    captionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
    captionLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
}

private func configureTextField() {
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -20).isActive = true
    textField.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
}

private func configureSubmitButton() {
    submitButton.translatesAutoresizingMaskIntoConstraints = false
    submitButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    submitButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
}

private func configureImageView() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
    imageView.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -100).isActive = true
    imageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
    imageView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
}
```

Let's try to go through the user experience of adding a caption.  When we select the text field, the keyboard comes up and obstructs our view.  The user can't see the text that they are typing!  Let's try to clean it up.

### Reconstraining views

One method to fix this problem is to move up all of the views to accomodate for the keyboard.  In looking at the constraints we have defined, the only thing setting the bottom of the frames is ultimately the submit button.  By shifting the button up, we will shift all other views up as well.

But how do we know how much to move up the submit button?  We can register for the keyboard appearing notification and tell our view to move up by the appropriate amount.

 
The first thing we need to do is refactor the constraint for the button.  Instead of defining the constraint inside our method, we will create a constraint as an instance property of our custom view.

```swift 
var buttonBottomConstraint = NSLayoutConstraint()

private func configureSubmitButton() {
    submitButton.translatesAutoresizingMaskIntoConstraints = false
    buttonBottomConstraint = submitButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
    buttonBottomConstraint.isActive = true
    submitButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor).isActive = true
}
```

Then, we will create a function that can reset the constraint.

```swift
public func moveViewsToAccommodateKeyboard(with rect: CGRect, and duration: Double) {
    let size = rect.size
    buttonBottomConstraint.constant = -(size.height + 20)
    UIView.animate(withDuration: duration){
        self.layoutIfNeeded()
    }
}
```

Now, all of our views will shift upwards!

This works well, but what if the content would be clipped and go off the screen to the top?  We can use a second strategy by embedding our entire UI into a *scroll view*.

# 2. Scroll Views

A [scroll view](https://developer.apple.com/documentation/uikit/uiscrollview) is a view that allows for scrolling through its contained views.  We have already been making heavy use of scroll views through table views, collection views, and text views.   Rather than using these built in classes, we can create our own scroll views.

Scroll views can be a little tricky.  A scroll view should have one view as its subview that we call its `contentView`.  This view can have any number of subviews.  We pin the contentView to the scroll view and put the scroll view wherever we want to.  The trick behind a scroll view is that the views contained in the contentView can be larger than the contentView.  The scroll view will allow us to view the elements that would usualy be clipped by swiping up and down.

### Scrolling through an image view

One common use case is panning through images that are too large for the device.

```swift
class ImageScrollViewController: UIViewController {

    lazy var imageView: UIImageView = {
       let iv = UIImageView()
        iv.image = UIImage(named: "shire")
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    var scrollView = UIScrollView()
    var contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contentView.addGestureRecognizer(pinchRecognizer)
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let _ = scrollView.constraintsToPinToEdges(of: view).map{ $0.isActive = true }
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let _ = contentView.constraintsToPinToEdges(of: scrollView).map{ $0.isActive = true }
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let _ = imageView.constraintsToPinToEdges(of: contentView).map{ $0.isActive = true }
    }
}


extension UIView {
    func constraintsToPinToEdges(of view: UIView) -> [NSLayoutConstraint] {
        return [leadingAnchor.constraint(equalTo: view.leadingAnchor),
                trailingAnchor.constraint(equalTo: view.trailingAnchor),
                topAnchor.constraint(equalTo: view.topAnchor),
                bottomAnchor.constraint(equalTo: view.bottomAnchor)]
    }
}
```

### Refactoring our caption view into a scroll view

Below, we can implement the same view as before, but inside of a scroll view.

```swift
private func addSubviews() {
    addSubview(scrollView)
    scrollView.addSubview(contentView)
    contentView.addSubview(captionLabel)
    contentView.addSubview(textField)
    contentView.addSubview(submitButton)
    contentView.addSubview(imageView)
}
```

```swift
private func configureConstraints() {
    configureScrollView()
    configureContentView()
    configureCaptionLabel()
    configureTextField()
    configureSubmitButton()
    configureImageView()
}
```

```swift
private func configureScrollView() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor).isActive = true
    scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor).isActive = true
    scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor).isActive = true
}
    
private func configureContentView() {
    contentView.translatesAutoresizingMaskIntoConstraints = false
    contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
    contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
    contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    
    //Needed because the constraints of the views inside our content view don't define its size.  If they did, we could remove these two lines
    contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
}

    
private func configureCaptionLabel() {
    captionLabel.translatesAutoresizingMaskIntoConstraints = false
    captionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
    captionLabel.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
}
private func configureTextField() {
    textField.translatesAutoresizingMaskIntoConstraints = false
    textField.bottomAnchor.constraint(equalTo: submitButton.topAnchor, constant: -20).isActive = true
    textField.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
}
private func configureSubmitButton() {
    submitButton.translatesAutoresizingMaskIntoConstraints = false
    buttonBottomConstraint = submitButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
    buttonBottomConstraint.isActive = true
    submitButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
}
private func configureImageView() {
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    imageView.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -100).isActive = true
    imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3).isActive = true
    imageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3).isActive = true
}
```

### Scrolling to the right place

```swift
public func moveViewsToAccomadateKeyboard(with keyboardRect: CGRect, and duration: Double) {
    guard keyboardRect != CGRect.zero else {
        scrollView.contentInset = UIEdgeInsets.zero
        scrollView.scrollIndicatorInsets = UIEdgeInsets.zero
        return
    }
    
    let hiddenAreaRect = keyboardRect.intersection(scrollView.bounds)
    let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: hiddenAreaRect.height, right: 0.0)
    scrollView.contentInset = contentInsets
    scrollView.scrollIndicatorInsets = contentInsets

    var buttonRect = submitButton.frame
    buttonRect = scrollView.convert(buttonRect, from: submitButton.superview)
    buttonRect = buttonRect.insetBy(dx: 0.0, dy: -20)
    scrollView.scrollRectToVisible(buttonRect, animated: true)
}
```

# 3. Gestures

Adding gestures is a powerful way to give more input options to the user.  The types of [gestures](https://developer.apple.com/documentation/uikit/uigesturerecognizer) available on iOS are:

- Tap
- Pinch
- Rotation
- Swipe
- Pan
- Long Press

To add gesture functionality to an app, we will need to create a subclass of UIGestureRecognizer.  


### Tap

```swift
lazy var tapRecognizer: UITapGestureRecognizer = {
    let tr = UITapGestureRecognizer(target: self, action: #selector(respondToTap))
    tr.numberOfTapsRequired = 1
    tr.numberOfTouchesRequired = 1
    return tr
}()
```

Then, we will need to create something to handle a tap

```swift
@objc func respondToTap() {
    print("tapping")
}
```

And finally, add this tapRecognizer to our View Controller

```swift
override func viewDidLoad() {
	super.viewDidLoad()
	view.addGestureRecognizer(tapRecognizer)
}
```

### Swipe

Swipe gesture recognizers can only recognize swiping in one direction.  To handle other directions, create other swipe gesture recognizers.

```swift
lazy var downSwipeRecognizer: UISwipeGestureRecognizer = {
    let sr = UISwipeGestureRecognizer(target: self, action: #selector(respondToSwipe))
    sr.direction = UISwipeGestureRecognizerDirection.down
    return sr
}()
```

### Pinch

```swift
lazy var pinchRecognizer: UIPinchGestureRecognizer = {
    let pr = UIPinchGestureRecognizer(target: self, action: #selector(respondToPinch))
    return pr
}()
```


### Rotation

```swift
lazy var rotationRecognizer: UIRotationGestureRecognizer = {
    let rr = UIRotationGestureRecognizer(target: self, action: #selector(respondToRotation))
    return rr
}()
```

### Pan

```swift
lazy var panRecognizer: UIPanGestureRecognizer = {
    let pr = UIPanGestureRecognizer(target: self, action: #selector(respondToPan))
    return pr
}()
```

### Long Press

```swift
lazy var longPressRecognizer: UILongPressGestureRecognizer = {
   let lpr = UILongPressGestureRecognizer()
    lpr.minimumPressDuration = 1.0
    lpr.numberOfTouchesRequired = 1
    lpr.numberOfTapsRequired = 1
    return lpr
}()
```

## Reading

[Managing the keyboard](https://developer.apple.com/library/archive/documentation/StringsTextFonts/Conceptual/TextAndWebiPhoneOS/KeyboardManagement/KeyboardManagement.html)  

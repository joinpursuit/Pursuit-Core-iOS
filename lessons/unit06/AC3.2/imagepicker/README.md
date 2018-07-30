# Standards:
* ```UIImagePickerController```

# Objectives
* Students will be able to integrate ```UIImagePickerController``` into an app.
* Students will be introduced to how to scan, read and port Objective-C code.

We're going to walk and chew bubblegum this time, learning about the ```UIImagePickerController``` from 
[sample code from Apple](https://developer.apple.com/library/content/samplecode/PhotoPicker/Introduction/Intro.html).
The problem is that the best (or as far as I can tell, only) sample code from them is written in Objective-C,
so we'll have to get the information we need from the Objective-C project as we implement it in Swift.

# Resources

## Objective-C
* [Objective C Cheatsheet](https://github.com/iwasrobbed/Objective-C-CheatSheet)
	> Hardly a cheatsheet. More like a quick reference.

* [Another non-cheatsheet](http://www.dummies.com/software/objective-c-for-dummies-cheat-sheet/)
	> I hate the dummies brand but I like this bit about objects and messages:
	>
	> Object-oriented programming languages enable you to declare classes, create derived classes 
	> (subclass), and send messages to the objects instantiated from a class. This is the essence 
	> of object-oriented programming and part of the object-oriented extensions that Objective-C adds to C. 

* [An actual cheatsheet from good ol' RW](https://www.raywenderlich.com/downloads/RW-Objective-C-Cheatsheet-v-1-5.pdf)
	> Old, but solid, just like Objective-C

* http://fuckingblocksyntax.com/
	> A classic

## ```UIImagePickerController```
* [UIImagePickerController - Apple](https://developer.apple.com/reference/uikit/uiimagepickercontroller)
* [Sample Project - Apple](https://developer.apple.com/library/content/samplecode/PhotoPicker/Introduction/Intro.html)
* [Another Sample in Objective-C](http://www.appcoda.com/ios-programming-camera-iphone-app/)

# Lesson

## Why?

The purpose of using ```UIImagePickerController``` is self evident. You might want to access the user's camera
or pictures. It is Apple's _high-level_ interface, i.e. easiest to use, and so comes with limitations. You get the familiar Photo Library picker in portrait mode only. The camera can be customized with an overlay.

We're looking at Objective-C because exposure to the language will help read example and legacy code. It has
some value in interviews to be confident in navigating and interpreting Objective-C.

## Objective-C
 
> Disclaimer: This section is not meant to be a comprehensive summary of the language. That
> would be very poorly reinventing the wheel. Instead, it's a collection of observations and
> mappings between Objective-C's and Swift's syntax and patterns.

### Strings

Objective-C's NSString literals begin with @:

```objc
NSString *happiness = @"I am a happy string";
```

```@``` in general "objectifies" things:

```objc
// array literals start with @
NSArray *buds = @[@"Paul", @"Bernie", @"Gladys"];

// as do dictionary literals
// note the curly braces
// note also how integers have to be "objectified" to NSNumbers with @
NSDictionary *dict = @{@"one" : @1, @"two" : @2, @"five" : @5};
```

### Return types

```objc
- (void)someMethod {
	
}
[someObj someMethod]

- (void)someMethod {
	
}
```

```swift
// we let Void be implied
func someMethod() {
	
}

// but could do this
func someMethod() -> Void {
	
}
```

### Messages

Method calls on objects are referred to as _messages_. In the example below
self.capturedImages is a mutable array object that we send the message ```removeAllObject``` to.

```objc
    [self.capturedImages removeAllObjects];
//           ^- object       ^- method
//                               or message
```

This syntax explains (somewhat) why the methods that have no parameters have no function
operator ```()```. If a method takes exactly one argument, we just tack it on:


```objc
    [alertController addAction:ok];
//     ^--- object   ^- method  ^- argument
//                       or message


    [self presentViewController:alertController animated:YES completion:nil];
//    ^---object  ^-- message       ^-- 1st arg           ^-2nd arg      ^- 3rd arg
```

And so you see where the whole default first arugment thing in Swift 2.x came from and then the 
option to continue doing that with ```_``` in Swift 3.

### Class methods

```objc
+ (void)someFunction

[SomeClass someFunction];
```

### Private

Privacy isn't enforced but is suggested by the absence of the method in the
interface section of the header or  ```.h``` file.

Bar button item without adding toolbar (why?)
Simulated Metrics (shows bottom bar)

### Constants and Enums

Sometimes within the sprawling SDKs predefined parameter values are defined as constants 
and sometimes as enums. Since Objective-C has enums and they were sometimes employed
I'm not entirely sure if there is a 1:1 relationship between where a constant was
used in Objective-C and where one or an enum might be found in Swift. Just be prepared
to search for both.

```swift
// this takes an enum
 if UIImagePickerController.isSourceTypeAvailable(.camera) {

// this one takes a constant (not an enum)
let authStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
```

### Initializers

```objc
UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
```

```swift
let imagePickerController = UIImagePickerController()
```

### Class methods sometimes become initializers

```objc
UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
```

```swift
let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
```

```objc
    - (void)showImagePickerForSourceType:(UIImagePickerControllerSourceType)sourceType fromButton:(UIBarButtonItem *)button
```
    
```swift
    func showImagePickerForSource(_ sourceType: UIImagePickerControllerSourceType, fromButton button: UIBarButtonItem) {
        
    }
```

### Mutability

```objc
@property (nonatomic) NSMutableArray *capturedImages;
```

```
var capturedImages: [UIImage]!
```

## ```UIImagePickerController```

From [Apple](https://developer.apple.com/reference/uikit/uiimagepickercontroller)

> The UIImagePickerController class manages customizable, system-supplied user interfaces for taking 
> pictures and movies on supported devices, and for choosing saved images and movies for use in 
> your app. An image picker controller manages user interactions and delivers the results of those 
> interactions to a delegate object.

### Overlay View

Overlay view is the only customization feature available in the UIImagePickerController. If set,
you can define a custom view to overlay during camera operation. You probably want to turn off
the built in camera controls in this case. This is done by setting ```showsCameraControls```.


### ```showsCameraControls```

> var showsCameraControls: Bool { get set }

> Description	
> Indicates whether the image picker displays the default camera controls.
The default value of this property is true, which specifies that the default camera controls are visible in the picker. Set it to false to hide the default controls if you want to instead provide a custom overlay view using the cameraOverlayView property.

> Note
>In iOS 3.1.3 and earlier, hiding the default camera controls limits you to taking still pictures only, regardless of whether movie capture is available on the device.
>
> If you set this property to false and provide your own custom controls, you can take multiple pictures before dismissing the image picker interface. However, if you set this property to true, your delegate must dismiss the image picker interface after the user takes one picture or cancels the operation.
>
> You can access this property only when the source type of the image picker is set to camera. Attempting to access this property for other source types results in the throwing of an invalidArgumentException exception. Depending on the value you assign to the mediaTypes property, the default controls display the still camera or movie camera interface, or a selection control that lets the user choose the picker interface.

### Info.plist keys

As we've seen with other privacy settings like accessing the user's location, we also need to 
ask permission to access the camera or the photo library.

```xml
	<key>NSCameraUsageDescription</key>
	<string>to take photos and video</string>
	<key>NSPhotoLibraryUsageDescription</key>
	<string>to save photos and videos</string>
```

## Exercises

1. Use constraints instead of frame to size and position the overlay view.
1. Handle rotation better for the camera.
1. Work without the overlay. Ideally you would factor out the overlay so you can easily switch between
both versions. There are limitations to the non-custom overlay version you'll need to account for.
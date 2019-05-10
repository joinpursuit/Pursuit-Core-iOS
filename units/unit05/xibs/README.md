# Xib-Demo
Create a XIB file for use as a subview for a view controller. 


## 1. Create a new View file 

Navigate to File -> New. Choose **View** below User Interface. 

Name the file **LoginView**  

This will create a .xib file 

## 2. Add UI Elements as needed to the Xib in Storyboard

Login View UI Elements 
- UITextField (for user's email) 
- UITextField (for user's password) 
- UIButton (for login) 
- UILabel (account status message) 

Set the constraints base on your design. 

## 3. Create a UIView subclass to manage the .xib View 

Navigate to File -> New. Choose **Cocoa Touch Class** below the Source header.

Subclass will be a UIView. 

Name the file LoginView (conventionally you want to name the .xib and UIView file names the same)

## 4. Connect the .xib outlets to the LoginView.swift file

Navigate to your .xib file. 

Click on the File Owner, navigate to the **Identity Inspector** change the class name from NSObject to your newly created **LoginView**   

Open the Assistant Editor to enable you to see both the .xib view in Canvas and the LoginView.swift file. 

Control-Drag the following outlets: 
- UIView (this is the main view, name it contentView) 
- UITextField (name it emailTextField) 
- UITextField (name it passwordTextField) 
- UIButton (name it loginButton) 
- UILabel (name it accountMessageLabel) 

Implement the init(frame) and init(coder) initializers. 

Create a commonInit() helper method that bridges both initializers. Reminder: if coming from storyboard or nib file the init(coder) will get called. If coming from programmatic ui code, init(frame) will get called. Here we are taking care of both cases. 

![xib file](https://github.com/alexpaul/Xib-Demo/blob/master/Images/xib-file.png)     

## 5. Completed LoginView.swift file 

```swift 
class LoginView: UIView {
  
  
  @IBOutlet var contentView: UIView!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var accountMessageLabel: UILabel!
  
  override init(frame: CGRect) {
    super.init(frame: UIScreen.main.bounds)
    commonInit()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    commonInit()
  }
  
  private func commonInit() {
    // load the nib file
    Bundle.main.loadNibNamed("LoginView", owner: self, options: nil)
    addSubview(contentView)
    contentView.frame = bounds
    contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  }
}
```

## 6. Let's now make use of our .xib file in the view controller 

Navigate to the Main.storyboard 

Change the ViewController scene's main view from UIView to LoginView in the **Identity Inspector**   

## 7. Run the application 

You should now see the Login View as designed in the .xib file. 

Constructing a View this way makes it very flexible to be reused in a different project or view controller as needed. Especially with Login View's as they are resused so much more. 

<p align="center">
  <img src="https://github.com/alexpaul/Xib-Demo/blob/master/Images/xib-demo.png" width="314" height="636" />
</p> 

## Readings 

[Stackoverflow - What is the difference between NIB and XIB](https://stackoverflow.com/questions/3726400/what-is-the-difference-between-nib-and-xib-interface-builder-file-formats)   
[Nib file - Apple Documentation](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/NibFile.html)      


## [Completed Xib Demo Project](https://github.com/alexpaul/Xib-Demo)   

# Delegation through Textfields

### Readings

1. [`UITextField` - Apple Doc Ref ](https://developer.apple.com/reference/uikit/uitextfield)
2. [`UITextFieldDelegate` - Apple Doc Ref ](https://developer.apple.com/reference/uikit/uitextfielddelegate)
3. [Adding Connections from UI Elements in Storyboard (Action) - Xcode Doc](http://help.apple.com/xcode/mac/8.0/#/dev9662c7670)
4. [Managing/Checking Outlet Connections - Xcode doc](http://help.apple.com/xcode/mac/8.0/#/devc0cdc8c7a)
5. [String Manipulation Cheat Sheet - Use Your Loaf](http://useyourloaf.com/blog/swift-string-cheat-sheet/)
6. [Complete List of Unicode Categories - File Format](http://www.fileformat.info/info/unicode/category/index.htm)

#### Further Reading

1. [How Delegation Works - Andrew Bancroft](https://www.andrewcbancroft.com/2015/04/08/how-delegation-works-a-swift-developer-guide/)

---
### Vocabulary

1. **Delegate**: ... pattern in which one object in a program acts on behalf of, or in coordination with, another object. The delegating object keeps a reference to the other object—the delegate—and at the appropriate time sends a message to it. The message informs the delegate of an event that the delegating object is about to handle or has just handled. [Apple](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/Delegation.html)
2. **Refactoring**: ... the process of restructuring existing computer code ... without changing its external behavior... Advantages include improved code readability and reduced complexity. [Wiki](https://en.wikipedia.org/wiki/Code_refactoring)
3. **(Data) Validation**: ...the process of ensuring that a program operates on clean, correct and useful data. It uses routines, often called "validation rules", "validation constraints" or "check routines", that check for correctness, meaningfulness, and security of data that are input to the system. [Wiki](https://en.wikipedia.org/wiki/Data_validation)

---
# 0. Objectives

1. Begin to understand the protocols and the delegate design pattern in programming
2. Practice handling delegation using `UITextField` and `UITextFieldDelegate`
3. Explore `String` through textfield validations




# 1. Delegation Refresher

The delegation design patter is used to assign someone else (a delegate) to handle certain activities.

[Example below is adapted from Bob the Developer](https://blog.bobthedeveloper.io/the-meaning-of-delegate-in-swift-347eaa9674d)

```swift 
protocol Cook {
 func makingFood() 
}

struct Mom: Cook { 
 func makingFood() { 
 	print("Pizza coming soon!") 
 } 
}

var mom = Mom()
mom.makingFood() // "Pizza coming soon!"

struct Child {
 var delegate: Cook? // delegate = someone with special skills
}

var junior = Child()
junior.delegate = mom

```

# 2. Why TextFieds? A new way of getting user input

So far, we've only been able to have the user give input by tapping on a button.  That interaction alone was pretty powerful through, we built a number of projects just from that IBAction.  However, sometimes we need to get more dynamic input.  A common feature that we see in apps is a text field.

![text](https://static1.squarespace.com/static/55062028e4b0953c7cbdc224/t/559542e9e4b0f2c26b1c48ae/1435845354811/)


Common uses are setting up profiles, sending messages and searching for content.  Most every app has this component and it enables you to get very dynamic, targeted input.


Let's take a brief look about the class in Swift.

# 3. UITextField properties

UITextField inherits from *UIControl* just like a UIButton.  That means that we can disable it if necessary.  It also inherits from UIView, which means it has a `tag`, `isHidden` and `backgroundColor`

It also has some unique properties of its own.

From the [documentation](https://developer.apple.com/documentation/uikit/uitextfield)

## Text Field properties

|Attribute |Description|
|---|---|
|Text | The initial text displayed by the text field. You can specify the text as a plain string or as an attributed string. If you specify an attributed string, Interface Builder provides different options for editing the font, color, and formatting of the string. |
|Color|The color of the text field’s text. To set this attribute programmatically, use the textColor property.|
|Font|The font of the text field’s text. To set this attribute programmatically, use the font property.|
|Alignment|The alignment of the text field’s text inside the editing area. This option is available only when formatting plain strings. To set this attribute programmatically, use the textAlignment property.
|Placeholder|The placeholder text displayed by the text field. When the text field’s string is empty, the text field displays this string instead, formatting the string so as to indicate that it is not the actual text. Typing any text into the text field hides this string. To set this attribute programmatically, use the placeholder property.
|Background|The background image to display when the text field is enabled. This image is displayed behind the rest of the text field’s content. To set this attribute programmatically, use the background property.
|Disabled|The background image to display when the text field is disabled. This image is displayed behind the rest of the text field’s content. To set this attribute programmatically, use the disabledBackground property.
|Border Style|The visual style for the text field’s border. This attribute defines the visual border, if any, drawn around the editable text region. To set this attribute programatically, use the borderStyle property.
|Clear Button|The behavior of the clear button. The clear button is a built-in overlay view that the user taps to delete all of the text in a text field. Use this attribute to define when the clear button appears. To set this attribute programatically, use theclearButtonMode property.
|Min Font Size|The minimum font size for the text field’s text. When the Adjust to Fit option is enabled, the text field automatically varies the font size to ensure maximum legibility of the text. You can use this attribute to specify the smallest font size that your consider appropriate for your text. To set this attribute programatically, use theminimumFontSize property.


We can manipulate those properties using the *attributes inspector* in Interface Builder.  Selecting a TextField will bring up a keyboard.  We are also able to manipulate the settings for the keybaord.

## Text Input properties

|Attribute|Description|
|---|---|
|Capitalization|The automatic capitalization style to apply to typed text. This attribute determines at what time the Shift key is automatically pressed. You can access the value of this attribute programmatically using the text field’s autocapitalizationType property.
|Correction|The autocorrection behavior of the text field. This attribute determines whether autocorrection is enabled or disabled during typing. You can access the value of this attribute programmatically using the text field’s autocorrectionType property.
|Spell Checking|The spell checking behavior of the text field. This attribute determines whether spell checking is enabled or disabled during typing. You can access the value of this attribute programmatically using the text field’s spellCheckingType property.
|Keyboard Type|The style of the text field’s keyboard. This property specifies the type of keyboard displayed when the text field is active. You can access the value of this attribute programmatically using the text field’s keyboardType property.
|Appearance|The visual style applied to the text field’s keyboard. Use this property to specify a dark or light keyboard. You can access the value of this attribute programmatically using the text field’s keyboardAppearance property.
|Return Key|The type of return key to display on the keyboard. Use this property to configure the text and visual style applied to the keyboard’s return key. You can access the value of this attribute programmatically using the text field’s returnKeyType property. The return key is disabled by default and becomes enabled only when the user types some text into the text field. To respond to taps in the Return key, implement the textFieldShouldReturn(_:) method in the delegate you assign to the text field.


When using the simulator, by default you can type with the keyboard on your Mac.  In order to see what you app will look like when using a phone:

Disable your keyboard for simulator with

- Hardware -> Keyboard -> Uncheck "Connect Hardware Keyboard"
- Or Command-Shift-K

# 4. Reading data from a TextField

Let's test out a TextField with a simple app.  Let's build a guessing game. 

### Step one: View (Configure your storyboard)

You will need:

- One label at the top as a welcome message / instructions
- One text field for the user to enter their guess
- One button for them to actually guess
- One label that displays the result of their guess

### Step two: Controller

- Create outlets to your TextField and the label that displays a message
- Create an IBAction for your Button
- Create a property "model" of type GuessingGameModel

### Step three: Model

- Make a new file GuessingGameModel.swift 
- Define an enum that represents what we would want to know when the user guesses a number
- Define a class GuessingGameModel with a private let winningNum: Int
- Build an initializer that takes no parameters and assigns winningNum to a random Int
- Define a method that takes a guess as input, and returns something of the type of enum that you defined above

### Step four: Complete your controller

- Complete the method inside your IBAction to change the message depending on the users input.

Great, we used a TextField!  It didn't feel like a super seamless experience though.  What are things we would want to do to improve it?

<details>
<summary>Solution</summary>

- Have the return button do something
- Delete the button
- Not let us guess a number we have guessed before
- Not let the user try to guess invalid things
- Make the keyboard only have numbers
- Get rid of the keyboard when you make a guess

</details>

We can fix one of those right now.  Let's change the keyboard type to numbers and punctuation.  To fix the other problems, we'll need to take a look at *delegate methods*

# 5. UITextFieldDelegate

When we interact with a TextField, [a variety of things happen](https://developer.apple.com/documentation/uikit/uitextfielddelegate):

1. It gets instructions that it's about to be activated.  This is called becoming the `first responder`
2. The text field becomes the `first responder` and presents the keyboard
3. We start editing the TextField
4. We change characters in the TextField
5. We stop editing the TextField
6. The TextField resigns its `first responder` and dismisses the keyboard

Instead of just reacting when the user presses a button, we are able to step in at each step in the process outlined above.  By stepping in we will be able to do things like:

- Inserting text while the user is typing
- Responding to the user pressing "Return"
- Prevent the user from entering certian characters
- Dismiss the keyboard

And whatever else we think of that lives in between those steps.

In order to get access to these properties, we need to use the *delegate design pattern*.

Our text field doesn't know on its own what should happen at each of these steps.  What should it do when we start editing?  Or change characters?  Or return?  It doesn't make sense for the TextField to own that information, because it might need to manipulate other Views.  So it needs to send that information to something that does know what to do with it.  This is our ViewController.

Here's how we'll set it up:

```swift
class ViewController: UIViewController, UITextFieldDelegate {
	var textField: UITextField!
	override func viewDidLoad() {
		super.viewDidLoad()
		self.textField.delegate = self
	}
}
```

Note that the ViewController conforms to UITextFieldDelegate.  This means that the delegate of the textField can be an instance of this ViewController.

But what does it mean to conform to UITextFieldDelegate?  We didn't implement any special properties or methods.

<details>
<summary>Why don't we need to implement any methods?</summary>

All the delegate methods are @objc optional methods

</details>


In order to see which methods we have access to, we can start typing in textField into our ViewController and see what options we have.  Here's what comes up:

- textFieldShouldBeginEditing
- textFieldDidBeginEditing
- textField(_:shouldChangeCharactersIn:replacementString:)
- textFieldShouldClear*
- textFieldShouldReturn
- textFieldShouldEndEditing
- textFieldDidEndEditing

This is the order that your text field informs its delegate about what it is doing.  

**Exercise**: Implement each of these delegate methods by printing to the console a message about what method was just called.  Then, run your app and start editing the text field to observe the different messages and when they appear.


# 6. Delegate Methods - return

Let's focus in on the textFieldShouldReturn method.  This delegate method is called whenever the user taps the *return* key.  This method returns a Bool which is whether or not we should return and proceed down to the textFieldShouldEndEditing and textFieldDidEndEditing methods. 

We want to get rid of the button in our guessing game app and just use a textField instead.  We can also user the resignFirstResponder() method to make the keyboard go away.

**Exercise**: Refactor your code to delete the button, and put the logic there into textFieldShouldReturn.


**Exercise**: Let's add another feature: don't allow the user to guess a number that they have guessed already.


**Exercise**: Add handling to make sure the user only enters a number.  Provide a warning label if they try to enter an invalid input.


# 7. Delegate Methods - editing

We can also control what the user is able to type in at all.

textField(_:shouldChangeCharactersIn:replacementString:)

Inside this method you have access to:

- range: NSRange
- string: String

An NSRange is an Objective-C range.  It has an upperBound and lowerBound both of type Int.  Use those properties to see what the user is trying to edit.

The `string` is the String the user is trying to insert.  If the user is deleting text, this will show up as the empty String.

**Exercise**: Add functionality that prevents the user from entering any non-numeric characters. 


# 8. Setting up delegates through Interface Builder

Instead of writing the code in viewDidLoad, you can control-drag from your textField to the ViewController in Interface Builder.  It's easy to forget you've done it, so make sure to check the Connections inspector.  I recommend using the method we used above for additional clarity.


# 9. Delegation for multiple TextFields

Similar to creating a single IBAction for multiple buttons, we can set our ViewController as the delegate for multiple TextFields.  Inside the body of our delegate methods, we'll need to check to see which TextField it is.  Let's add a field for the user to enter their name.

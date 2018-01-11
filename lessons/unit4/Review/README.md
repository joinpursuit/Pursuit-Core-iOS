# Unit 4 Review

Unit 4 Topics:

# 1. Persistence

[Persistence Project](https://github.com/C4Q/AC-iOS-PersistenceReview)

### UserDefaults

A dictionary stored on your phone.  Accessed at startup, and if it is too big, your app will take longer to launch.  Best used for storing small pieces of information (zip codes, preferences, names etc.)

### FileManager

Save files (typically .plist and .png) directly to your phone.  Best used for persisting custom object arrays or images.

### NSCache

A dictionary for storing big values that automatically deletes pairs when it starts taking up too much memory.  Best used for storing large objects (like Images) so that you don't need to make an API call to get the data again.  Does not persist between launches. 

### URLCache

A dictionary that maps URLRequest to URLResponse.  Best used for storing API calls to avoid requesting the same information twice.  May persist between launches.  

# 2. Collection Views

[Collection View Project](https://github.com/C4Q/AC-iOS-CollectionViews-Introduction)

A collection view a way of presenting several pieces of information.  Much like a table view, a collection view needs a data source to be populated.  Collection views are more flexible than table views because they allow for horizontal scrolling, and for multiple elements per row and column.  The most common way of setting up a collection view is by using the UICollectionViewDelegateFlowLayout which sets up a grid of cells.

# 3. Nibs / Xibs

[Nib Project](https://github.com/C4Q/AC-iOS-NibDemo)

A Xib file is a way of creating a reusable mini-storyboard for either a custom view or custom CollectionView/TableView Cell.  By separating out your Xib file, you can avoid having to recreate the same constraints multiple times in your main.storyboard file.

### Xib for Custom Cells

1. Create an Empty User Interface
2. Drag in a table view cell into the .xib file
3. Configure the table view cell
4. Create a .swift file and drag in your outlets

### Xib for Custom Views

1. Create a new Xib File
2. Customize your view
3. Create a .swift file to link to your .xib file
4. Create outlets from your .xib file to your .swift file.
5. Set the initializer in your .swift file to load the Nib

# 4. Custom Delegation

Sometimes, we want a view to talk back to its view controller.  In order to facilitate these kinds of communications, we can use custom delegation.  

1. Define a protocol that requires implementing a method. 
2. Give the view a delegate that conforms to your protocol.
3. Have your view controller conform to your custom protocol
4. Have your view controller assign itself to be the delegate of its subview

```swift
protocol MyCustomViewDelegate {
    func buttonWasPressed()
}

class MyCustomView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(myButton)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Init with coder not implemented")
    }
    
    var delegate: MyCustomViewDelegate?
    
    lazy var myButton: UIButton = {
        let button = UIButton(frame: CGRect(origin: self.bounds.origin, size: CGSize(width: 100, height: 100)))
        button.setTitle("Press me!", for: .normal)
        button.addTarget(self, action: #selector(handleButtonPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func handleButtonPressed() {
        delegate?.buttonWasPressed()
    }
}


class MyViewController: UIViewController, MyCustomViewDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(customView)
    }
    
    lazy var customView: MyCustomView = {
        return MyCustomView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height / 2))
    }()
    
    func buttonWasPressed() {
        print("My custom subview had a button press action")
    }
    
}
```


# 5. Programmatic View Management 

All the rules for Auto Layout hold true for programmatic views.

2 important things to remember

1. You must set each constraint's `isActive` to true
2. You must set the view's `translatesAutoResizingMaskIntoConstraints` to false

To configure views programmatically:

1. Create a lazy var that returns an instance of the subview
2. Add that subview to your main view in viewDidLoad
3. Configure your Auto Layout constraints

# 6. Animations

### UIView.animate

```swift
UIView.animate(withDuration: 5.0, 
				  animations: { view.backgroundColor = .green }, 
				  completion: { print("done") }
				  )
```

For constraints

```swift
//Rebuild constraints as needed
UIView.animate(withDuration: 5.0, 
				  animations: { view.layoutIfNeeded() }, 
				  completion: { print("done") }
				  )
```


### UIViewPropertyAnimator

```swift
let myAnimator = UIViewPropertyAnimator(duration: 5.0, curve: .easeInOut){
	view.backgroundColor = .green
}
myAnimator.startAnimation()

```

### Core Animation

[Core Animation Project](https://github.com/C4Q/AC-iOS-CoreAnimationApp)
# Custom Cells and Programmatic UI

## Resources

1. [Brian Clouser XIB walkthrough](https://medium.com/@brianclouser/swift-3-creating-a-custom-view-from-a-XIB-ecdfe5b3a960)
2. [Apple Docs](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/LoadingResources/CocoaNibs/CocoaNibs.html)

## Objectives

1. Understand the difference between frame and bounds
2. Subclass a UIView
2. Create XIB files and instantiate them using Storyboard
3. Use XIB files in multiple Table Views / Collection Views
4. Create cells with no XIB or Storyboard

# 1. Programmatic UI Topics

## Frame vs Bounds

The [frame](https://developer.apple.com/documentation/uikit/uiview/1622621-frame) of an UIView is the rectangle, expressed as a location (x,y) and size (width,height) relative to the superview it is contained within.

The [bounds](https://developer.apple.com/documentation/uikit/uiview/1622580-bounds) of an UIView is the rectangle, expressed as a location (x,y) and size (width,height) relative to its own coordinate system (0,0).

[What's the difference between the frame and the bounds?](https://stackoverflow.com/questions/1210047/cocoa-whats-the-difference-between-the-frame-and-the-bounds)  

```swift
private func setupSquare() {
    // frame base layout
    let length: CGFloat = UIScreen.main.bounds.width / 2
    square = UIView(frame: CGRect(x: 0, y: 80, width: length, height: length))
    square.backgroundColor = .blue
    addSubview(square)
}
```

<p align="center">
<img src="https://raw.githubusercontent.com/joinpursuit/Pursuit-Core-iOS/5_3/units/unit04/lesson-12-programmatic-view-management/Images/frame-vs-bounds.png" width="414" height="736" />
</p>

## Subclassing UIViews

A `UIView` is a Swift class that can subclassed like any other object.  By subclassing `UIView`, you can create content that is easily reusable in different places in your application.  If you are building an app that frequently makes use of a specific Table View and cell, you could use the code below to wrap those together.  You can also add other subviews and customize the constraints inside the view.

```swift
class MainView: UIView {
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.frame = bounds // bounds here is the MainView's bounds which is UIScreen.main.bounds (entire screen)
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "NameCell")
        return tv
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        setupViews()
    }

    private func setupViews() {
        addSubview(tableView)
    }
}
```


# 2. Custom Cells with XIB files

## XIB file

XIB stands for "XML Interface Builder".  XML is what powers Interface Builder to do all its magic of hooking up segues, actions and outlets.  XIB files used to be called nib files (NeXT interface builder).  Before iOS 5, there were no Storyboards.  Every view controller would be made in a separate file, and you would indicate the transitions between them using programmatic segues.  Storyboards made it possible for a single file to hold all your Views and View Controllers as well as add the functionality for showing transitions (segues) graphically.

Storyboard solves the issue of having to create XIB files ourselves in the majority of cases.  Occasionally, we may want to use the same *view* in multiple different View Controllers.  Instead of redoing all the work of making our custom view again, we can make a XIB file that lays out our custom view and then drag it in to whatever view controllers we want.

## XIB files for custom cells

We can use XIB files to create reusable, isolated files to create the UI for Table View and Collection View cells.  This way, you can edit it without worrying about merge conflicts, and reuse the same cell in multiple different Controllers.

To create a cell with an associated XIB file:


1. Click file -> new file
2. Select "Cocoa Touch Class"
3. Create a "Subclass of:" `UICollectionViewCell` or `UITableViewCell`
4. Click on the box "Also create XIB file"
5. Click next

You can now drag in subviews and create outlets just like when your cell was inside the Table View or Collection View.

### Configure the View Controller

You Table View or Collection View doesn't know which cell belongs to it, because it was created in a separate file.  We need to `register` the cell to the view.  We can even register multiple different cells and choose which one we want to dequeue.

```swift
let nib = UINib(nibName: "MyCustomCell", bundle: nil)
self.tableView.register(nib, forCellReuseIdentifier: "myReuseID")
```


# 3. Custom Cells Programmatically


We can combine subclassing `UIViews` and registering cells to Table Views to create a fully programmatic Table View:

`SceneDelegate.swift`
```swift
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = ColorsViewController()
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
```

`ColorsViewController.swift`
```swift
import UIKit

class ColorsViewController: UIViewController {

    let colors: [UIColor] = [.red, .orange, .yellow, .green, .blue, .systemIndigo, .purple]

    lazy var colorsTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ColorTableViewCell.self, forCellReuseIdentifier: "colorCell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureConstraints()
    }

    func addSubviews() {
        view.addSubview(colorsTableView)
    }
    func configureConstraints() {
        colorsTableView.translatesAutoresizingMaskIntoConstraints = false
        colorsTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        colorsTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        colorsTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        colorsTableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
}

extension ColorsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension ColorsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath) as? ColorTableViewCell else {
            fatalError("Unknown Cell ID")
        }
        cell.configureSelf(with: colors[indexPath.row])
        return cell
    }
}
```

`ColorTableViewCell`
```swift
import UIKit

class ColorTableViewCell: UITableViewCell {

    lazy var colorLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(colorLabel)
        colorLabel.translatesAutoresizingMaskIntoConstraints = false
        colorLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        colorLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureSelf(with color: UIColor) {
        let rgb = color.cgColor.components!
        let rgbStrs = rgb.map { String(format: "%.1f", $0) }
        colorLabel.text = "(r: \(rgbStrs[0]), g: \(rgbStrs[1]), b: \(rgbStrs[2]))"
        backgroundColor = color
    }
}
```

# Standards

* Understand Views
* Understand Autolayout

# Objectives

Students will be able to:

* Create xib/nib files and populate custom views with them
* Re-use custom ```UITableViewCell``` subclasses in more than one table

# References

### Readings

1. [`Nib Guide` - Apple](https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/LoadingResources/CocoaNibs/CocoaNibs.html)
2. [`loadNibNamed(_:owner:options)` - Apple](https://developer.apple.com/reference/foundation/bundle/1618147-loadnibnamed)
3. [`NSBundle` - Apple](https://developer.apple.com/reference/foundation/nsbundle)

### Sacred Texts

* FOR IB: http://berzniz.com/post/32597579083/8-reasons-why-real-men-do-use-interface-builder
* PROS AND CONS: http://codewithchris.com/xcode-using-storyboards-and-xibs-versus-creating-views-programmatically/
* AGAINST IB: http://blog.teamtreehouse.com/why-i-dont-use-interface-builder

# Lesson

## Holy War

![Crusaders](http://www.medievalhistories.com/wp-content/uploads/medieval-crusaders.jpg)

There are a lot of opinions about the best way to lay out views which the subject 
of nibs is naturally dragged into. The argument is primarilty GUI vs. non-GUI but
there's subcurrents of Storyboards vs. nibs. Keep this in perspective when reading
about the topic in blogs and Stack Overflow.

## Why? Why deal with nibs

The motivation for using nibs, specifically, is ultimately to maximize reuse, a key software
engineering principle. Just as code can be factored into smaller pieces, usually via functions,
so that it can be used from more than one place, nibs are one tool for reusing a bit of 
view hierarchy. 

One thing Storyboards don't support is a Scene that's not a View Controller and this 
necessitates the individual nib file.

You may run into nibs for historical reasons. Some old code bases might predate storyboards.
In such a case it's common to find each View Controller in its own nib. 

Lastly, because entire View Controllers can be put in nibs some organizations might take 
advantage of this to facilitate team development, read: avoid Storyboard merges.

## Nib Guts

Nibs and specifically XIBs are XML documents. You never have to edit them directly except
in the case of nib or Storyboard merges in git. So it's good to have some familiarity
with how they're laid out. If you look closely you can find all of the information that's
exposed in IB.

```xml
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<document type="com.apple.InterfaceBuilder3.CocoaTouch.XIB" version="3.0" toolsVersion="11542" systemVersion="15G1108" targetRuntime="iOS.CocoaTouch" propertyAccessControl="none" useAutolayout="YES" useTraitCollections="YES" colorMatched="YES">
    <device id="retina4_7" orientation="portrait">
        <adaptation id="fullscreen"/>
    </device>
    <dependencies>
        <deployment identifier="iOS"/>
        <plugIn identifier="com.apple.InterfaceBuilder.IBCocoaTouchPlugin" version="11524"/>
        <capability name="Aspect ratio constraints" minToolsVersion="5.1"/>
        <capability name="Constraints to layout margins" minToolsVersion="6.0"/>
        <capability name="Constraints with non-1.0 multipliers" minToolsVersion="5.1"/>
        <capability name="documents saved in the Xcode 8 format" minToolsVersion="8.0"/>
    </dependencies>
    <objects>
        <placeholder placeholderIdentifier="IBFilesOwner" id="-1" userLabel="File's Owner"/>
        <placeholder placeholderIdentifier="IBFirstResponder" id="-2" customClass="UIResponder"/>
        <tableViewCell contentMode="scaleToFill" selectionStyle="default" indentationWidth="10" rowHeight="111" id="KGk-i7-Jjw" customClass="MyTableViewCell" customModule="Nibbage" customModuleProvider="target">
            <rect key="frame" x="0.0" y="0.0" width="320" height="111"/>
            <autoresizingMask key="autoresizingMask" flexibleMaxX="YES" flexibleMaxY="YES"/>
            <tableViewCellContentView key="contentView" opaque="NO" clipsSubviews="YES" multipleTouchEnabled="YES" contentMode="center" tableViewCell="KGk-i7-Jjw" id="H2p-sc-9uM">
                <rect key="frame" x="0.0" y="0.0" width="320" height="110.5"/>
                <autoresizingMask key="autoresizingMask"/>
                <subviews>
                    <view contentMode="scaleToFill" translatesAutoresizingMaskIntoConstraints="NO" id="JhC-76-l8H">
                        <rect key="frame" x="0.0" y="0.0" width="256" height="110.5"/>
                        <color key="backgroundColor" red="1" green="0.071597105699999997" blue="1" alpha="1" colorSpace="custom" customColorSpace="sRGB"/>
                    </view>
                    <label opaque="NO" userInteractionEnabled="NO" contentMode="left" horizontalHuggingPriority="251" verticalHuggingPriority="251" text="Label" textAlignment="natural" lineBreakMode="tailTruncation" baselineAdjustment="alignBaselines" adjustsFontSizeToFit="NO" translatesAutoresizingMaskIntoConstraints="NO" id="G3a-p1-jLE" userLabel="Symbol">
                        <rect key="frame" x="78.5" y="14" width="163.5" height="82.5"/>
                        <fontDescription key="fontDescription" type="system" pointSize="69"/>
                        <nil key="textColor"/>
                        <nil key="highlightedColor"/>
                    </label>
                    <view contentMode="scaleToFill" translatesAutoresizingMaskIntoConstraints="NO" id="dbq-lZ-Ja7" customClass="ToggleButton" customModule="Nibbage" customModuleProvider="target">
                        <rect key="frame" x="210" y="0.0" width="110" height="110"/>
                        <color key="backgroundColor" white="1" alpha="1" colorSpace="calibratedWhite"/>
                        <constraints>
                            <constraint firstAttribute="width" secondItem="dbq-lZ-Ja7" secondAttribute="height" multiplier="1:1" id="MG6-bY-kF0"/>
                        </constraints>
                    </view>
                </subviews>
                <constraints>
                    <constraint firstItem="JhC-76-l8H" firstAttribute="width" secondItem="H2p-sc-9uM" secondAttribute="width" multiplier="0.8" id="5Oh-sh-fuX"/>
                    <constraint firstAttribute="bottomMargin" secondItem="G3a-p1-jLE" secondAttribute="bottom" constant="6" id="7Bm-hu-luZ"/>
                    <constraint firstItem="JhC-76-l8H" firstAttribute="leading" secondItem="H2p-sc-9uM" secondAttribute="leading" id="9qC-zb-00x"/>
                    <constraint firstItem="G3a-p1-jLE" firstAttribute="centerX" secondItem="H2p-sc-9uM" secondAttribute="centerX" id="DLE-G4-1JQ"/>
                    <constraint firstItem="JhC-76-l8H" firstAttribute="top" secondItem="H2p-sc-9uM" secondAttribute="top" id="EbE-Uv-dfR"/>
                    <constraint firstItem="G3a-p1-jLE" firstAttribute="top" secondItem="H2p-sc-9uM" secondAttribute="topMargin" constant="6" id="U1G-Ev-72C"/>
                    <constraint firstAttribute="trailing" secondItem="dbq-lZ-Ja7" secondAttribute="trailing" id="guE-c9-1k8"/>
                    <constraint firstItem="G3a-p1-jLE" firstAttribute="centerX" secondItem="H2p-sc-9uM" secondAttribute="centerX" id="lON-lY-EMS"/>
                    <constraint firstAttribute="bottom" secondItem="dbq-lZ-Ja7" secondAttribute="bottom" id="leX-5B-WSf"/>
                    <constraint firstAttribute="bottom" secondItem="JhC-76-l8H" secondAttribute="bottom" id="pjP-On-4ih"/>
                    <constraint firstItem="dbq-lZ-Ja7" firstAttribute="top" secondItem="H2p-sc-9uM" secondAttribute="top" id="r7Q-Ug-90f"/>
                    <constraint firstItem="G3a-p1-jLE" firstAttribute="centerY" secondItem="JhC-76-l8H" secondAttribute="centerY" id="xPM-Qn-kD8"/>
                </constraints>
                <variation key="default">
                    <mask key="constraints">
                        <exclude reference="U1G-Ev-72C"/>
                    </mask>
                </variation>
            </tableViewCellContentView>
            <connections>
                <outlet property="symbolImage" destination="G3a-p1-jLE" id="hRF-rt-h2h"/>
                <outlet property="symbolLabel" destination="G3a-p1-jLE" id="tU4-Rf-pGb"/>
            </connections>
            <point key="canvasLocation" x="28" y="53.5"/>
        </tableViewCell>
    </objects>
</document>
```

### Quirks

> "Like, and yet unlike."
>
>   – Gimli, Glóin's son

 There are quirky differences between Storyboards and nibs. This is good to keep
 in mind for when something doesn't work in one when you know it does in the other.
 A non-exhaustive list includes:
 
 * You can't have prototype cells in a table view in a nib
 * You can't put a view outside a view controller in a storyboard
 * There's no way to draw a segue between nibs, though storyboard references allow a similar behavior between storyboards
 * While prototype cells communicate the height of their cells to their View Controller, there
    is no equivalent mechanism for cells defined in nibs.

## Applications and Use Cases 

### Table View Cell

A good use case to start with is the custom Table View cell. In Storyboards we're familiar
with laying out views within a prototype cell or more than one prototype cell, right in the
View Controller. 

What if we want to use the same cell in two Table Views? One approach is to copy the views
but copying and pasting should always raise a red flag. It's setting up a maintenance 
nightmare. Every change you make in one place will need to be repeated in another. Even
if you do want a view to behave slightly differently in one place than another it's worth
considering refactoring it and strategizing a way to programmatically adjust the view.

The solution: create a nib for the custom Table View Cell. 

There is a simple mechanism to associate the cell with the table, this 
```register(_:forCellReuseIdentifier)``` call.


```swift
tableView.register(UINib(nibName: "MyTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: identifier)
```

Now two tables can use the same cell. Through ```register there is a built in "hydration" system.
We'll see it's a little more work for any arbitrary view.


There is some fallout. The height of the Table View Cell is not automatically picked up by the 
Table View Controller. This means that you must do one of the following:

* Hard code the height of the cell either with tableView.rowHeight or the delegate method ```tableView(_:heightForRowAt:)```.
* Try some convoluted way to measure the cell dynamically. (I could not find a good one)
* Auto Layout to the rescue. Setting this in viewDidLoad
   
    ```swift
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 2
    ```
    and configuring constraints to allow for vertical autosizing lets Auto Layout do the work.
    Use this approach whenever possible.

### Non-segue-tur

Can't draw segues between nibs so didSelectRow comes back into play.

```swift
override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let vc = ViewController(nibName: "SomeOtherViewController", bundle: nil)
    self.navigationController?.pushViewController(vc, animated: true)
}
```

### Table View Cell Exercise

Using the Elements project, let's make a new Table View controller within a Tab Bar. 
That Table View Controller will do the same thing as the first, but it *could* do
something different. In order for them to share the same cell, it needs to go in a nib.

Steps:

1. Pull the solution branch from https://github.com/C4Q/AC3.2-MidtermElements. You'll
    need to add an upstream remote if you haven't already.

1. git checkout -b nibs to create a new branch.

1. Embed the existing navigation controller stack in a Tab Bar Controller. You can get rid 
    of the big ugly blue box by choosing any System Item.

1. Drag out a new Navigation/Table view controller.
1. Drag a relationship segue from the Tab Bar Controller to the new Navigation controller
1. Make a Swift class for the Table View Controller and hook up as usual.
1. Make a nib for the UITableViewCell
1. Get rid of the existing Table View's prototype cell.
1. Register the cell for the table view.
1. Setup the cell for Autolayout.
1. Do the same thing in the second table view controller. Make a small alteration to the 
    data (filter?) to help distinguish them.
1. Implement ```tableView(_:didSelectRowAt:)```

## Custom View

This use case is easy to imagine, there's some bit of UI you want to put in a number of places.

Simple and one-time-only approach to creating a view. 

```swift
override init(frame: CGRect) {
    super.init(frame: frame)
}

required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)

    if let view = Bundle.main.loadNibNamed("ToggleButton", owner: self, options: nil)?.first as? UIView {
        self.addSubview(view)
        view.frame = self.bounds
    }
}
```

A generalized solution from http://stackoverflow.com/questions/25513271/how-to-initialise-a-uiview-class-with-a-xib-file-in-swift-ios

```swift
class NibLoadingView: UIView {
    
    @IBOutlet weak var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        nibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        nibSetup()
    }
    
    private func nibSetup() {
        backgroundColor = .clear
        
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        
        addSubview(view)
    }
    
    private func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let nibView = nib.instantiate(withOwner: self, options: nil).first as! UIView
        return nibView
    }   
}
```

To use this:
* subclass NibLoadingView
* set the file owner of the of the xib to your class
* connect outlets to the file's owner (this is a little weird after Storyboards)

### Exercise

Build a custom view that displays the element cell. Use it both in the table view cell
and in the detail view. This will call for a custom view.

1. Create a new Cocoa Touch File with UIView as the parent
1. Create a new User Interface > View and give the xib the same name as the class.
1. 

## View Controllers

There aren't a lot of modern motives for putting a View Controller in its own nib but
it does exist in the wild.


## More Limitations

You can't embed subviews in a button in either a storyboard or a nib, but you can in code.
Whaa? In that case you're forced to create a UIButton subclass entirely programmatically.
You need to have a sense of what's possible, plausible and allowed by Apple. You
need the means and rigor to find out. This is an intangible skill that's mostly attitude.

![Map of 4th Crusade](http://www.newadvent.org/images/04543ccx.jpg)


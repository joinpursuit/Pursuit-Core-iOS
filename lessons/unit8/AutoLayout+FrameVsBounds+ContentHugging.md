# AutoLayout, Frame Vs Bounds, Content Hugging / Compression Resistance

### Past Lesson Links

- [AutoLayout](https://github.com/C4Q/AC-iOS/blob/7a2f6e717f55a6b8a83e027324dac148eefe0396/lessons/unit2/AutoLayout/README.md)
- [Unit 2 Review](https://github.com/C4Q/AC-iOS/blob/8abefac66b598856f79d0153ff7506a3f474ce3a/lessons/unit2/Unit%202%20Review/README.md)
- [Programmatic View Management](https://github.com/C4Q/AC-iOS/blob/7cbddbbff51de55a7e98597bd96078079e6c5375/lessons/unit4/Programmatic-View-Management/README.md)

### Key Interview Questions

1. What are the different ways to specify how views are arranged inside a UIView?
2. What is AutoLayout? Why is it useful?
3. What is the difference between a view's frame and its bounds?
4. What is content hugging and what is compression resistance?

# 1. View Management

### What are the different ways to specify how views are arranged inside a UIView?

The short answer here is Autolayout or else programatically setting a frame based layout.  

With that being said they may ask you a question like this to gain insight in your a knowledge about UIView's and managing the View Hierarchy.

So just to remind us all:

The UIView is a basic building block for any iOS app. It can be both a container with subviews, that allow you to organize your app screen into parts, as well as something the user can interact with.

 - [UIView Docs](https://developer.apple.com/documentation/uikit/uiview)

Unlike a class hierarchy, which defines the lineage of a class, the view hierarchy defines the layout of views relative to other views.

The UIWindow is the root view of the view hierarchy and provides the surface on which all subviews draw their content. The window instance maintains a reference to a single top-level view instance, call the content view. The content view acts as the root of the visible view hierarchy in a window.

 The view instances enclosed within a view are called subviews. The parent view that encloses a view is referred to as its superview. While a view instance can have multiple subviews, it can have only one superview. In order for a view and its subviews to be visible to the user, the view must be inserted into a window's view hierarchy.

 - [ViewHierarchy Apple](https://developer.apple.com/library/content/documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/WindowsandViews/WindowsandViews.html)

### What is AutoLayout? Why is it useful?

Auto Layout dynamically calculates the size and position of all the views in your view hierarchy, based on constraints placed on those views. Because elements are laid out relative to other elements, resizing is dynamic and a UI looks consistant regardless of screen size. ([Apple](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/index.html))

In order for Auto Layout to work, there must be a continuous set of constraints from the top to the bottom, and from the leading (left) to the trailing (right) edges of the main view. Additionally, every view needs:
- A hight
- A width
- An x position (horizontal)
- A y position (vertical)


Auto Layout is used to control the layout, or visual blocks of content on the screen. It determines the size of a label in addition to where a UI element appears on the screen.

The Storyboard automatically creates Auto Layout constraints for new views (i.e.: a UIButton) that pin the view to it's location. The view does not resize and you can see it remains fixed in both size and position when you rotate. 

### Readings (in Recommended Order)
1. [A Beginner's Guide to AutoLayout w/ Xcode 8 - Appcoda](http://www.appcoda.com/auto-layout-guide/)
2. [Understanding AutoLayout - Apple](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/index.html#//apple_ref/doc/uid/TP40010853-CH7-SW1)
  1. [Anatomy of a Constraint](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/AnatomyofaConstraint.html#//apple_ref/doc/uid/TP40010853-CH9-SW1)


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
<img src="https://github.com/C4Q/AC-iOS/blob/master/lessons/unit4/Programmatic-View-Management/Images/frame-vs-bounds.png" width="414" height="736" />
</p>


## What is content hugging and what is compression resistance?

1. **Content Hugging**: How much content does not want to grow. ([Apple](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/WorkingwithConstraintsinInterfaceBuidler.html#//apple_ref/doc/uid/TP40010853-CH10-SW2))

2. **Compression Resistance**: How much content does not want to shrink. ([Apple](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/WorkingwithConstraintsinInterfaceBuidler.html#//apple_ref/doc/uid/TP40010853-CH10-SW2))

#### Content Hugging/Compression Resistance ([CHCR](https://developer.apple.com/library/content/documentation/UserExperience/Conceptual/AutolayoutPG/WorkingwithConstraintsinInterfaceBuidler.html#//apple_ref/doc/uid/TP40010853-CH10-SW2))
These aren't the easiest concepts to understand, and I think in large part is due to their naming. But thanks to one very perfectly succinct [StackOverflow answer](http://stackoverflow.com/a/16281229/3833368), it's a bit easier:

- **Content Hugging**: How much content does not want to grow
- **Compression Resistance**: How much content does not want to shrink

Meaning:
- The higher the **Content Hugging** value, the more it will try to keep its size you set in IB. Think of it as how tightly the edges of a view are hugging what's inside the view (like how the edges of a `UILabel` are hugging the text inside of it).

- The higher the **Compression Resistance** value, the more it will try to expand the bounds you set in IB.

*Note:* These values are set *relative* to the views that surround it. Meaning, these properties will only matter in cases where constraints do not define an exact width/height for a view, and rather, expect a view to expand/contract based on the sizes of the views around it.

More Readings:
([CHCR](https://medium.com/@abhimuralidharan/ios-content-hugging-and-content-compression-resistance-priorities-476fb5828ef))


## DSA Practice
Pick your poison :)
- [Two-Sum Problem](Two-Sum%20Problem/)
- [Three-Sum/Four-Sum Problem](3Sum%20and%204Sum/)
- [Fizz Buzz](Fizz%20Buzz/)
- [Monty Hall Problem](Monty%20Hall%20Problem/)
- [Finding Palindromes](Palindromes/)
- [Dining Philosophers](DiningPhilosophers/)
- [Egg Drop Problem](Egg%20Drop%20Problem/)
- [Encoding and Decoding Binary Tree](Encode%20and%20Decode%20Tree/)


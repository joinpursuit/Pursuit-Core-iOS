# Views and Bezier Paths

## Objectives

- Override `draw` to draw inside of a UIView
- Create UIBezierPaths

## Resources

- [Apple `draw(_:)` docs](https://developer.apple.com/documentation/uikit/uiview/1622529-draw)
- [Paul Hegarty](https://cursa.app/en/course/ios-by-stanford-paul-hegarty/o_HukQ-IKH8)
- [appcoda](https://www.appcoda.com/bezier-paths-introduction/)

# 1. drawRect

When you create a UIView subclass in Xcode, it generates the following file for you:

```swift
class MyView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
}
```

By default, the `draw` method does nothing.  In the vast majority of cases, you don't need to do anything here.  For things like setting background color or adding subviews, you do not need to use this method.

However, you might be interested in making your own custom images in a way other than adding an existing UIImage.

# 2. Bezier Path

In order to draw shapes manually in iOS, we need to make use of something called a "Bezier Path".  Named after [Pierre Bézier](https://en.wikipedia.org/wiki/Pierre_B%C3%A9zier), Bezier curves are, roughly speaking, ways of specifying how to draw a curved line.  By using `control points`, we can specify the shape of the resulting curve.

The gifs below represent several different curves.  The `t` refers the elapsed time.  Each P<sub>n</sub> is a different control point.  Bezier curves are then drawn on the line generated between control points.

![Drawing curves](https://upload.wikimedia.org/wikipedia/commons/1/15/Bezier_All_anim.gif)

# 3. Drawing a Bezier Path

The link below from appcoda is a great resource for drawing many different types of Bezier Paths:

https://www.appcoda.com/bezier-paths-introduction/
